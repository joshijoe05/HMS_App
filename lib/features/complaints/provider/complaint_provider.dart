import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/complaints/models/complaint_detail_model.dart';
import 'package:hms_app/features/complaints/models/complaint_model.dart';

class ComplaintProvider extends ChangeNotifier {
  ApiRepository apiRepository;
  ComplaintProvider(this.apiRepository);

  int complaintsPage = 1;
  bool hasMoreComplaints = true;
  bool isLoading = false;
  List<ComplaintModel> complaints = [];

  void clear() {
    complaintsPage = 1;
    hasMoreComplaints = true;
    complaints = [];
    notifyListeners();
  }

  Future<void> getYourComplaints() async {
    try {
      if (isLoading && !hasMoreComplaints) return;
      EasyLoading.show();
      isLoading = true;
      final res = await apiRepository.get(url: "${ApiEndpoints.getYourComplaints}?page=$complaintsPage");
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

  ComplaintDetailModel? complaintDetail;
  bool isFetchingComplaintDetail = false;
  Future<void> getComplaintDetails({required String id}) async {
    try {
      isFetchingComplaintDetail = true;
      EasyLoading.show();
      final response = await apiRepository.get(url: ApiEndpoints.getComplaintDetails + id);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        complaintDetail = ComplaintDetailModel.fromJson(body['data']);
      }
    } on ServerException catch (e) {
      SnackbarService.showSnackbar(e.message);
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
    } finally {
      isFetchingComplaintDetail = false;
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<bool> addCommentToComplaint({required String id, required String comment}) async {
    try {
      EasyLoading.show();
      final response = await apiRepository.post(url: ApiEndpoints.addComment + id, body: {"message": comment});
      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        body["data"]["added_by"] = complaintDetail?.raisedBy;
        complaintDetail?.comments.add(CommentModel.fromJson(body['data']));
        return true;
      }
      return false;
    } on ServerException catch (e) {
      SnackbarService.showSnackbar(e.message);
      return false;
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
      return false;
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }
}
