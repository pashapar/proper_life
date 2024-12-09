import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proper_life/domain/event_repository/lib/event_repository.dart';
import 'package:proper_life/features/events_nearby/home_screen_bloc/home_screen_bloc.dart';
import 'package:proper_life/firebase_options.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/router/router.dart';
import 'package:proper_life/services/firebase_service.dart';
import 'package:proper_life/theme/theme.dart';
import 'package:proper_life/domain/event_repository/lib/src/event_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? languageCode = prefs.getString('language');
  Locale initialLocale = const Locale('en'); // Default to English
  if (languageCode != null) {
    initialLocale = Locale(languageCode);
  }
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EventRepository>(
          create: (context) =>
              EventRepositoryImpl(), // Your concrete repository
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeScreenBloc>(
            create: (context) => HomeScreenBloc(),
          ),
          // Add other BlocProviders here if needed
        ],
        child: MyApp(
          initialLocale: initialLocale,
        ),
      ),
    ),
  );
}

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  final Locale initialLocale;

  const MyApp({required this.initialLocale, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      locale: widget.initialLocale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: theme,
      routes: routes,
    );
  }
}
