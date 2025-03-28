import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/profile/models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  ApiRepository apiRepository;
  ProfileProvider(this.apiRepository);
  UserModel? user;
  bool isFetching = false;

  Future<void> getUserProfile() async {
    try {
      isFetching = true;
      notifyListeners();
      EasyLoading.show();
      final response = await apiRepository.get(url: ApiEndpoints.profile);
      final body = jsonDecode(response.body);
      user = UserModel.fromMap(body["data"]["user"]);
      print(user?.fullName);
    } on ServerException catch (e) {
      SnackbarService.showSnackbar(e.message);
      debugPrint(e.message);
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
      debugPrint(e.toString());
    } finally {
      isFetching = false;
      EasyLoading.dismiss();
      notifyListeners();
    }
  }
}
