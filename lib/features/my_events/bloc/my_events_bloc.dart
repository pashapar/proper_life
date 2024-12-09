import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proper_life/domain/event_repository/lib/event_repository.dart';
import 'package:proper_life/services/database.dart';

part 'my_events_event.dart';
part 'my_events_state.dart';

class MyEventsBloc extends Bloc<MyEventsEvent, MyEventsState> {
  final DatabaseService db;
  MyEventsBloc({required this.db}) : super(MyEventsInitial()) {
    on<MyEventsEvent>((event, emit) async {
      emit(MyEventsLoading());
      try {
        final events =
            await db.fetchMyEvents(FirebaseAuth.instance.currentUser!.uid);
        emit(MyEventsLoaded(events));
      } catch (e) {
        emit(const MyEventsFailure('Failed to fetch events'));
      }
    });
  }
}
