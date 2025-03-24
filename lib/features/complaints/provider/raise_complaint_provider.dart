import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hms_app/core/helper/image_picker.dart';
import 'package:hms_app/core/network/api_repository.dart';

class RaiseComplaintProvider extends ChangeNotifier {
  ApiRepository apiRepository;
  RaiseComplaintProvider(this.apiRepository);
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
}
