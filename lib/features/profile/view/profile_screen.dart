import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/theme/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

String usName = '';
String username = '';
String usCity = '';
bool orgStatus = false;
String orgName = '';

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _fetchUserOrgStatus();
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
          orgStatus = userData['organiser'];
          usName = userData['name'];
          username = userData['userName'];
          usCity = userData['userCity'];
          orgName = userData['organiserName'] ??
              ''; // Update selectedCity with userCity from Firebase
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              username,
              style: theme.textTheme.bodyLarge!
                  .copyWith(color: theme.primaryColor, fontSize: 20),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  height: 95,
                  width: 95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xffe7d9ff),
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).verySoonYouWillBeAbleToAddYourPhoto,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      usName,
                      style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      usCity,
                      style: theme.textTheme.bodyMedium!.copyWith(fontSize: 18),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            orgStatus
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        S.of(context).organiserName,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        orgName,
                        style: theme.textTheme.bodyLarge,
                      )
                    ],
                  )
                : const SizedBox(
                    height: 0,
                  ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                S.of(context).settings,
                style: theme.textTheme.bodyMedium,
              ),
              trailing: const Icon(
                Icons.settings_rounded,
                color: Color(0x99d9d9d9),
                size: 30,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/settings');
              },
            )
          ]),
    );
  }
}
