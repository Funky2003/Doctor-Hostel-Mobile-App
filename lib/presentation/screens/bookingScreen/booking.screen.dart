import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/app/routes/app.routes.dart';
import 'package:room_booking/core/models/room.model.dart';
import 'package:room_booking/core/notifiers/authentication.notifier.dart';
import 'package:room_booking/core/notifiers/booking.notifer.dart';
import 'package:room_booking/core/notifiers/theme.notifier.dart';
import 'package:room_booking/core/service/booking.service.dart';
import 'package:room_booking/core/service/reference.service.dart';
import 'package:room_booking/presentation/widgets/custom.button.dart';
import 'package:provider/provider.dart';
import '../../../core/models/booking.model.dart';
import '../payStack/payment_page.dart';

class BookingScreen extends StatefulWidget {
  final BookingScreenArgs bookingScreenArgs;
  const BookingScreen({Key? key, required this.bookingScreenArgs}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool check = false;

  @override
  void initState() {
    check = false;
    print(widget.bookingScreenArgs.roomData.roomStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = _themeNotifier.darkTheme;
    var userData = Provider.of<AuthenticationNotifer>(context, listen: true);
    var bookNotifier = Provider.of<BookingNotifier>(context, listen: true);
    TextEditingController couponText = TextEditingController();

    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      appBar: AppBar(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        title: Text(
          'Booking Form',
          style: TextStyle(
            color: themeFlag ? AppColors.creamColor : AppColors.mirage,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Details',
                style: TextStyle(
                  color: AppColors.yellowish,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Divider(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage),
              Text(
                'User Name : ${userData.userName!}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                'User Email : ${userData.userEmail}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                'User Phone : ${userData.userPhoneNo}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Divider(
                color: themeFlag ? AppColors.creamColor : AppColors.mirage,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Room Details',
                style: TextStyle(
                  color: AppColors.yellowish,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Divider(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage),
              Text(
                'Room Name : ${widget.bookingScreenArgs.roomData.roomName}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                'Room Address : ${widget.bookingScreenArgs.roomData.roomAddress}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Room Type : ${widget.bookingScreenArgs.roomData.roomType}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                'Room Price : ${amountText(widget.bookingScreenArgs.roomData.roomPrice)}',
                style: TextStyle(
                  // color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                'Discount Amount : ${check ? (widget.bookingScreenArgs.roomData.roomPrice * 5 ~/ 100) : 0}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Date : $formattedDate',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Divider(
                color: themeFlag ? AppColors.creamColor : AppColors.mirage,
              ),
              SizedBox(
                height: 30,
              ),
              // Text(
              //   'Confirm Booking Dates',
              //   style: TextStyle(
              //     color: AppColors.yellowish,
              //     fontSize: 16,
              //   ),
              //   textAlign: TextAlign.left,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Start Date : ${bookNotifier.startDate ?? ''}',
              //       style: TextStyle(
              //         color:
              //             themeFlag ? AppColors.creamColor : AppColors.mirage,
              //         fontSize: 16,
              //       ),
              //       textAlign: TextAlign.left,
              //     ),
              //     IconButton(
              //       splashColor:
              //           themeFlag ? AppColors.creamColor : AppColors.mirage,
              //       icon: Icon(
              //         Icons.edit_calendar,
              //         size: 20,
              //         color:
              //             themeFlag ? AppColors.creamColor : AppColors.mirage,
              //       ),
              //       onPressed: () {
              //         StartDatePicker(
              //           themeFlag: themeFlag,
              //           context: context,
              //           bookingNotifier: bookNotifier,
              //         );
              //       },
              //     ),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'End Date : ${bookNotifier.endDate ?? ''} ',
              //       style: TextStyle(
              //         color:
              //             themeFlag ? AppColors.creamColor : AppColors.mirage,
              //         fontSize: 16,
              //       ),
              //       textAlign: TextAlign.left,
              //     ),
              //     IconButton(
              //       onPressed: () {
              //         EndDatePicker(
              //           themeFlag: themeFlag,
              //           context: context,
              //           bookingNotifier: bookNotifier,
              //         );
              //       },
              //       splashColor:
              //           themeFlag ? AppColors.creamColor : AppColors.mirage,
              //       icon: Icon(
              //         Icons.edit_calendar,
              //         size: 20,
              //         color:
              //             themeFlag ? AppColors.creamColor : AppColors.mirage,
              //       ),
              //     )
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         const Icon(Icons.card_giftcard),
              //         Padding(
              //           padding: const EdgeInsets.only(left: 8.0),
              //           child: Container(
              //             constraints: const BoxConstraints(maxWidth: 210),
              //             child: TextFormField(
              //               controller: couponText,
              //               style: TextStyle(
              //                 color: themeFlag
              //                     ? AppColors.creamColor
              //                     : AppColors.mirage,
              //                 fontSize: 16.0,
              //               ),
              //               decoration: InputDecoration(
              //                 hintText: 'Enter Coupon Code',
              //                 hintStyle: TextStyle(
              //                   color: themeFlag
              //                       ? AppColors.creamColor
              //                       : AppColors.mirage,
              //                   fontSize: 16.0,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     TextButton(
              //       child: const Text('Apply'),
              //       onPressed: () {
              //         if (couponText.text.isNotEmpty) {
              //           if (AppDiscount.couponCode.contains(couponText.text)) {
              //             if (check == false) {
              //               SnackUtil.showSnackBar(
              //                 context: context,
              //                 text: 'Ohh Yeah Coupon Applied',
              //                 textColor: AppColors.creamColor,
              //                 backgroundColor: Colors.red.shade200,
              //               );
              //               setState(() {
              //                 check = true;
              //               });
              //             } else if (check == true) {
              //               SnackUtil.showSnackBar(
              //                 context: context,
              //                 text: 'Coupon Already Applied',
              //                 textColor: AppColors.creamColor,
              //                 backgroundColor: Colors.red.shade200,
              //               );
              //             }
              //           } else {
              //             SnackUtil.showSnackBar(
              //               context: context,
              //               text: 'Oops Wrong Coupon Code',
              //               textColor: AppColors.creamColor,
              //               backgroundColor: Colors.red.shade200,
              //             );
              //           }
              //         } else {
              //           SnackUtil.showSnackBar(
              //             context: context,
              //             text: "Enter A Coupon Code!",
              //             textColor: AppColors.creamColor,
              //             backgroundColor: Colors.red.shade200,
              //           );
              //         }
              //       },
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 40,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How Many Semester(s) Are You Paying For',
                    style: TextStyle(
                      color: AppColors.yellowish,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        // color: Colors.orange,
                        child: DropdownButton<String>(
                          underline: DropdownButtonHideUnderline(child: Text('')),
                          icon: Icon(
                              Icons.keyboard_arrow_down
                          ),
                          value: _item,
                          style:
                          TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          items: <String>[
                            _semOne,
                            _semTwo,
                            _semThree,
                            _semFour,
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Text(
                            "Please number of semesters",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _item = value!;
                            }
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: themeFlag ? AppColors.creamColor : AppColors.mirage,
              ),
              SizedBox(
                height: 40,
              ),
              CustomButton.customBtnLogin(
                buttonName: 'Book Room',
                onTap: () async {
                  setState(() {
                    Navigator.of(context).popAndPushNamed(
                      AppRouter.paymentRoute,
                      arguments: PaymentArgs(
                          amount: amountText(widget.bookingScreenArgs.roomData.roomPrice),
                          email: '${userData.userEmail}',
                          userID: userData.userId!,
                          reference: "Doc.Hostel${DateTime.now().millisecond}${DateTime.now().microsecond}",
                          roomID: widget.bookingScreenArgs.roomData.roomId
                      )
                    );
                  });
                    // var PayStatus = await Provider.of<PaymentNotifier>(
                    //   context,
                    //   listen: false,
                    // );
                    // await PayStatus.checkMeOut(
                    //   context: context,
                    //   amt: widget.bookingScreenArgs.roomData.roomPrice.toInt(),).whenComplete(
                    //   () async {
                    //     if (PayStatus.paymentStatus!) {
                    //       BookingModel bookingModel = BookingModel(
                    //         bookingRazorid: 'PayStatus.payResponse!',
                    //         bookingPrice: check ? widget.bookingScreenArgs.roomData.roomPrice - (widget.bookingScreenArgs.roomData.roomPrice * 5 ~/ 100) : widget.bookingScreenArgs.roomData.roomPrice,
                    //         bookingStartDate: bookNotifier.startDate!,
                    //         bookingEndDate: bookNotifier.endDate!,
                    //       );
                    //
                    //       var isSuccessFul = await Provider.of<BookingNotifier>(context, listen: false).confirmBooking(
                    //         bookingModel: bookingModel,
                    //         userId: userData.userId!,
                    //         roomId: widget.bookingScreenArgs.roomData.roomId,
                    //       );
                    //
                    //       if (isSuccessFul) {
                    //         SnackUtil.showSnackBar(
                    //           context: context,
                    //           text: 'Sucessfully Booked',
                    //           textColor: AppColors.creamColor,
                    //           backgroundColor: Colors.red.shade200,
                    //         );
                    //         Navigator.pop(context);
                    //       } else {
                    //         SnackUtil.showSnackBar(
                    //           context: context,
                    //           text: 'Some Error Occurred',
                    //           textColor: AppColors.creamColor,
                    //           backgroundColor: Colors.red.shade200,
                    //         );
                    //         Navigator.pop(context);
                    //       }
                    //     }
                    //   },
                    // );
                },
                bgColor: themeFlag ? AppColors.creamColor : AppColors.mirage,
                textColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


DateTime _dateTime = DateTime.now();
String formattedDate = DateFormat('yyy-mm-dd').format(_dateTime);

String _item = 'One Semester';
String _semOne = 'One Semester';
String _semTwo = 'Two Semesters';
String _semThree = 'Three Semesters';
String _semFour = 'Four Semesters';

var newAmount = 0;
int x = 0;

int amountText(int amount){
  if(_item == _semTwo){
    newAmount = amount * 2;
    showText('${amount}');
    print(newAmount);
  } else if (_item == _semThree){
    newAmount = amount * 3;
    showText('${amount}');
    print(newAmount);
  }  else if (_item == _semFour){
    newAmount = amount * 4;
    showText('${amount}');
    print(newAmount);
  } else{
    newAmount = amount * 1;
    showText('${amount}');
    print(newAmount);
  }
  return newAmount;
}

Container showText(String text){
  return Container(
    child: Column(
      children: [
        Text(
          text,
          style: TextStyle(
          ),
        )
      ],
    ),
  );
}

class BookingScreenArgs {
  final RoomModel roomData;
  final dynamic user_id;

  BookingScreenArgs({
    required this.user_id,
    required this.roomData,
  });
}

Future StartDatePicker({
  required bool themeFlag,
  required BuildContext context,
  required BookingNotifier bookingNotifier,
}) {
  final date = DateTime.now();
  return showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        backgroundColor: themeFlag ? AppColors.creamColor : AppColors.mirage,
        content: Container(
          height: 200,
          width: 350.0,
          child: CupertinoDatePicker(
            minimumDate: DateTime.now(),
            maximumDate: DateTime(date.year, date.month + 1, date.day),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              String createdAt = DateFormat("dd-MMMM-yyyy").format(value);
              bookingNotifier.startDateSet(createdAt: createdAt);
            },
            initialDateTime: DateTime.now(),
          ),
        ),
      );
    },
  );
}

Future EndDatePicker({
  required bool themeFlag,
  required BuildContext context,
  required BookingNotifier bookingNotifier,
}) {
  final date = DateTime.now();

  return showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        backgroundColor: themeFlag ? AppColors.creamColor : AppColors.mirage,
        content: Container(
          height: 200,
          width: 350.0,
          child: CupertinoDatePicker(
            // minimumDate: DateTime(date.year, date.month, date.day + 1),
            maximumDate: DateTime(date.year, date.month + 1, date.day),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              String createdAt = DateFormat("dd-MMMM-yyyy").format(value);
              bookingNotifier.endDateSet(createdAt: createdAt);
            },
            initialDateTime: DateTime(date.year, date.month, date.day + 1),
          ),
        ),
      );
    },
  );
}
