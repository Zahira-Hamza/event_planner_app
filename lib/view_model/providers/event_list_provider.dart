import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/core/Firebase-Firestore/firebase_auth_utils.dart'; // Add this import
import 'package:flutter/material.dart';

import '../../core/Firebase-Firestore/firebase_utils.dart';
import '../../core/Firebase-Firestore/models/event.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  List<Event> filterEventsList = [];
  int selectedIndex = 0;
  String _searchQuery = "";

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

  void listenToEvents() {
    String? uid = FirebaseAuthUtils.getCurrentUser()?.uid;

    // Added .where to filter events belonging only to the current user
    FirebaseUtils.getEventsCollection()
        .where('userId', isEqualTo: uid)
        .snapshots()
        .listen((querySnapshot) {
          eventsList = querySnapshot.docs.map((doc) => doc.data()).toList();
          _applyFilter();
        });
  }

  void changeSelectedIndex(int newIndex) {
    selectedIndex = newIndex;
    _applyFilter();
  }

  void _applyFilter() {
    if (selectedIndex == 0) {
      filterEventsList = List.from(eventsList);
    } else {
      filterEventsList = eventsList
          .where((event) => event.eventName == eventsName[selectedIndex])
          .toList();
    }
    filterEventsList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    notifyListeners();
  }

  Future<void> toggleFavorite(Event event) async {
    try {
      await FirebaseUtils.updateFavoriteStatus(event.id, !event.isFavorite);
    } catch (e) {
      debugPrint("Error updating favorite: $e");
    }
  }

  List<Event> get favoriteEvents {
    return eventsList.where((event) {
      final isFav = event.isFavorite;
      final matchesSearch = event.title.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return isFav && matchesSearch;
    }).toList()..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
