import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:postgrest/src/postgrest_response.dart';
import 'package:room_booking/app/routes/app.routes.dart';
import 'package:room_booking/core/models/room.model.dart';
import 'package:room_booking/core/service/booking.service.dart';
import 'package:room_booking/core/service/reference.service.dart';
import 'package:room_booking/presentation/screens/payStack/paystack/paystack_auth_response.dart';
import 'package:room_booking/presentation/screens/payStack/transaction/transaction.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:room_booking/presentation/screens/payStack/api_key.dart';
import '../../../core/models/booking.model.dart';
import '../roomScreen/room.screen.dart';

  class PaymentArgs{
    final int amount;
    final String email;
    final String reference;
    final int roomID;
    final int userID;

    PaymentArgs({
      required this.amount,
      required this.email,
      required this.reference,
      required this.roomID,
      required this.userID
    });
  }

class PaymentPage extends StatefulWidget {
  final PaymentArgs paymentArgs;
  const PaymentPage({Key? key, required this.paymentArgs}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage> {
  final _webViewKey = UniqueKey();
  late WebViewController _webViewController;

  Future<PayStackAuthResponse> createTransaction(Transaction transaction) async {
    const String url = 'https://api.paystack.co/transaction/initialize';
    final data = transaction.toJson();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${ApiKey.secretKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {

        // Payment initialization successful
        final responseData = jsonDecode(response.body);
        var booking = await BookingService().insertBooking(
            roomID: widget.paymentArgs.roomID,
            userID: widget.paymentArgs.userID,
            bookingPrice: widget.paymentArgs.amount,
            reference: widget.paymentArgs.reference
        );
        // print('The Booking Response: ${booking.data.toString()}');

        return PayStackAuthResponse.fromJson(responseData['data']);
      } else {
        throw 'Payment unsuceesful';
      }
    } on Exception {
      throw 'Payment Unsuceesful';
    }
  }

  Future<String> initializeTransaction() async {
    try {
      final price = widget.paymentArgs.amount;
      final transaction = Transaction(
        amount: (price * 100).toString(),
        reference: widget.paymentArgs.reference,
        currency: 'GHS',
        email: widget.paymentArgs.email,
      );

      final authResponse = await createTransaction(transaction);
      return authResponse.authorization_url;
    } catch (e) {
      print('Error initializing transaction: $e');
      return e.toString();
    }
  }

  Future<String> saveReferenceData() async {
    try{
      var refData = await ReferenceService().insertReference(
          roomID: widget.paymentArgs.roomID,
          refID: widget.paymentArgs.reference
      );
      return refData.data.toString();

    } catch(e) {
      print('Error inserting reference: $e');
      return e.toString();
    }
  }

  late final RoomModel roomModel;
  Future<PostgrestResponse?> addBookings() async {
    var booking = await BookingService().confirmBooking(
        bookingModel: BookingModel(
            bookingPrice: widget.paymentArgs.amount as int,
            bookingDate: DateTime.now().toString(),
            bookingReference: widget.paymentArgs.reference,
            rooms: roomModel
        ),
        userId: widget.paymentArgs.userID,
        roomId: widget.paymentArgs.roomID
    );
    // print(booking!.data.toString());
    return booking;
  }
  Future<PostgrestResponse?> addToBookings() async {
    var booking = await BookingService().insertBooking(
        roomID: widget.paymentArgs.roomID,
        userID: widget.paymentArgs.userID,
        bookingPrice: widget.paymentArgs.amount as int,
        reference: widget.paymentArgs.reference
    );
    print(booking.data.toString());
    return booking;
  }

  @override
  void initState() {
    // TODO: implement initState
    addBookings();
    saveReferenceData();
    _webViewController = WebViewController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paystack'
        ),
        centerTitle: true,
        leading: Container(
          child: IconButton(
              onPressed: (){
                setState(() {
                  Navigator.of(context).popAndPushNamed(
                    AppRouter.roomDetailRoute,
                      arguments: RoomScreenArgs(
                      room_id: widget.paymentArgs.roomID,
                    ),
                  );
                });
              },
              icon: Icon(
                Icons.home_work
              ))
        ),
      ),
        body: SafeArea(
          child: FutureBuilder(
            future: initializeTransaction(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final url = snapshot.data;
                return WebViewWidget(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setBackgroundColor(const Color(0x00000000))
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onProgress: (int progress) {
                          // Update loading bar.
                        },
                        onPageStarted: (String url) {},
                        onPageFinished: (String url) {},
                        onWebResourceError: (WebResourceError error) {},
                        onNavigationRequest: (NavigationRequest request) {
                          if (request.url.startsWith('https://www.youtube.com/')) {
                            return NavigationDecision.prevent;
                          }
                          return NavigationDecision.navigate;
                        },
                      ),
                    )
                    ..loadRequest(Uri.parse(url!)),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
    );
  }
}
