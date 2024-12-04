part of 'create_event_bloc.dart';


sealed class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override
  List<Object> get props => [];
}

class CreateEvent extends CreateEventEvent {
  final Evvent evvent;

  const CreateEvent(this.evvent);
}
