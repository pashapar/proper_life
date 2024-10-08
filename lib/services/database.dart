import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proper_life/domain/event_repository/lib/src/models/event.dart';

class DatabaseService {
  final CollectionReference _eventsCollection =
      FirebaseFirestore.instance.collection('events');
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future addDocId(CreateEvent createEvent) async {
    return await _eventsCollection
        .doc(_eventsCollection.id)
        .set(createEvent.eventId);
  }

  Future addOrUpdateEvent(CreateEvent createEvent) async {
    return await _eventsCollection.doc().set(createEvent.toMap());
  }

  Future<void> deleteEvent(String eventId) async {
    await _eventsCollection.doc(eventId).delete();
  }

  Stream<List<Event>> getEvents(String selectedCity, Timestamp timeFilter) {
    
    Query query = _eventsCollection;
    if (selectedCity.isNotEmpty) {
      query = query.where('eventCity', isEqualTo: selectedCity);
    }
    if (timeFilter != Timestamp.now()) {
      query = query.where('dateAndTime', isGreaterThan: timeFilter);
    }

    return query.orderBy('dateAndTime').snapshots().map((QuerySnapshot data) =>
        data
            .docs
            .map((DocumentSnapshot doc) =>
                Event.fromJson(doc.id, doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<Event>> getMyEvents(String orgName) {
    Query query = _eventsCollection;
    if (orgName.isNotEmpty) {
      query = query.where('organiserName', isEqualTo: orgName);
    }

    return query.orderBy('dateAndTime').snapshots().map((QuerySnapshot data) =>
        data
            .docs
            .map((DocumentSnapshot doc) =>
                Event.fromJson(doc.id, doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> addEventToMyEvents(String userId, String eventId) async {
    await _db.collection('users').doc(userId).update({
      'myEvents': FieldValue.arrayUnion([eventId]),
    });
  }

  Future<void> deleteEventToMyEvents(String userId, String eventId) async {
    await _db.collection('users').doc(userId).update({
      'myEvents': FieldValue.arrayRemove([eventId]),
    });
  }

  Future<List<Event>> fetchMyEvents(String userId) async {
    List<Event> myEvents = [];
    var userDoc = await _db.collection('users').doc(userId).get();
    List<String> eventIds = List<String>.from(userDoc['myEvents']);

    for (String eventId in eventIds) {
      var eventDoc = await _db.collection('events').doc(eventId).get();
      if (eventDoc.exists) {
        // Use data() method to access the document data
        myEvents.add(
            Event.fromJson(eventId, eventDoc.data() as Map<String, dynamic>));
      }
    }

    return myEvents;
  }
}
