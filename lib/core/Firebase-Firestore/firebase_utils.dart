import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/event.dart';

class FirebaseUtils {
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
    var eventsCollection = getEventsCollection(); //collection
    DocumentReference<Event> docRef = eventsCollection.doc(); //document
    event.id = docRef.id; //doc id(auto id)
    return docRef.set(event); //add to fireStore
    ///getEventsCollection().doc().set(event);
  }
}
