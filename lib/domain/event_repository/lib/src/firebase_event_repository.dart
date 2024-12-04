import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proper_life/domain/event_repository/lib/event_repository.dart';

class FirebaseEventRepository implements EventRepository {
  final eventCollection = FirebaseFirestore.instance.collection('events');
  String orgName = FirebaseFirestore.instance.collection('users').doc() as String;

  // Future<void> _fetchUserOrgName() async {
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser != null) {
  //     final userId = currentUser.uid;
  //     final userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .get();
  //     if (userDoc.exists) {
  //       final userData = userDoc.data() as Map<String, dynamic>;
  //         orgName = userData['organiserName'] ??
  //             false;
  //     }
  //   }
  // }

  @override
  Future<Evvent> createEvent(Evvent evvent) {
    try {
      evvent.organiserName = orgName;
    } catch (e) {}
    throw UnimplementedError();
  }

  @override
  Future<List<Evvent>> getEvent() {
    // TODO: implement getEvent
    throw UnimplementedError();
  }
}
