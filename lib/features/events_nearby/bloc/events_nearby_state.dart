part of 'events_nearby_bloc.dart';

class EventsNearbyState {}

class EventsNearbyLoading extends EventsNearbyState {}

class EventsNearbyLoaded extends EventsNearbyState {
  final List<Event> events;

  EventsNearbyLoaded(this.events);
}

class EventsNearbyError extends EventsNearbyState {
  final String errorMessage;

  EventsNearbyError(this.errorMessage);
}

// abstract class EventsNearbyState {}

// class EventsNearbyInitial extends EventsNearbyState {}

// class EventsNearbyLoading extends EventsNearbyState {
//   // EventsNearbyLoading({required this.selectedCity, required this.timeFilter});

//   // String selectedCity = '';
//   // Timestamp timeFilter = Timestamp.now();
// }

// class EventsNearbyLoaded extends EventsNearbyState {
//   EventsNearbyLoaded({required this.eventsList});

//   final List<Event> eventsList;
// }

// class EventsNearbyFailure extends EventsNearbyState {}
