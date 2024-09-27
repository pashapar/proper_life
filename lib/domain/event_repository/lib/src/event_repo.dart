import 'models/models.dart';

abstract class EventRepository {
  Future<Event> createEvent(Event event);

  Future<List<Event>> getEvent();
}
