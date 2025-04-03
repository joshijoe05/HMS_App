import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hms_app/core/helper/date_time.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/notifications/models/notification_model.dart';
import 'package:hms_app/features/notifications/provider/notification_provider.dart';
import 'package:hms_app/features/notifications/widgets/notification_tile.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late NotificationProvider notificationProvider;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    notificationProvider = context.read<NotificationProvider>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        notificationProvider.clear();
        notificationProvider.getNotifiactions();
        _scrollController.addListener(
          () async {
            if (mounted) {
              if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
                await notificationProvider.getNotifiactions();
              }
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15).copyWith(bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Dimensions.getWidth(context) * 0.75,
                    child: Text(
                      "Notifications",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      router.push(Routes.profile);
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor900,
                      child: Center(
                        child: Icon(
                          Icons.person_2_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              20.height,
              Expanded(
                child: Consumer<NotificationProvider>(
                  builder: (context, data, _) {
                    return data.isLoading
                        ? 0.height
                        : data.notifications.isEmpty
                            ? Center(
                                child: Text(
                                  "No notifications yet !",
                                  style: textTheme.headlineLarge,
                                ),
                              )
                            : GroupedListView<NotificationModel, String>(
                                controller: _scrollController,
                                elements: data.notifications,
                                order: GroupedListOrder.DESC,
                                groupBy: (element) =>
                                    DateTimeHelper.formatDateToDayMonthYear(element.createdAt.toIso8601String()),
                                groupSeparatorBuilder: (value) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      value,
                                      style: textTheme.bodyMedium?.copyWith(color: AppColors.grey500),
                                    ),
                                  );
                                },
                                itemBuilder: (context, element) {
                                  return NotificationTile(
                                    notification: element,
                                  );
                                },
                              );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
