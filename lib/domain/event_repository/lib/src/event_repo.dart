import 'models/models.dart';

abstract class EventRepository {
  Future<Evvent> createEvent(Evvent evvent);

  Future<List<Evvent>> getEvent();
}
