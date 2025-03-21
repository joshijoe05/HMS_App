import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/auth/domain/entities/hostel_entity.dart';

class HostelProvider extends ChangeNotifier {
  ApiRepository apiRepository;
  HostelProvider(this.apiRepository);
  List<HostelEntity> hostels = [];
  Future<void> getAllHostels() async {
    try {
      final response = await apiRepository.get(url: ApiEndpoints.getHostelsEndpoint, isProtected: false);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        hostels = (body["data"]["hostels"] as List).map((e) => HostelEntity.fromJson(e)).toList();
      } else {
        throw Exception(body["message"]);
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
