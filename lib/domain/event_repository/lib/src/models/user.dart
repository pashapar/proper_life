import 'package:firebase_auth/firebase_auth.dart';
import 'package:proper_life/domain/event_repository/lib/src/models/event.dart';

class User {
  late String userId;
  late String email;
  late List<Event>? myEvents = [];

  User({
    required this.userId,
    required this.email,
    required this.myEvents
  });
    
//   factory User.fromFirestore(DocumentSnapshot userDoc, UserCredential userCredential) {
//     var data = userDoc.data() as Map<String, dynamic>;

//     // Initialize myEvents with an empty list if it's null
//     List<Event> myEvents = [];
//     if (data['myEvents'] != null) {
//       List<dynamic> myEventsData = data['myEvents'];
//       myEvents = myEventsData.map((eventData) {
//         String eventId = eventData['eventId']; // Assuming eventId is a field in eventData
//         return Event.fromJson(eventId, eventData);
//       }).toList();
//     }

//   return User(
//     userId: userCredential.user!.uid,
//     email: userCredential.user!.email!,
//     myEvents: myEvents,
//   );
// }
     
  factory User.fromFirebase(UserCredential userCredential) {
    return User(
      userId: userCredential.user!.uid,
      email: userCredential.user!.email!,
      myEvents: []
    );
  }
}

