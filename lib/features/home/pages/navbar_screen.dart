import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      bottomNavigationBar: GNav(
        selectedIndex: context.read<HomeProvider>().selectedIndex,
        onTabChange: (int value) => context.read<HomeProvider>().changeIndex(value),
        backgroundColor: Colors.white,
        gap: 8,
        tabMargin: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
        iconSize: 24,
        padding: const EdgeInsets.all(20),
        textStyle: textTheme.bodyMedium,
        tabBackgroundColor: AppColors.primaryColor50,
        tabs: const [
          GButton(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            icon: Icons.warning_amber_rounded,
            iconColor: AppColors.warningColor500,
            iconActiveColor: Colors.amber,
            text: "Complaints",
          ),
          GButton(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            icon: Icons.directions_bus,
            iconColor: AppColors.successColor500,
            iconActiveColor: AppColors.successColor700,
            text: "Buses",
          ),
          GButton(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            icon: Icons.notifications_on_outlined,
            iconColor: AppColors.primaryColor400,
            iconActiveColor: AppColors.primaryColor900,
            text: "Notifications",
          ),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, data, child) {
          return data.screens[data.selectedIndex];
        },
      ),
    );
  }
}
