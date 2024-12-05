import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proper_life/domain/event_repository/lib/event_repository.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final EventRepository _event;

  CreateEventBloc({required EventRepository evvent})
      : _event = evvent,
        super(CreateEventInitial()) {
    on<CreateEvent>((event, emit) async {
      emit(CreateEventLoading());
      try {
        if (!state.props.contains(event.evvent)) {
          Evvent evvent = await _event.createEvent(event.evvent);
          emit(CreateEventLoaded(evvent));
        } else {
          print('Dublicate event detected');
        }
      } catch (e) {
        emit(CreateEventFailure());
      }
    });
  }
}
