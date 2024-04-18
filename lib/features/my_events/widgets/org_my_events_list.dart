import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proper_life/domain/event.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/services/database.dart';
import 'package:proper_life/theme/theme.dart';

class OrgMyEvents extends StatefulWidget {
  final String userId;
  const OrgMyEvents({super.key, required this.userId});

  @override
  State<OrgMyEvents> createState() => _OrgMyEventsState();
}

DatabaseService db = DatabaseService();
// final FirebaseAuth _auth = FirebaseAuth.instance;
var eventsOrg = <Event>[];
String orgName = '';

class _OrgMyEventsState extends State<OrgMyEvents> {
  @override
  void initState() {
    super.initState();
    initOrgName();
    _fetchUserOrgName();
    loadData();
  }

  loadData() async {
    var stream = db.getMyEvents(orgName);
    stream.listen((List<Event> data) {
      setState(() {
        eventsOrg = data;
      });
    });
  }

  void initOrgName() async {
    await _fetchUserOrgName();
    orgName;
    loadData();
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
          orgName = userData['organiserName'] ??
              ''; // Update selectedCity with userCity from Firebase
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
              child: Center(
                  child: Text(
                S.of(context).createdByMeOrgname(orgName),
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: theme.primaryColor),
              )),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: eventsOrg.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            '/myEvents/orgMyEvents/orgEventDetails',
                            arguments: eventsOrg[i]);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      '${eventsOrg[i].eventName}',
                                      style: theme.textTheme.bodyLarge,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                    ),
                                  ),
                                  Text(
                                    '${eventsOrg[i].organiserName}',
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
                                      child: eventsOrg[i].eventImageUrl.isEmpty
                                          ? Icon(
                                              Icons.event,
                                              size: 95,
                                              color: theme.primaryColor,
                                            )
                                          : Image.network(
                                              eventsOrg[i].eventImageUrl)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 220,
                                    // height: ,
                                    child: Text(
                                      '${eventsOrg[i].eventDescription}',
                                      style: theme.textTheme.bodyMedium,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    DateFormat('dd-MM-yyyy HH:mm').format(
                                        eventsOrg[i].dateAndTime!.toDate()),
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  SizedBox(
                                    width: 170,
                                    child: Text(
                                      '${eventsOrg[i].location} | ${eventsOrg[i].eventCity}',
                                      style: theme.textTheme.bodySmall,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    );
                  }),
            )
          ],
        ));
  }
}
