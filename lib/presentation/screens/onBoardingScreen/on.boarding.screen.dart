import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:room_booking/app/routes/app.routes.dart';
import 'package:room_booking/core/models/on.boarding.model.dart';
import 'package:room_booking/app/constants/app.assets.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/presentation/screens/onBoardingScreen/widget/on.boarding.card.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final List<OnBoardingModel> cards = [
    OnBoardingModel(
      image: AppAssets.onBoardingOne,
      title: "The best hostel booking experience start here!",
      bgColor: AppColors.mirage,
      textColor: AppColors.yellowish,
    ),
    OnBoardingModel(
      image: AppAssets.onBoardingThree,
      title: "Feel the real experience of quick and easy hostel booking.",
      bgColor: AppColors.rawSienna,
    ),
    OnBoardingModel(
      image: AppAssets.onBoardingTwo,
      title: "Find, book, and enjoy your stay!",
      bgColor: AppColors.creamColor,
      textColor: AppColors.mirage,
    ),
  ];

  List<Color> get colors => cards.map((p) => p.bgColor).toList();

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
        colors: widget.colors,
        curve: Curves.ease,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Icon(
            Icons.navigate_next,
            size: screenWidth * 0.08,
          ),
        ),
        radius: 30,
        itemCount: 3,
        duration: const Duration(seconds: 2),
        itemBuilder: (index) {
          OnBoardingModel card = widget.cards[index % widget.cards.length];
          return PageCard(card: card);
        },
        onFinish: () {
          Navigator.of(context).pushReplacementNamed(AppRouter.splashRoute);
        },
      ),
    );
  }
}
