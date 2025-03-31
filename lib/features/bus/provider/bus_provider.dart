import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/bus/models/bus_route_model.dart';

class BusProvider extends ChangeNotifier {
  ApiRepository apiRepository;
  BusProvider(this.apiRepository);

  List<String> cities = [];
  List<BusRouteModel> busRoutes = [];
  String? selectedCity;

  void setSelectedCity(String? city) {
    selectedCity = city;
    notifyListeners();
  }

  Future<void> getCities() async {
    try {
      EasyLoading.show();
      final response = await apiRepository.get(url: ApiEndpoints.getCities);
      final body = jsonDecode(response.body);
      cities = (body["data"]["cities"] as List<dynamic>).cast<String>();
    } on ServerException catch (e) {
      SnackbarService.showSnackbar(e.message);
      debugPrint(e.message);
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> fetchBuses() async {
    try {
      EasyLoading.show();
      final response = await apiRepository.get(url: '${ApiEndpoints.fetchBuses}?to=$selectedCity');
      final body = jsonDecode(response.body);
      busRoutes = (body["data"] as List).map((e) => BusRouteModel.fromJson(e)).toList();
    } on ServerException catch (e) {
      SnackbarService.showSnackbar(e.message);
      debugPrint(e.message);
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }
}
