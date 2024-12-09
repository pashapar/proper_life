import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proper_life/domain/event_repository/lib/src/models/cities.dart';
import 'package:proper_life/domain/event_repository/lib/src/models/event.dart';
import 'package:proper_life/features/create_event/bloc/create_event_bloc.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/services/database.dart';

class CreateEventScreen extends StatefulWidget {
  final CreateEvvent? createEvent;
  const CreateEventScreen({
    super.key,
    this.createEvent,
  });

  @override
  State<CreateEventScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<CreateEventScreen> {
  final _fbKey = GlobalKey<FormBuilderState>();
  CreateEvvent evvent = CreateEvvent(
      eventId: '',
      eventName: '',
      eventCity: '',
      eventDescription: '',
      location: '',
      dateAndTime: Timestamp.now(),
      organiserName: '',
      eventImageUrl: '');

  String? eventImUrl;
  String orgName = '';

  @override
  void initState() {
    if (widget.createEvent != null) evvent = widget.createEvent!.copy();
    super.initState();
    _fetchUserOrgName();
  }

  void pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    String uniqeFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference imageToUpload = referenceDirImages.child(uniqeFileName);

    try {
      await imageToUpload.putFile(File(file!.path));
      eventImUrl = await imageToUpload.getDownloadURL();
      setState(() {
        evvent.eventImageUrl =
            eventImUrl ?? ''; // Update event object with the image URL
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> _fetchUserOrgName() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          orgName = userData['organiserName'];
          evvent.organiserName =
              orgName; // Update selectedCity with userCity from Firebase
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void saveEvent() async {
      if (_fbKey.currentState!.saveAndValidate()) {
        // Ensure only one event is added to the database
        if (!context.read<CreateEventBloc>().state.props.contains(evvent)) {
          context.read<CreateEventBloc>().add(CreateEvent(evvent)); // Add event
          await DatabaseService()
              .addOrUpdateEvent(evvent); // Save to the database
        } else {
          print('Event already exists in the Bloc state');
        }
      } else {
        print('Error: Event fields are empty');
      }
    }

    return BlocListener<CreateEventBloc, CreateEventState>(
      listener: (context, state) {
        if (state is CreateEventLoaded) {
          Navigator.of(context).pushNamed('/eventNearby');
        } else if (state is CreateEventFailure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Failed to save event. Please try again.')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ProPer life",
            style: theme.textTheme.titleLarge,
          ),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                  Color(0xff9257ff),
                  Color(0xff5900ff),
                ])),
          ),
        ),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, i) {
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 12),
                  child: FormBuilder(
                    autovalidateMode: AutovalidateMode.disabled,
                    initialValue: const {},
                    key: _fbKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  S.of(context).organiserName,
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Text(
                                  orgName,
                                  style: theme.textTheme.bodyLarge!
                                      .copyWith(color: theme.primaryColor),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          child: FormBuilderTextField(
                            initialValue: evvent.eventName,
                            name: 'eventName',
                            decoration: InputDecoration(
                                labelText: S.of(context).writeTheEventName,
                                filled: true,
                                fillColor: theme.cardColor),
                            onChanged: (dynamic val) {
                              evvent.eventName = val;
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          child: DropdownSearch(
                            items: citiesOptions,
                            popupProps: const PopupProps.dialog(
                              showSearchBox: true,
                            ),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              baseStyle: theme.textTheme.bodyLarge,
                              dropdownSearchDecoration: InputDecoration(
                                  labelText: S.of(context).writeTheEventCity,
                                  filled: true,
                                  fillColor: theme.cardColor),
                            ),
                            onChanged: (dynamic val) {
                              evvent.eventCity = val;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          child: FormBuilderTextField(
                            initialValue: evvent.location,
                            onChanged: (dynamic val) {
                              evvent.location = val;
                            },
                            name: 'location',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration: InputDecoration(
                                labelText: S.of(context).writeTheEventLocation,
                                filled: true,
                                fillColor: theme.cardColor),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          child: FormBuilderDateTimePicker(
                            name: 'date&time',
                            firstDate: DateTime.now(),
                            initialValue: evvent.dateAndTime?.toDate(),
                            onChanged: (dynamic val) {
                              if (val != null) {
                                evvent.dateAndTime = Timestamp.fromDate(val);
                              }
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration: InputDecoration(
                                labelText:
                                    S.of(context).choseDayAndTimeWhenEventStart,
                                filled: true,
                                fillColor: theme.cardColor),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          initialValue: evvent.eventDescription,
                          onChanged: (dynamic val) {
                            evvent.eventDescription = val;
                          },
                          name: 'description',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          maxLines: 7,
                          decoration: InputDecoration(
                              labelText: S.of(context).writeTheEventDescription,
                              filled: true,
                              fillColor: theme.cardColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              S.of(context).addContent,
                              style: theme.textTheme.bodyLarge,
                            ),
                            IconButton(
                                onPressed: () {
                                  pickImage();
                                },
                                icon: const Icon(
                                  Icons.attach_file_rounded,
                                  size: 30,
                                  color: Color(0x99000000),
                                ))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            if (eventImUrl != null && eventImUrl!.isNotEmpty)
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.network(
                                  eventImUrl!,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                S.of(context).yourImageWillAppearHereIfYouAddIt,
                                style: theme.textTheme.bodyMedium,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ));
            }),
        // const CreateEventFields(),
        floatingActionButton: SizedBox(
          height: 50.0,
          width: 50.0,
          child: FittedBox(
            child: FloatingActionButton(
                backgroundColor: theme.primaryColor,
                elevation: 5,
                clipBehavior: Clip.hardEdge,
                onPressed: () {
                  if (evvent.eventName!.isEmpty ||
                      evvent.eventCity!.isEmpty ||
                      evvent.eventDescription!.isEmpty ||
                      evvent.location!.isEmpty) {
                    Fluttertoast.showToast(
                        msg: S.of(context).pleaseFillInAllEmptyFields,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: const Color(0xffe7d9ff),
                        textColor: const Color(0xbf000000),
                        fontSize: 16.0);
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text(S.of(context).saveTheEvent),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(S.of(context).cancel)),
                                Builder(builder: (context) {
                                  return TextButton(
                                      onPressed: () {
                                        saveEvent();
                                      },
                                      child: Text(S.of(context).save));
                                })
                              ],
                            ));
                  }
                }
                // _saveEvent();
                // Navigator.of(context).pop();
                ,
                child: const Icon(
                  Icons.check_rounded,
                  size: 35,
                  color: Color(0xfff5f5f5),
                )),
          ),
        ),
      ),
    );
  }
}
