import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/notifications/models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  ApiRepository apiRepository;
  NotificationProvider(this.apiRepository);

  int notificationPage = 1;
  bool hasMoreNotifications = true;
  bool isLoading = false;
  List<NotificationModel> notifications = [];

  void clear() {
    notificationPage = 1;
    hasMoreNotifications = true;
    isLoading = false;
    notifications = [];
    notifyListeners();
  }

  Future<void> getNotifiactions() async {
    try {
      if (isLoading || !hasMoreNotifications) return;
      EasyLoading.show();
      isLoading = true;
      final res = await apiRepository.get(url: "${ApiEndpoints.getNotifications}?page=$notificationPage");
      final body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (body['data']['notifications'].isEmpty) {
          hasMoreNotifications = false;
        } else {
          notifications.addAll((body['data']['notifications'] as List).map(
            (e) => NotificationModel.fromJson(e),
          ));
          notificationPage++;
        }
      } else {
        SnackbarService.showSnackbar(body['message']);
      }
      notifyListeners();
    } on ServerException catch (e) {
      SnackbarService.showSnackbar(e.message);
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
    } finally {
      isLoading = false;
      EasyLoading.dismiss();
    }
  }
}
