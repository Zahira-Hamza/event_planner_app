import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/Firebase-Firestore/firebase_utils.dart';
import '../../core/Firebase-Firestore/models/event.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = []; // Private full list
  List<Event> filterEventsList = [];
  int selectedIndex = 0;

  List<String> eventsName = [
    'All'.tr(),
    'Sport'.tr(),
    'Birthday'.tr(),
    'Meeting'.tr(),
    'Gaming'.tr(),
    'WorkShop'.tr(),
    'BookClub'.tr(),
    'Exhibition'.tr(),
    'Holiday'.tr(),
    'Eating'.tr(),
  ];

  // Initialize the stream listener
  void listenToEvents() {
    FirebaseUtils.getEventsCollection().snapshots().listen((querySnapshot) {
      eventsList = querySnapshot.docs.map((doc) => doc.data()).toList();
      _applyFilter(); // Re-filter whenever data changes
    });
  }

  void changeSelectedIndex(int newIndex) {
    selectedIndex = newIndex;
    _applyFilter();
  }

  void _applyFilter() {
    if (selectedIndex == 0) {
      filterEventsList = eventsList;
    } else {
      filterEventsList = eventsList
          .where((event) => event.eventName == eventsName[selectedIndex])
          .toList();
    }
    // Sort by date
    filterEventsList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    notifyListeners();
  }
}
