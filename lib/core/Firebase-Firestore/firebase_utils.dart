import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/event.dart';
import 'models/user_model.dart';

class FirebaseUtils {
  // --- Events Collection ---
  static CollectionReference<Event> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromJson(snapshot.data()!),
          toFirestore: (event, options) => event.toJson(),
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    var eventsCollection = getEventsCollection();
    DocumentReference<Event> docRef = eventsCollection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  // FIXED: Added the missing updateFavoriteStatus method
  static Future<void> updateFavoriteStatus(String eventId, bool isFavorite) {
    return getEventsCollection().doc(eventId).update({
      'isFavorite': isFavorite,
    });
  }

  // --- Users Collection ---
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static Future<void> addUserToFireStore(UserModel user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<UserModel?> getUserFromFireStore(String uid) async {
    var doc = await getUsersCollection().doc(uid).get();
    return doc.data();
  }

  static Future<void> updateUserPhoto(String uid, String photoUrl) {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .doc(uid)
        .update({'photoUrl': photoUrl});
  }
}
