import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proper_life/components/privacy_policy_dialog.dart';
import 'package:proper_life/generated/l10n.dart';
// import 'package:proper_life/main.dart';
import 'package:proper_life/theme/theme.dart';

class SettingsScreen extends StatefulWidget {
  // final void Function(Locale) onLocaleChanged;
  const SettingsScreen({
    super.key,
  });
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

// Locale locale = Intl.getCurrentLocale() as Locale;

var currentLocale = Intl.getCurrentLocale().toString();

String dropdownValue = '';

List<String> language = <String>['English', 'Ukrainian'];

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    if (currentLocale == const Locale('en').toString()) {
      dropdownValue = 'English';
    } else if (currentLocale == const Locale('uk').toString()) {
      dropdownValue = 'Ukrainian';
    }
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
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                S.of(context).language,
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Color(0xff959595),
                ),
                style: theme.textTheme.bodyMedium,
                onChanged: (String? value) {
                  if (value == 'English') {
                    setState(() {
                      dropdownValue = value!;
                      S.load(const Locale('en'));
                      // widget.onLocaleChanged(const Locale('en'));
                      currentLocale = const Locale('en').toString();
                      // locale = const Locale('en');
                    });
                  } else if (value == 'Ukrainian') {
                    setState(() {
                      dropdownValue = value!;
                      S.load(const Locale('uk'));
                      // widget.onLocaleChanged(const Locale('uk'));
                      currentLocale = const Locale('uk').toString();
                      // locale = const Locale('uk');
                    });
                  }
                },
                items: language.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/eventNearby/becomeOrganiser');
              },
              title: Text(
                S.of(context).becomeAnOrganiser,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.primaryColor,
                  fontSize: 18,
                ),
              )),
          const SizedBox(
            height: 15,
          ),
          ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const PrivacyDialog(
                          mdFileName: 'privacy_policy.md');
                    });
              },
              title: Text(
                S.of(context).privacySecurity,
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                ),
              )),
        ]),
      ),
    );
  }
}
