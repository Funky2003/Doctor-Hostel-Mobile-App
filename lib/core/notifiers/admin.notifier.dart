import 'package:flutter/material.dart';
import 'package:room_booking/core/models/events.model.dart';
import 'package:room_booking/core/service/admin.service.dart';
import 'package:supabase/supabase.dart';

class AdminNotifier extends ChangeNotifier {
  final AdminService adminService = AdminService();
  PostgrestResponse? allAdminData;

  Future getAdminEvents() async {
    if (allAdminData == null) {
      allAdminData = await adminService.getAllAdmin();
      notifyListeners();
      return allAdminData!.data
          .map((element) => EventsModel.fromJson(element))
          .toList();
    } else {
      return allAdminData!.data
          .map((element) => EventsModel.fromJson(element))
          .toList();
    }
  }
}
