import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/bus/models/bus_response_params.dart';

class BusFormProvider extends ChangeNotifier {
  ApiRepository apiRepository;
  BusFormProvider(this.apiRepository);

  List<String> cities = [];
  String? expiresAt;

  void clear() {
    cities = [];
    expiresAt = null;
    notifyListeners();
  }

  Future<void> fetchFormDetails({required String busFormId}) async {
    try {
      EasyLoading.show();
      final res = await apiRepository.get(url: "${ApiEndpoints.getFormDetails}$busFormId");
      final body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        expiresAt = body["data"]["expiresAt"];
        cities = (body["data"]["cities"] as List<dynamic>).cast<String>();
      } else {
        SnackbarService.showSnackbar(body['message']);
      }
      notifyListeners();
    } on ServerException catch (e) {
      SnackbarService.showSnackbar(e.message);
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> respondToBusForm({required BusResponseParams params, required String busFormId}) async {
    try {
      EasyLoading.show();
      final res = await apiRepository.post(url: "${ApiEndpoints.respondToForm}$busFormId", body: params.toMap());
      final body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        SnackbarService.showSnackbar(body['message']);
        router.pop();
      } else {
        SnackbarService.showSnackbar(body['message']);
      }
      notifyListeners();
    } on ServerException catch (e) {
      SnackbarService.showSnackbar(e.message);
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }
}
