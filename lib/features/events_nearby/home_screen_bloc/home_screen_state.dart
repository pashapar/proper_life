part of 'home_screen_bloc.dart';

sealed class HomeScreenState extends Equatable {
  const HomeScreenState();
  
  @override
  List<Object> get props => [];
}

final class HomeScreenInitial extends HomeScreenState {}

final class HomeScreenLoading extends HomeScreenState{}

final class HomeScreenLoaded extends HomeScreenState {
}

final class HomeScreenFailure extends HomeScreenState {
  final String message;

  const HomeScreenFailure(this.message);
}

