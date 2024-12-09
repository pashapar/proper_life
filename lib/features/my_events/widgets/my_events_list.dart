import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proper_life/domain/event_repository/lib/src/models/event.dart';
import 'package:proper_life/features/my_events/bloc/my_events_bloc.dart';
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
  late List<Evvent> myEvents = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _fetchMyEvents();
    });
  }

  Future<void> _fetchMyEvents() async {
    List<Evvent> events = await db.fetchMyEvents(widget.userId);
    setState(() {
      myEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<MyEventsBloc, MyEventsState>(builder: ((context, state) {
      if (state is MyEventsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is MyEventsLoaded) {
        final myEvents = state.evvent;
        return myEvents.isEmpty
            ? Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: theme.primaryColor)],
                ),
                child: Text(
                  S.of(context).youDontHaveAnyEventsScheduledYetYouCanFind,
                  style: theme.textTheme.bodyLarge,
                ))
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
                        margin: const EdgeInsets.symmetric(horizontal: 10)
                            .copyWith(top: 10),
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: theme.primaryColor),
                            borderRadius: BorderRadius.circular(15),
                            color: theme.cardColor),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '${myEvents[i].eventName}',
                                    style: theme.textTheme.bodyLarge,
                                    textWidthBasis: TextWidthBasis.longestLine,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
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
                                Expanded(
                                    child: Text(
                                  '${myEvents[i].eventDescription}',
                                  style: theme.textTheme.bodyMedium,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textWidthBasis: TextWidthBasis.longestLine,
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
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    '${myEvents[i].location} | ${myEvents[i].eventCity}',
                                    style: theme.textTheme.bodySmall,
                                    textWidthBasis: TextWidthBasis.longestLine,
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  );
                });
      } else if (state is MyEventsFailure) {
        return Center(
          child: Text(
            'Failed to load events. Please try again.',
            style: theme.textTheme.bodyLarge,
          ),
        );
      }
      return const Center(child: Text('Unexpected state'));
    }));
  }
}
