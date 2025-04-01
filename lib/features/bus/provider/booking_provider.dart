import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/bus/models/initiate_payment_params.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingProvider extends ChangeNotifier {
  ApiRepository apiRepository;
  BookingProvider(this.apiRepository);

  String? paymentStatus;
  bool isValidating = false;

  Future<void> initiatePayment({required InitiatePaymentParams params}) async {
    try {
      EasyLoading.show();
      final response = await apiRepository.post(url: ApiEndpoints.initiatePayment, body: params.toMap());
      final body = jsonDecode(response.body);
      final paymentUrl = body["data"]["paymentUrl"];
      final url = Uri.parse(paymentUrl);
      await launchUrl(url);
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

  Future<void> validatePayment({required String id, required String lock}) async {
    try {
      isValidating = true;
      notifyListeners();
      EasyLoading.show(status: "Validating Payment...");
      final response = await apiRepository.post(url: ApiEndpoints.validatePayment, body: {"id": id, "lock": lock});
      final body = jsonDecode(response.body);
      paymentStatus = body["message"];
    } on ServerException catch (e) {
      SnackbarService.showSnackbar(e.message);
      debugPrint(e.message);
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
      debugPrint(e.toString());
    } finally {
      isValidating = false;
      EasyLoading.dismiss();
      notifyListeners();
      Future.delayed(Duration(seconds: 3)).then(
        (value) {
          router.go(Routes.navScreen);
        },
      );
    }
  }
}
