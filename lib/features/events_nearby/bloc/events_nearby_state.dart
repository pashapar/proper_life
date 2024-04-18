part of 'events_nearby_bloc.dart';

abstract class EventsNearbyState {}

class EventsNearbyInitial extends EventsNearbyState {}

class EventsNearbyLoading extends EventsNearbyState {
  // EventsNearbyLoading({required this.selectedCity, required this.timeFilter});

  // String selectedCity = '';
  // Timestamp timeFilter = Timestamp.now();
}

class EventsNearbyLoaded extends EventsNearbyState {
  EventsNearbyLoaded({required this.eventsList});

  final List<Event> eventsList;
}

class EventsNearbyFailure extends EventsNearbyState {}
