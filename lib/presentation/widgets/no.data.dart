import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.assets.dart';

Widget noDataFound({required bool themeFlag}) {
  return Center(
    child: Image.asset(
      themeFlag ? AppAssets.noDataLight : AppAssets.noDataDark,
    ),
  );
}
