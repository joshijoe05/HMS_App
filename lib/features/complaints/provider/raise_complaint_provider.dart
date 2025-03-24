import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/helper/image_picker.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/complaints/provider/complaint_provider.dart';

class RaiseComplaintProvider extends ChangeNotifier {
  ApiRepository apiRepository;
  ComplaintProvider complaintProvider;
  RaiseComplaintProvider(this.apiRepository, this.complaintProvider);
  String? type;
  String? priority;
  File? firstImage;
  File? secondImage;
  final TextEditingController descriptionController = TextEditingController();

  void clear() {
    type = null;
    priority = null;
    firstImage = null;
    secondImage = null;
    descriptionController.clear();
    notifyListeners();
  }

  void changeCategory(String? value) {
    type = value;
    notifyListeners();
  }

  void changePriority(String? value) {
    priority = value;
    notifyListeners();
  }

  Future<void> addPhotos({required bool isFirstImg}) async {
    final img = await ImagePickerHelper.pickImageFromCamera();
    if (img != null) {
      if (isFirstImg) {
        firstImage = img;
      } else {
        secondImage = img;
      }
    }
    notifyListeners();
  }

  void removePhoto({required bool isFirstImg}) {
    if (isFirstImg) {
      firstImage = null;
    } else {
      secondImage = null;
    }
    notifyListeners();
  }

  Future<void> raiseComplaint() async {
    try {
      EasyLoading.show();
      final response = await apiRepository.multiPartPost(
        url: ApiEndpoints.raiseComplaint,
        isProtected: true,
        fields: {
          "type": type!.toLowerCase(),
          "priority": priority!.toLowerCase(),
          "description": descriptionController.text.trim(),
        },
        fileKey: "images",
        files: [
          if (firstImage != null) firstImage!,
          if (secondImage != null) secondImage!,
        ],
      );
      final body = jsonDecode(response.body);
      SnackbarService.showSnackbar(body['message']);
      router.pop();
    } on ServerException catch (e) {
      SnackbarService.showSnackbar(e.message);
    } catch (e) {
      debugPrint(e.toString());
      SnackbarService.showSnackbar(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }
}
