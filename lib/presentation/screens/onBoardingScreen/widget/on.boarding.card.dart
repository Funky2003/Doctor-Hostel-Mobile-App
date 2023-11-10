import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:room_booking/core/models/on.boarding.model.dart';

class PageCard extends StatelessWidget {
  final OnBoardingModel card;

  const PageCard({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    space(double p) => SizedBox(height: screenHeight * p / 100);
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(
        children: [
          space(0.5),
          _buildPicture(context),
          space(1),
          _buildText(context),
        ],
      ),
    );
  }

  Widget _buildPicture(
    BuildContext context, {
    double size = 350,
  }) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(
        top: 75.0,
      ),
      child: SvgPicture.asset(card.image!),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      card.title!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: card.textColor,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
        letterSpacing: 0.0,
      ),
    );
  }
}
