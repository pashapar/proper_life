part of 'my_events_bloc.dart';

sealed class MyEventsState extends Equatable {
  const MyEventsState();
  
  @override
  List<Object> get props => [];
}

final class MyEventsInitial extends MyEventsState {}

final class MyEventsLoading extends MyEventsState{}

final class MyEventsLoaded extends MyEventsState {
  final List<Evvent> evvent;

  const MyEventsLoaded(this.evvent);
}

final class MyEventsFailure extends MyEventsState {
  final String message;

  const MyEventsFailure(this.message);
}