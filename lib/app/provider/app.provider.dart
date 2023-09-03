import 'package:room_booking/core/notifiers/admin.notifier.dart';
import 'package:room_booking/core/notifiers/authentication.notifier.dart';
import 'package:room_booking/core/notifiers/booking.notifer.dart';
import 'package:room_booking/core/notifiers/events.notifier.dart';
import 'package:room_booking/core/notifiers/favourite.notifier.dart';
import 'package:room_booking/core/notifiers/feedback.notifier.dart';
import 'package:room_booking/core/notifiers/password.notifier.dart';
import 'package:room_booking/core/notifiers/payment.notifer.dart';
import 'package:room_booking/core/notifiers/room.notifier.dart';
import 'package:room_booking/core/notifiers/sorts.notifier.dart';
import 'package:room_booking/core/notifiers/theme.notifier.dart';
import 'package:room_booking/core/service/maps.service.dart';
import 'package:room_booking/core/service/photo.service.dart';
import 'package:room_booking/core/utils/obscure.text.util.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ThemeNotifier()),
    ChangeNotifierProvider(create: (_) => PasswordNotifier()),
    ChangeNotifierProvider(create: (_) => AuthenticationNotifer()),
    ChangeNotifierProvider(create: (_) => ObscureTextUtil()),
    ChangeNotifierProvider(create: (_) => FeedbackNotifier()),
    ChangeNotifierProvider(create: (_) => RoomNotifier()),
    ChangeNotifierProvider(create: (_) => BookingNotifier()),
    ChangeNotifierProvider(create: (_) => EventsNotifier()),
    ChangeNotifierProvider(create: (_) => FavouriteNotifier()),
    ChangeNotifierProvider(create: (_) => PhotoService()),
    // ChangeNotifierProvider(create: (_) => PaymentNotifier()),
    ChangeNotifierProvider(create: (_) => SortNotifier()),
    ChangeNotifierProvider(create: (_) => MapsService()),
    ChangeNotifierProvider(create: (_) => AdminNotifier()),
  ];
}
