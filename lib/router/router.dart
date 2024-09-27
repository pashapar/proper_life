import 'package:firebase_auth/firebase_auth.dart';
import 'package:proper_life/features/become_organiser/view/become_organiser_screen.dart';
import 'package:proper_life/features/bug_report/bug_report_screen.dart';
import 'package:proper_life/features/event_details/view/event_details_screen.dart';
import 'package:proper_life/features/event_details/view/org_event_details_screen.dart';
import 'package:proper_life/features/events_nearby/view/view.dart';
import 'package:proper_life/features/my_events/my_events.dart';
import 'package:proper_life/features/create_event/event_details.dart';
import 'package:proper_life/features/my_events/widgets/org_my_events_list.dart';
import 'package:proper_life/features/profile/view/profile_screen.dart';
import 'package:proper_life/features/settings/view/settings_screen.dart';
import 'package:proper_life/features/sign_in/view/sign_in_screen.dart';

final routes = {
  '/': (context) => const SignInScreen(),
  '/eventNearby': (context) => const EventNearbyScreen(),
  '/eventNearby/createEvent': (context) => const CreateEventScreen(),
  '/myEvents': (context) => MyEventScreen(
        userId: FirebaseAuth.instance.currentUser!.uid,
      ),
  '/profile': (context) => const ProfileScreen(),
  '/settings': (context) => const SettingsScreen(),
  '/myEvents/eventDetails': (context) => const EventDetailsScreen(),
  '/myEvents/orgMyEvents/orgEventDetails': (context) =>
      const OrgEventDetailsScreen(),
  '/myEvents/orgMyEvents': (context) => OrgMyEvents(
        userId: FirebaseAuth.instance.currentUser!.uid,
      ),
  '/eventNearby/becomeOrganiser': (context) => const BecomeOrganiserScreen(),
  '/eventNearby/bugReport': (context) => const BugReportScreen(),
};
