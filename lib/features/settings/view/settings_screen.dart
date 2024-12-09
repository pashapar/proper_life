import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proper_life/components/privacy_policy_dialog.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

var currentLocale = Intl.getCurrentLocale().toString();

String dropdownValue = '';

List<String> language = <String>['English', 'Ukrainian'];

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  void _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('language');
    setState(() {
      if (languageCode == 'en') {
        dropdownValue = 'English';
      } else if (languageCode == 'uk') {
        dropdownValue = 'Ukrainian';
      } else {
        dropdownValue = 'English'; // Default value
      }
    });
  }

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
      body: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: theme.cardColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
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
                onChanged: (String? value) async {
                  final prefs = await SharedPreferences.getInstance();
                  if (value == 'English') {
                    setState(() {
                      dropdownValue = value!;
                      S.load(const Locale('en'));
                      currentLocale = const Locale('en').toString();
                    });
                    await prefs.setString('language', 'en');
                  } else if (value == 'Ukrainian') {
                    setState(() {
                      dropdownValue = value!;
                      S.load(const Locale('uk'));
                      currentLocale = const Locale('uk').toString();
                    });
                    await prefs.setString('language', 'uk');
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
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              color: theme.cardColor, borderRadius: BorderRadius.circular(10)),
          child: ListTile(
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
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              color: theme.cardColor, borderRadius: BorderRadius.circular(10)),
          child: ListTile(
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
        ),
      ]),
    );
  }
}
