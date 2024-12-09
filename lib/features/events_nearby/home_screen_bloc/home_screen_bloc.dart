import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<LoadHomeScreen>((event, emit) async {
      emit(HomeScreenLoading());
      try {
        emit(HomeScreenLoaded());
      } catch (e) {
        emit(const HomeScreenFailure("Failed to load events"));
      }
    });
  }
}
