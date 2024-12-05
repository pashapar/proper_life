part of 'events_nearby_bloc.dart';

sealed class EventsNearbyEvent extends Equatable {
  const EventsNearbyEvent();

  @override
  List<Object> get props => [];
}

// abstract class EventsNearbyEvent {}

class LoadEventsNearby extends EventsNearbyEvent {}

class ApplyFilter extends EventsNearbyEvent {
  final String city;
  final Timestamp time;

  const ApplyFilter({required this.city, required this.time});
}

class ClearFilter extends EventsNearbyEvent {}

class EventsNearbyList extends EventsNearbyEvent {
  final List<Evvent> evvent;

  const EventsNearbyList(this.evvent);
}
