import 'package:flutter/material.dart';
import 'package:proper_life/features/become_organiser/widgets/social_media_row_widget.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/theme/theme.dart';

class BugReportScreen extends StatelessWidget {
  const BugReportScreen({super.key});

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
          margin: const EdgeInsets.all(5),
          child: Column(children: <Widget>[
            SizedBox(
              height: 25,
              child: Center(
                child: Text(
                  S.of(context).foundABugOrWantToTellUsAboutYour,
                  textWidthBasis: TextWidthBasis.parent,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.primaryColor, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              S.of(context).writeToUsInAWayConvenientForYouWe,
              style: theme.textTheme.bodyLarge,
              textWidthBasis: TextWidthBasis.parent,
            ),
            const SizedBox(
              height: 20,
            ),
            const SocialMediaRow(),
          ]),
        ));
  }
}
