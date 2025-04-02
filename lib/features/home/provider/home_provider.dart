import 'package:flutter/material.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/features/bus/pages/bus_selection_page.dart';
import 'package:hms_app/features/complaints/pages/view_complaints_page.dart';
import 'package:hms_app/features/notifications/pages/notifications_page.dart';

class HomeProvider extends ChangeNotifier {
  UserProvider userProvider;
  HomeProvider(this.userProvider);
  int selectedIndex = 0;
  List<Widget> screens = const [
    ViewComplaintsPage(),
    BusSelectionPage(),
    NotificationsPage(),
  ];

  void changeIndex(int idx) {
    selectedIndex = idx;
    notifyListeners();
  }
}
