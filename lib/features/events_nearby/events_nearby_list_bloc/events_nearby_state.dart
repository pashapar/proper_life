part of 'events_nearby_bloc.dart';

sealed class EventsNearbyState extends Equatable {
  const EventsNearbyState();

  @override
  List<Object> get props => [List<Evvent>];
}

final class EventsNearbyInitial extends EventsNearbyState {}

final class EventsNearbyLoading extends EventsNearbyState {}

final class EventsNearbyLoaded extends EventsNearbyState {
  final List<Evvent> evvent;

  const EventsNearbyLoaded(this.evvent);
}

final class EventsNearbyFailure extends EventsNearbyState {
  final String message;

  const EventsNearbyFailure(this.message);
}
