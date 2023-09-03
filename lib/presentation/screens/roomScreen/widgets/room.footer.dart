import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/app/routes/app.routes.dart';
import 'package:room_booking/core/models/room.model.dart';
import 'package:room_booking/core/notifiers/authentication.notifier.dart';
import 'package:room_booking/presentation/screens/bookingScreen/booking.screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../widgets/custom.snackbar.dart';

class RoomFooter extends StatefulWidget {
  final RoomModel roomModel;

  const RoomFooter({
    Key? key,
    required this.roomModel,
  }) : super(key: key);

  @override
  State<RoomFooter> createState() => _RoomFooterState();
}

class _RoomFooterState extends State<RoomFooter> {
  late bool roomStatus = widget.roomModel.roomStatus;

  @override
  Widget build(BuildContext context) {
    var userId = Provider.of<AuthenticationNotifer>(context, listen: false).userId;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            final availableMaps = await MapLauncher.installedMaps;
            await availableMaps.first.showMarker(
                coords: Coords(widget.roomModel.roomLat, widget.roomModel.roomLong),
                title: widget.roomModel.roomName);
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.pin_drop,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            final Uri _url = Uri.parse('tel://0${widget.roomModel.roomCallNo}');
            launchUrl(_url);
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.phone,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 15,
          child: ElevatedButton(
            onPressed: () async {
              if (widget.roomModel.roomStatus == false){
                SnackUtil.showSnackBar(
                  context: context,
                  text: "Room already booked, please try another room!",
                  textColor: Colors.white,
                  backgroundColor: Colors.red,
                );
              } else{
                Navigator.of(context).pushNamed(
                  AppRouter.bookingRoute,
                  arguments: BookingScreenArgs(
                    user_id: userId,
                    roomData: widget.roomModel,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: roomStatus? Colors.orange : Colors.grey,
            ),
            child: Text(
              roomStatus? "Book Now" : "Room already booked",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
