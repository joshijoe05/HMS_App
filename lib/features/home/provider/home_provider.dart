import 'package:flutter/material.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/complaints/pages/view_complaints_page.dart';
import 'package:hms_app/features/profile/pages/profile_page.dart';

class HomeProvider extends ChangeNotifier {
  UserProvider userProvider;
  HomeProvider(this.userProvider);
  int selectedIndex = 0;
  List<Widget> screens = const [
    ViewComplaintsPage(),
    Scaffold(
        body: Padding(
      padding: EdgeInsets.all(15.0),
      child: Center(
          child: Text(
        "We are building something great for the next update 🎉 ! Catch you soon 🙌🏻",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: AppColors.grey900,
        ),
      )),
    )),
    ProfilePage(),
  ];

  void changeIndex(int idx) {
    selectedIndex = idx;
    notifyListeners();
  }
}
