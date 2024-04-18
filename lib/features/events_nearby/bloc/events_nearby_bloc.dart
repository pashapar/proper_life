import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proper_life/domain/event.dart';
import 'package:proper_life/services/database.dart';

part 'events_nearby_state.dart';
part 'events_nearby_event.dart';

DatabaseService db = DatabaseService();
// var events = <Event>[];
String selectedCity = 'Lviv';
Timestamp timeFilter = Timestamp.now();

class EventsNearbyBloc extends Bloc<EventsNearbyEvent, EventsNearbyState> {
  // final DatabaseService db;
  EventsNearbyBloc() : super(EventsNearbyInitial()) {
    on<LoadEventsNearby>((event, emit) async {
      try {
        emit(EventsNearbyLoading(
          // selectedCity: selectedCity, timeFilter: timeFilter
          ));
        final eventsList = db.getEvents(selectedCity, timeFilter) as List<Event>;
        emit(EventsNearbyLoaded(eventsList: eventsList));
      } catch (e) {
        print(e);
      }
      // final eventsList = db.getEvents(selectedCity, timeFilter);
      // emit(EventsNearbyLoaded(eventsList: eventsList as List<Event>));
    });
  }
}
