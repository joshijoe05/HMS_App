import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/bus/models/initiate_payment_params.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingProvider extends ChangeNotifier {
  ApiRepository apiRepository;
  BookingProvider(this.apiRepository);

  Future<void> initiatePayment({required InitiatePaymentParams params}) async {
    try {
      EasyLoading.show();
      // final response = await apiRepository.post(url: ApiEndpoints.initiatePayment, body: params.toMap());
      // final body = jsonDecode(response.body);
      // final paymentUrl = body["data"]["paymentUrl"];
      final url = Uri.parse(
          "https://mercury-uat.phonepe.com/transact/simulator?token=c6K8TLzyIj6VS9QQ6fsa27iranGjN1n45BhHBJxTPzl");
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
}
