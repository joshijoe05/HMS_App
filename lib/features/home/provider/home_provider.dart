import 'package:flutter/material.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/core/theme/colors.dart';

class HomeProvider extends ChangeNotifier {
  UserProvider userProvider;
  HomeProvider(this.userProvider);
  int selectedIndex = 0;
  List<Widget> screens = const [
    // HomeScreen(),
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
    // NotificationsScreen(),
    // ChatUsersScreen(),
  ];

  void changeIndex(int idx) {
    selectedIndex = idx;
    notifyListeners();
  }
}
