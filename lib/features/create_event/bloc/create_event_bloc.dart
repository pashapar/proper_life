// import 'dart:html';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import 'package:proper_life/domain/event_repository/lib/src/event_repo.dart';
// import 'package:proper_life/domain/event_repository/lib/src/models/event.dart';

// part 'create_event_event.dart';
// part 'create_event_state.dart';

// class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
//   EventRepository _event;

//   CreateEventBloc({required EventRepository event})
//       : _event = event,
//         super(CreateEventInitial()) {
//     on<CreateEventEvent>((event, emit) async {
//       emit(CreateEventLoading());
//       try {
//         Event event = await _event.createEvent(event.event);
//         CreateEventLoaded(event);
//       } catch (e) {
//         emit(CreateEventFailure());
//       }
//     });
//   }
// }
