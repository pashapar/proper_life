import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:proper_life/domain/cities.dart';
import 'package:proper_life/domain/event.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/services/database.dart';
import 'package:proper_life/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/events_nearby_bloc.dart';

class EventsNearbyList extends StatefulWidget {
  const EventsNearbyList({
    Key? key,
  }) : super(key: key);

  @override
  State<EventsNearbyList> createState() => _EventsNearbyListState();
}

class _EventsNearbyListState extends State<EventsNearbyList> {
  DatabaseService db = DatabaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // late final EventsNearbyBloc _eventsNearbyBloc;
  // final _eventsNearbyListBloc = EventsNearbyBloc();

  var events = <Event>[];
  User? user;
  String selectedCity = '';
  String selectedTimeFilter = DateTime.now().toString();
  DateFormat selectedTime = DateFormat('dd-MM-yyyy HH:mm');
  Timestamp timeFilter = Timestamp.now();
  bool orgStatus = false;
  dynamic myEventsList = [];
  var addEventIcon = false;
  var filterHeight = 0.0;

  @override
  void initState() {
    initFilterValues();
    // _eventsNearbyListBloc.add(LoadEventsNearby());
    // _eventsNearbyBloc = EventsNearbyBloc();
    // _eventsNearbyBloc.add(EventsNearbyEvent.loadEvents);
    loadData();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _eventsNearbyBloc.close();
  //   super.dispose();
  // }

  void initFilterValues() async {
    await _fetchUserCity();
    selectedTimeFilter = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    // DateTime.now().toString();
    loadData();
  }

  void applyFilter() {
    setState(() {
      // EventsNearbyEvent.applyFilter;
      selectedCity;
      // DateFormat('dd-MM-yyyy HH:mm').format(timeFilter.toDate());
      selectedTimeFilter =
          DateFormat('dd-MM-yyyy HH:mm').format(timeFilter.toDate());
      // .toString();
      filterHeight = 0;
      loadData();
    });
  }

  void clearFilter() {
    setState(() {
      // EventsNearbyEvent.clearFilter;
      initFilterValues();
      selectedCity = _fetchUserCity().toString();
      timeFilter = Timestamp.now();
      selectedTimeFilter =
          DateFormat('dd-MM-yyyy HH:mm').format(timeFilter.toDate());
      filterHeight = 0;
      loadData();
    });
  }

  Future<void> _fetchUserCity() async {
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
          selectedCity = userData['userCity'];
          orgStatus = userData['organiser'];
          myEventsList = userData['myEvents'] ??
              ''; // Update selectedCity with userCity from Firebase
        });
      }
    }
  }

  Future<void> refreshData() async {
    // Fetch new data
    List<String>? newData = await loadData();
    if (newData != null) {
      events = newData as List<Event>;
    }
  }

  loadData() async {
    // _eventsNearbyListBloc.add(LoadEventsNearby());
    Center(
      child: CircularProgressIndicator(
        color: theme.primaryColor,
      ),
    );
    var stream = db.getEvents(selectedCity, timeFilter);
    stream.listen((List<Event> data) {
      setState(() {
        events = data;
      });
    });
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var filterForm = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      curve: Curves.decelerate,
      height: filterHeight,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
      child: Column(children: <Widget>[
        SizedBox(
          height: 60,
          child: DropdownSearch(
            items: citiesOptions,
            popupProps: const PopupProps.dialog(
              showSearchBox: true,
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: theme.textTheme.bodyLarge,
              dropdownSearchDecoration:
                  const InputDecoration(labelText: 'Write the event city...'),
            ),
            onChanged: (dynamic val) {
              selectedCity = val;
            },
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
            initialValue: timeFilter.toDate(),
            onChanged: (dynamic val) {
              if (val != null) {
                timeFilter = Timestamp.fromDate(val);
              }
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            decoration: const InputDecoration(
                labelText: 'Chose day and time when event start'),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  clearFilter();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffae82ff)),
                child: Text(
                  'Clear',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: const Color(0xfff5f5f5)),
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      applyFilter();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff5900ff)),
                    child: Text(
                      'Apply',
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: const Color(0xfff5f5f5)),
                    ))),
          ],
        )
      ]),
    );

    var filterInfo = Padding(
      padding: const EdgeInsets.symmetric(
        // vertical: 5,
        horizontal: 15,
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(S.of(context).citySelectedcity(selectedCity)),
            Text(S.of(context).timeSelectedtimefilter(selectedTimeFilter)),
            IconButton(
              icon: const Icon(Icons.filter_alt_rounded),
              color: const Color(0xffae82ff),
              onPressed: () {
                setState(() {
                  filterHeight = (filterHeight == 0.0
                      ? filterHeight = 180.0
                      : filterHeight = 0.0);
                });
              },
            )
          ],
        ),
      ),
    );

    var eventCard = ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, i) {
        return Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: theme.primaryColor))),
          width: double.infinity,
          padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    child: Text(
                      '${events[i].eventName}',
                      style: theme.textTheme.bodyLarge,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  ),
                  Text(
                    '${events[i].organiserName}',
                    style: theme.textTheme.bodyMedium,
                  )
                ],
              ),
              Linkify(
                onOpen: _onOpen,
                text: '${events[i].eventDescription}',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget>[
                  Center(
                      child: SizedBox(
                          height: 250,
                          width: 250,
                          child: events[i].eventImageUrl.isEmpty
                              ? Icon(Icons.event,
                                  size: 250, color: theme.primaryColor)
                              : Image.network(
                                  events[i].eventImageUrl,
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
                                ))),
                  myEventsList.contains(events[i].eventId)
                      ? Column(
                          children: <Widget>[
                            Icon(
                              Icons.check_circle_outline_rounded,
                              size: 46,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(
                              height: 25,
                            )
                          ],
                        )
                      : IconButton(
                          key: Key(events[i].eventId),
                          isSelected: addEventIcon,
                          padding: const EdgeInsets.only(bottom: 25),
                          icon: Icon(
                            Icons.add_circle_rounded,
                            size: 46,
                            color: theme.primaryColor,
                          ),
                          selectedIcon: Icon(
                            Icons.check_circle_outline_rounded,
                            size: 46,
                            color: theme.primaryColor,
                          ),
                          onPressed: () {
                            User? user = _auth.currentUser;
                            if (user != null) {
                              db.addEventToMyEvents(
                                  user.uid, events[i].eventId);
                              setState(() {
                                myEventsList.add(events[i].eventId);
                                // addEventIcon = !addEventIcon;
                              });
                            }
                          },
                        ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    DateFormat('dd-MM-yyyy HH:mm')
                        .format(events[i].dateAndTime!.toDate()),
                    // '${events[i].dateAndTime!.toDate()}',
                    style: theme.textTheme.bodySmall,
                  ),
                  SizedBox(
                    width: 170,
                    child: Text(
                      textWidthBasis: TextWidthBasis.longestLine,
                      '${events[i].location} | ${events[i].eventCity}',
                      style: theme.textTheme.bodySmall,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        );
      },
    );
    
    // return BlocBuilder<EventsNearbyBloc, EventsNearbyState>(
    //   bloc: _eventsNearbyBloc,
    //   builder: (context, state)
    //   {
    //     if (state is EventsNearbyLoading) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     } else if (state is EventsNearbyLoaded) {
    //       return Scaffold(
    //         body: eventCard,
    //         floatingActionButton: orgStatus
    //         ? SizedBox(
    //             height: 50.0,
    //             width: 50.0,
    //             child: FittedBox(
    //               child: FloatingActionButton(
    //                   backgroundColor: theme.primaryColor,
    //                   elevation: 5,
    //                   clipBehavior: Clip.hardEdge,
    //                   onPressed: () {
    //                     Navigator.of(context)
    //                         .pushNamed('/eventNearby/createEvent');
    //                   },
    //                   child: const Icon(
    //                     Icons.add_rounded,
    //                     size: 35,
    //                     color: Color(0xfff5f5f5),
    //                   )),
    //             ),
    //           )
    //         : const SizedBox(
    //             height: 0,
    //             width: 0,
    //           ));
    //         // Your event list widget where you display events
    //     } else if (state is EventsNearbyError) {
    //       return Center(
    //         child: Text(state.errorMessage),
    //       );
    //     } else {
    //       return Container(); // Handle other states if needed
    //     }
    //   },);
    return Scaffold(
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: Column(
            children: [
              filterInfo,
              filterForm,
              Expanded(
                child: eventCard,
              ),
            ],
          ),
        ),
        floatingActionButton: orgStatus
            ? SizedBox(
                height: 50.0,
                width: 50.0,
                child: FittedBox(
                  child: FloatingActionButton(
                      backgroundColor: theme.primaryColor,
                      elevation: 5,
                      clipBehavior: Clip.hardEdge,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/eventNearby/createEvent');
                      },
                      child: const Icon(
                        Icons.add_rounded,
                        size: 35,
                        color: Color(0xfff5f5f5),
                      )),
                ),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ));
  }
}
