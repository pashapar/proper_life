import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String eventId;
  String? eventName;
  String? eventDescription;
  String? organiserName;
  String? location;
  String? eventCity;
  Timestamp? dateAndTime;
  String eventImageUrl;

  Event({
    required this.eventId,
    required this.eventName,
    required this.organiserName,
    required this.eventDescription,
    required this.dateAndTime,
    required this.eventCity,
    required this.location,
    required this.eventImageUrl,
  });

 Event.fromJson(this.eventId, Map<String, dynamic> data)
    : eventName = data['eventName'],
      eventDescription = data['eventDescription'],
      organiserName = data['organiserName'],
      dateAndTime = data['dateAndTime'],
      location = data['location'],
      eventCity = data['eventCity'],
      eventImageUrl = data ['eventImageUrl'];
}

class CreateEvent extends Event {
  CreateEvent(
      {required super.eventId,
      required super.eventName,
      required super.organiserName,
      required super.eventDescription,
      required super.dateAndTime,
      required super.eventCity,
      required super.location, 
      required super.eventImageUrl});

  CreateEvent copy() {
    return CreateEvent(
        eventId: eventId,
        eventName: eventName,
        organiserName: organiserName,
        eventDescription: eventDescription,
        dateAndTime: dateAndTime,
        eventCity: eventCity,
        location: location, 
        eventImageUrl: '');
  }

  Map<String, dynamic> toMap() {
    return {
      "eventName": eventName,
      "eventDescription": eventDescription,
      "organiserName": organiserName,
      "dateAndTime": dateAndTime,
      "eventCity": eventCity,
      "location": location,
      "eventImageUrl": eventImageUrl,
    };
  }
}

class MyEvent extends Event {
  MyEvent({required super.eventId, 
  required super.eventName, 
  required super.organiserName, 
  required super.eventDescription, 
  required super.dateAndTime, 
  required super.eventCity, 
  required super.location,
  required this.participates, 
  required super.eventImageUrl});


  List <String> participates;

}