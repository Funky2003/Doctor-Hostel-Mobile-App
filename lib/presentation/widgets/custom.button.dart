import 'package:flutter/material.dart';
import 'package:room_booking/presentation/widgets/custom.styles.dart';

class CustomButton {
  bool showProgress = false;

  static customBtnLogin({
    required buttonName,
    required onTap,
    required bgColor,
    required textColor,
  }) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child:TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Colors.black12,
          ),
        ),
        onPressed: onTap,
        child: Text(
          buttonName,
          style: kButtonText.copyWith(color: textColor),
        ),
      ),
    );
  }
}
