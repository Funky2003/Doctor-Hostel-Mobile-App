import 'package:flutter/material.dart';
import 'package:room_booking/presentation/screens/aboutScreen/about.screen.dart';
import 'package:room_booking/presentation/screens/adminRoomsOnly/admin.rooms.only.dart';
import 'package:room_booking/presentation/screens/allRoomsScreen/all.rooms.screen.dart';
import 'package:room_booking/presentation/screens/bookingScreen/booking.screen.dart';
import 'package:room_booking/presentation/screens/favouriteScreen/favourite.screen.dart';
import 'package:room_booking/presentation/screens/feedbackScreen/feedback.screen.dart';
import 'package:room_booking/presentation/screens/homeScreen/home.screen.dart';
import 'package:room_booking/presentation/screens/loginScreen/login.screen.dart';
import 'package:room_booking/presentation/screens/loginSignupScreen/signUpLoginScreen.dart';
import 'package:room_booking/presentation/screens/navigationScreen/navigation.screen.dart';
import 'package:room_booking/presentation/screens/noNetworkScreen/no.network.screen.dart';
import 'package:room_booking/presentation/screens/onBoardingScreen/on.boarding.screen.dart';
import 'package:room_booking/presentation/screens/payStack/payment_page.dart';
import 'package:room_booking/presentation/screens/prevBookingScreen/prev.booking.screen.dart';
import 'package:room_booking/presentation/screens/profileScreen/profile.screen.dart';
import 'package:room_booking/presentation/screens/roomScreen/room.screen.dart';
import 'package:room_booking/presentation/screens/searchScreen/search.screen.dart';
import 'package:room_booking/presentation/screens/settingScreen/setting.screen.dart';
import 'package:room_booking/presentation/screens/signupScreen/signup.screen.dart';
import 'package:room_booking/presentation/screens/splashScreen/splash.screen.dart';

class AppRouter {
  static const String onboardingRoute = "/onboard";
  static const String splashRoute = "/splash";
  static const String loginRoute = "/login";
  static const String signupRoute = "/signup";
  static const String navRoute = "/nav";
  static const String homeRoute = "/home";
  static const String settingRoute = "/setting";
  static const String aboutRoute = "/about";
  static const String feedbackRoute = "/feedback";
  static const String roomDetailRoute = "/room";
  static const String prevbookingRoute = "/prevbooking";
  static const String paymentRoute = "/payment";
  static const String favRoute = "/fav";
  static const String profileRoute = "/profile";
  static const String searchRoute = "/search";
  static const String bookingRoute = "/bookingF";
  static const String allRoomsRoute = "/allRooms";
  static const String noNetWorkRoute = "/noNet";
  static const String signUpLogin = "/signUpLogin";
  static const String adminRoomsRoute = "/adminRoomsOnly";

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        {
          return MaterialPageRoute(
            builder: (_) => SplashScreen(),
          );
        }
      case onboardingRoute:
        {
          return MaterialPageRoute(
            builder: (_) => OnBoardingScreen(),
          );
        }
    
      case loginRoute:
        {
          return MaterialPageRoute(
            builder: (_) => LoginScreen(),
          );
        }
      case signupRoute:
        {
          return MaterialPageRoute(
            builder: (_) => SignUpScreen(),
          );
        }
      case navRoute:
        {
          return MaterialPageRoute(
            builder: (_) => NavigationScreen(),
          );
        }
      case homeRoute:
        {
          return MaterialPageRoute(
            builder: (_) => HomeScreen(),
          );
        }
      case settingRoute:
        {
          return MaterialPageRoute(
            builder: (_) => SettingScreen(),
          );
        }
      case aboutRoute:
        {
          return MaterialPageRoute(
            builder: (_) => AboutScreen(),
          );
        }
      case feedbackRoute:
        {
          return MaterialPageRoute(
            builder: (_) => FeedbackScreen(),
          );
        }
      case prevbookingRoute:
        {
          return MaterialPageRoute(
            builder: (_) => PreviousBookingScreen(),
          );
        }
      case favRoute:
        {
          return MaterialPageRoute(
            builder: (_) => FavouriteScreen(),
          );
        }
      case searchRoute:
        {
          return MaterialPageRoute(
            builder: (_) => SearchScreen(),
          );
        }
      case profileRoute:
        {
          return MaterialPageRoute(
            builder: (context) => ProfileScreen(
              profileTaskArgs: ModalRoute.of(context)!.settings.arguments as ProfileTaskArgs,
            ),
            settings: settings,
          );
        }
        case paymentRoute:
        {
          return MaterialPageRoute(
            builder: (context) => PaymentPage(
              paymentArgs: ModalRoute.of(context)!.settings.arguments as PaymentArgs
            ),
              settings: settings
          );
        }
      case roomDetailRoute:
        {
          return MaterialPageRoute(
            builder: (context) => RoomScreen(
              roomScreenArgs: ModalRoute.of(context)!.settings.arguments as RoomScreenArgs,
            ),
            settings: settings,
          );
        }
      case bookingRoute:
        {
          return MaterialPageRoute(
            builder: (context) => BookingScreen(
              bookingScreenArgs: ModalRoute.of(context)!.settings.arguments as BookingScreenArgs,
            ),
            settings: settings,
          );
        }
      case allRoomsRoute:
        {
          return MaterialPageRoute(
            builder: (context) => AllRoomScreen(),
          );
        }
        case noNetWorkRoute:
        {
          return MaterialPageRoute(
            builder: (context) => NoNetworkScreen(),
          );
        }
      case signUpLogin:
        {
          return MaterialPageRoute(
              builder: (context) => SignupLogin(),
          );
        }
      case adminRoomsRoute:
        {
          return MaterialPageRoute(
            builder: (context) => AdminRoomsOnly(
              adminRoomsOnlyArgs: ModalRoute.of(context)!.settings.arguments as AdminRoomsOnlyArgs),
            settings: settings,
          );
        }
    }
    return null;
  }
}
