import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proper_life/domain/event.dart';
import 'package:proper_life/services/database.dart';

part 'events_nearby_state.dart';
part 'events_nearby_event.dart';

class EventsNearbyBloc extends Bloc<EventsNearbyEvent, EventsNearbyState> {
  final DatabaseService db = DatabaseService();

  EventsNearbyBloc() : super(EventsNearbyLoading());

  String selectedCity = '';
  String selectedTimeFilter = DateTime.now().toString();
  DateFormat selectedTime = DateFormat('dd-MM-yyyy HH:mm');
  Timestamp timeFilter = Timestamp.now();
  bool orgStatus = false;
  dynamic myEventsList = [];
  var addEventIcon = false;
  var filterHeight = 0.0;

  Future<void> _fetchUserCity() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        {
          selectedCity = userData['userCity'];
          orgStatus = userData['organiser'];
          myEventsList = userData['myEvents'] ??
              ''; // Update selectedCity with userCity from Firebase;
        }
      }
    }

    void initFilterValues() async {
      await _fetchUserCity();
      selectedTimeFilter =
          DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

      void applyFilter() {
        // setState(() {
        selectedCity;
        selectedTimeFilter =
            DateFormat('dd-MM-yyyy HH:mm').format(timeFilter.toDate());
        // .toString();
        filterHeight = 0;
        // loadData();
        // });
      }

      void clearFilter() {
        initFilterValues();
        selectedCity = _fetchUserCity().toString();
        timeFilter = Timestamp.now();
        selectedTimeFilter =
            DateFormat('dd-MM-yyyy HH:mm').format(timeFilter.toDate());
        filterHeight = 0;
      }

      void refreshData() {
        // Implement data refresh logic
      }

      @override
      Stream<EventsNearbyState> mapEventToState(
          EventsNearbyEvent event) async* {
        try {
          if (event == EventsNearbyEvent.loadEvents) {
            yield EventsNearbyLoading();
            final events = await db.getEvents(selectedCity, timeFilter);
            yield EventsNearbyLoaded(events as List<Event>);
          } else if (event == EventsNearbyEvent.applyFilter) {
            applyFilter();
          } else if (event == EventsNearbyEvent.clearFilter) {
            clearFilter();
          } else if (event == EventsNearbyEvent.refreshData) {
            final events = await db.getEvents(selectedCity, timeFilter);
            yield EventsNearbyLoaded(events as List<Event>);
          }
        } catch (e) {
          yield EventsNearbyError('An error occurred: $e');
        }
      }
    }
  }

// DatabaseService db = DatabaseService();
// // var events = <Event>[];
// String selectedCity = 'Lviv';
// Timestamp timeFilter = Timestamp.now();

// class EventsNearbyBloc extends Bloc<EventsNearbyEvent, EventsNearbyState> {
//   // final DatabaseService db;
//   EventsNearbyBloc() : super(EventsNearbyInitial()) {
//     on<LoadEventsNearby>((event, emit) async {
//       try {
//         emit(EventsNearbyLoading(
//           // selectedCity: selectedCity, timeFilter: timeFilter
//           ));
//         final eventsList = db.getEvents(selectedCity, timeFilter) as List<Event>;
//         emit(EventsNearbyLoaded(eventsList: eventsList));
//       } catch (e) {
//         print(e);
//       }
//       // final eventsList = db.getEvents(selectedCity, timeFilter);
//       // emit(EventsNearbyLoaded(eventsList: eventsList as List<Event>));
//     });
//   }
// }
}
