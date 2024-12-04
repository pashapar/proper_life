part of 'create_event_bloc.dart';


sealed class CreateEventState extends Equatable {
  const CreateEventState();

  @override
  List<Object> get props => [];
}

final class CreateEventInitial extends CreateEventState {}

final class CreateEventLoading extends CreateEventState {}

final class CreateEventLoaded extends CreateEventState {
  final Evvent evvent;

  const CreateEventLoaded(this.evvent);
}

final class CreateEventFailure extends CreateEventState {}
