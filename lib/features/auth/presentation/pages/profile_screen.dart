import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/back_button.dart';
import 'package:hms_app/core/common/widgets/button.dart';
import 'package:hms_app/core/common/widgets/dropdown.dart';
import 'package:hms_app/core/common/widgets/text_field.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        authProvider.nameController.addListener(_updateState);
        authProvider.phoneController.addListener(_updateState);
      },
    );
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    authProvider.nameController.removeListener(_updateState);
    authProvider.phoneController.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(
                  onTap: () {
                    router.pop();
                  },
                ),
                15.height,
                Text(
                  "Profile Setup",
                  style: textTheme.headlineMedium,
                ),
                10.height,
                Text(
                  "Set up your profile and enter required details.",
                  style: textTheme.bodySmall?.copyWith(fontSize: 15, color: AppColors.grey600),
                ),
                50.height,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      heading: "Name",
                      textEditingController: authProvider.nameController,
                      hintText: "Enter your full name",
                    ),
                    20.height,
                    CustomTextField(
                      heading: "Phone",
                      textEditingController: authProvider.phoneController,
                      hintText: "Enter phone number",
                      keyboardType: TextInputType.phone,
                    ),
                    20.height,
                    // dropdown
                    Consumer<AuthProvider>(builder: (context, data, _) {
                      return CustomDropDownButton(
                        showHeading: true,
                        heading: "Hostel",
                        onChanged: data.onHostelChanged,
                        items: ["Hostel1", "Hostel2", "Hostel3"],
                        item: data.hostelId,
                      );
                    }),
                  ],
                ),
                (Dimensions.getHeight(context) * 0.2).round().height,
                Consumer<AuthProvider>(builder: (context, data, _) {
                  return CustomButton(
                    isEnabled: authProvider.nameController.text.trim().isNotEmpty &&
                        authProvider.phoneController.text.trim().isNotEmpty &&
                        authProvider.hostelId != null,
                    onTap: () async {
                      if (authProvider.phoneController.text.length != 10) {
                        SnackbarService.showSnackbar("Phone number should be of 10 digits");
                        return;
                      }
                      await authProvider.signUp();
                    },
                    title: "SignUp",
                  );
                }),
                15.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
