import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/complaints/models/complaint_model.dart';

class ComplaintProvider extends ChangeNotifier {
  ApiRepository apiRepository;
  ComplaintProvider(this.apiRepository);

  int complaintsPage = 1;
  bool hasMoreComplaints = true;
  bool isLoading = false;
  List<ComplaintModel> complaints = [];

  Future<void> getYourComplaints() async {
    try {
      if (isLoading && !hasMoreComplaints) return;
      EasyLoading.show();
      isLoading = true;
      final res = await apiRepository.get(url: ApiEndpoints.getYourComplaints);
      final body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (body['data'].isEmpty) {
          hasMoreComplaints = false;
        } else {
          complaints.addAll((body['data']['complaints'] as List).map(
            (e) => ComplaintModel.fromJson(e),
          ));
          complaintsPage++;
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
