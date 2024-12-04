import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proper_life/domain/event_repository/lib/src/models/event.dart';
import 'package:proper_life/features/my_events/widgets/widgets.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/services/database.dart';
import 'package:proper_life/theme/theme.dart';

class MyEventScreen extends StatefulWidget {
  final String userId;
  const MyEventScreen({super.key, required this.userId});

  @override
  State<MyEventScreen> createState() => _MyEventScreenState();
}

class _MyEventScreenState extends State<MyEventScreen> {
  late User user;
  bool orgStatus = false;

  DatabaseService db = DatabaseService();
  late List<Evvent> myEvents = [];

  @override
  void initState() {
    super.initState();
    _fetchUserOrgStatus();
    orgStatus;
  }

  Future<void> _fetchUserOrgStatus() async {
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
          orgStatus = userData['organiser'] ??
              false; // Update selectedCity with userCity from Firebase
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        orgStatus
            ? SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/myEvents/orgMyEvents');
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffe7d9ff))),
                      child: Text(
                        S.of(context).createdByMe,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              )
            : const SizedBox(
                height: 0,
              ),
        Expanded(
            child: MyEventsList(
          userId: FirebaseAuth.instance.currentUser!.uid,
        ))
      ],
    );
  }
}
