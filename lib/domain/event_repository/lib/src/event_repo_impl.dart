import 'package:proper_life/domain/event_repository/lib/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  @override
  Future<Evvent> createEvent(Evvent evvent) async {
    // Simulate database save operation
    print('Saving event: ${evvent.eventName}');
    return evvent;
  }

  @override
  Future<List<Evvent>> getEvent() async {
    // Simulate fetching events from a database
    return [];
  }
}