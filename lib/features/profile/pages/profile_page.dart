import 'package:flutter/material.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/core/common/widgets/button.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<ProfileProvider>().getUserProfile();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15).copyWith(bottom: 10),
          child: Consumer<ProfileProvider>(builder: (context, data, _) {
            return data.user != null
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Dimensions.getWidth(context) * 0.75,
                          child: Text(
                            "Profile",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        40.height,
                        Row(
                          children: [
                            Text("Full Name : ", style: textTheme.headlineMedium),
                            20.width,
                            Text(
                              data.user!.fullName,
                              style: textTheme.headlineMedium,
                            ),
                          ],
                        ),
                        20.height,
                        Row(
                          children: [
                            Text("Email : ", style: textTheme.headlineMedium),
                            20.width,
                            Text(
                              data.user!.email,
                              style: textTheme.headlineMedium,
                            ),
                          ],
                        ),
                        20.height,
                        Row(
                          children: [
                            Text("Contact : ", style: textTheme.headlineMedium),
                            20.width,
                            Text(
                              data.user!.contactNumber,
                              style: textTheme.headlineMedium,
                            ),
                          ],
                        ),
                        20.height,
                        Row(
                          children: [
                            Text("Id Number : ", style: textTheme.headlineMedium),
                            20.width,
                            Text(
                              data.user!.email.substring(0, 7).toUpperCase(),
                              style: textTheme.headlineMedium,
                            ),
                          ],
                        ),
                        40.height,
                        CustomButton(
                          onTap: () {
                            context.read<UserProvider>().logout();
                          },
                          title: "Logout",
                        ),
                      ],
                    ),
                  )
                : data.isFetching
                    ? 0.height
                    : Center(
                        child: Text(
                          "Something went wrong",
                          style: textTheme.headlineMedium,
                        ),
                      );
          }),
        ),
      ),
    );
  }
}
