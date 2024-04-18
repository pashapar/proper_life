import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proper_life/domain/event.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/services/database.dart';

class MyEventsList extends StatefulWidget {
  final String userId;

  const MyEventsList({super.key, required this.userId});

  @override
  State<MyEventsList> createState() => _MyEventsListState();
}

class _MyEventsListState extends State<MyEventsList> {
  DatabaseService db = DatabaseService();
  late List<Event> myEvents = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _fetchMyEvents();
    });
  }

  Future<void> _fetchMyEvents() async {
    List<Event> events = await db.fetchMyEvents(widget.userId);
    setState(() {
      myEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        child: myEvents.isEmpty
            ? Text(
                S.of(context).youDontHaveAnyEventsScheduledYetYouCanFind,
                style: theme.textTheme.bodyLarge,
              )
            : ListView.builder(
                itemCount: myEvents.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/myEvents/eventDetails',
                          arguments: myEvents[i]);
                    },
                    child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 16)
                            .copyWith(top: 10),
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.primaryColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    '${myEvents[i].eventName}',
                                    style: theme.textTheme.bodyLarge,
                                    textWidthBasis: TextWidthBasis.longestLine,
                                  ),
                                ),
                                Text(
                                  '${myEvents[i].organiserName}',
                                  style: theme.textTheme.bodyMedium,
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                    width: 95,
                                    height: 95,
                                    child: myEvents[i].eventImageUrl.isEmpty
                                        ? Icon(
                                            Icons.event,
                                            size: 95,
                                            color: theme.primaryColor,
                                          )
                                        : Image.network(
                                            myEvents[i].eventImageUrl)),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: 220,
                                    // height: ,
                                    child: Text(
                                      '${myEvents[i].eventDescription}',
                                      style: theme.textTheme.bodyMedium,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  DateFormat('dd-MM-yyyy HH:mm').format(
                                      myEvents[i].dateAndTime!.toDate()),
                                  style: theme.textTheme.bodySmall,
                                ),
                                SizedBox(
                                  width: 170,
                                  child: Text(
                                    '${myEvents[i].location} | ${myEvents[i].eventCity}',
                                    style: theme.textTheme.bodySmall,
                                    textWidthBasis: TextWidthBasis.longestLine,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  );
                }));
  }
}
