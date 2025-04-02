import 'package:flutter/material.dart';
import 'package:hms_app/core/helper/date_time.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/notifications/models/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        if (notification.data != null && notification.data?["busFormId"] != null) {
          router.push(Routes.busForm, extra: notification.data?["busFormId"]);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey200, width: 1.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headlineSmall?.copyWith(fontSize: 18)),
                  5.height,
                  Text(
                    notification.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(color: AppColors.grey600),
                  ),
                ],
              ),
            ),
            10.width,
            Text(
              DateTimeHelper.formatIsoTo24Time(notification.createdAt.toIso8601String()),
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryColor400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
