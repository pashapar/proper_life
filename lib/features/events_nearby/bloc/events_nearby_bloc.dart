import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:proper_life/domain/event_repository/lib/event_repository.dart';
import 'package:proper_life/services/database.dart';

part 'events_nearby_event.dart';
part 'events_nearby_state.dart';

class EventsNearbyBloc extends Bloc<EventsNearbyEvent, EventsNearbyState> {
  final DatabaseService db;

  EventsNearbyBloc({required this.db}) : super(EventsNearbyInitial()) {
    on<EventsNearbyEvent>((event, emit) async {
      emit(EventsNearbyLoading());
      try {
        final city = ''; // Default or fetch user city
        final time = Timestamp.now(); // Default timestamp
        final events = await db.getEvents(city, time).first;
        emit(EventsNearbyLoaded(events));
      } catch (e) {emit (const EventsNearbyFailure('Failed to load events'));}
    });

    on<ApplyFilter>((event, emit) async {
      emit(EventsNearbyLoading());
      try {
        final events = await db.getEvents(event.city, event.time).first;
        emit(EventsNearbyLoaded(events));
      } catch (e) {
        emit(const EventsNearbyFailure('Failed to apply filter'));
      }
    });

    on<ClearFilter>((event, emit) async {
      emit(EventsNearbyLoading());
      try {
        final events = await db.getEvents('', Timestamp.now()).first;
        emit(EventsNearbyLoaded(events));
      } catch (e) {
        emit(const EventsNearbyFailure('Failed to clear filter'));
      }
    });
  }
}
