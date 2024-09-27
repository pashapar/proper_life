import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:proper_life/domain/event_repository/lib/src/models/event.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/services/database.dart';
import 'package:proper_life/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsScreen extends StatefulWidget {
  // final Event event;
  const EventDetailsScreen({
    super.key,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  DatabaseService db = DatabaseService();
  User? user = FirebaseAuth.instance.currentUser;
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
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
            Navigator.of(context).pop();
          },
        ),
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                  height: 300,
                  width: 300,
                  child: event.eventImageUrl.isEmpty
                      ? Icon(Icons.event, size: 300, color: theme.primaryColor)
                      : Image.network(
                          event.eventImageUrl,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: Text(
                    '${event.eventName}',
                    style: theme.textTheme.titleSmall!
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    textWidthBasis: TextWidthBasis.longestLine,
                  ),
                ),
                Text(
                  '${event.organiserName}',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
            Container(
                padding: const EdgeInsets.only(top: 10),
                child: Linkify(
                  onOpen: _onOpen,
                  text: '${event.eventDescription}',
                  style: theme.textTheme.bodyLarge,
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateFormat('dd-MM-yyyy HH:mm')
                      .format(event.dateAndTime!.toDate()),
                  // '${event.dateAndTime!.toDate()}',
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    '${event.location} | ${event.eventCity}',
                    style: theme.textTheme.bodyMedium,
                    textWidthBasis: TextWidthBasis.longestLine,
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text(S.of(context).areYouSure),
                          content: Text(S
                              .of(context)
                              .areYouWantDeleteThisEventFromMyEvents),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(S.of(context).cancel)),
                            TextButton(
                                onPressed: () {
                                  if (_isMounted) {
                                    db
                                        .deleteEventToMyEvents(
                                            user!.uid, event.eventId)
                                        .then((value) {
                                      if (_isMounted) {
                                        Navigator.pushReplacementNamed(
                                            context, '/eventNearby');
                                      }
                                    });
                                    setState(() {});
                                  }
                                },
                                child: Text(S.of(context).delete)),
                          ],
                        )),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xff959595),
                  size: 35,
                ))
          ],
        ),
      ),
    );
  }
}
