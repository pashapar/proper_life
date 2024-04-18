import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:proper_life/features/settings/view/settings_screen.dart';
import 'package:proper_life/firebase_options.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/router/router.dart';
import 'package:proper_life/services/firebase_servive.dart';
import 'package:proper_life/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  
  const MyApp({super.key});



  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // Locale _currentLocale = const Locale('en');

  // void changeLocale(Locale newLocale) {
  //   setState(() {
  //     _currentLocale = newLocale;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    FirebaseService().onListenUser((user) {
      if (user == null) {
        Navigator.of(kNavigatorKey.currentContext!).pushReplacementNamed('/');
        print('no user');
      } else {
        Navigator.of(kNavigatorKey.currentContext!)
            .pushReplacementNamed('/eventNearby');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: kNavigatorKey,
      title: 'Pro Per life',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // locale: locale,
      // const Locale('uk'),
      supportedLocales: S.delegate.supportedLocales,
      theme: theme,
      routes: routes,
    );
  }
}
