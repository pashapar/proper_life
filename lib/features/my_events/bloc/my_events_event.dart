part of 'my_events_bloc.dart';

sealed class MyEventsEvent extends Equatable {
  const MyEventsEvent();

  @override
  List<Object> get props => [];
}

class LoadMyEvents extends MyEventsEvent {}



class ClearFilter extends MyEventsEvent {}

class MyEvventsList extends MyEventsEvent {
  final List<Evvent> evvent;

  const MyEvventsList(this.evvent);
}