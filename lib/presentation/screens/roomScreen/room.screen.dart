import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/core/models/room.model.dart';
import 'package:room_booking/core/notifiers/room.notifier.dart';
import 'package:room_booking/core/notifiers/theme.notifier.dart';
import 'package:room_booking/presentation/screens/roomScreen/widgets/room.widgets.dart';
import 'package:provider/provider.dart';

class RoomScreenArgs {
  final dynamic room_id;

  RoomScreenArgs({
    required this.room_id,
  });
}

class RoomScreen extends StatefulWidget {
  final RoomScreenArgs roomScreenArgs;
  const RoomScreen({Key? key, required this.roomScreenArgs}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = _themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<RoomNotifier>(
            builder: (context, notifier, _) {
              return FutureBuilder(
                future: notifier.getSpecificRoom(roomId: widget.roomScreenArgs.room_id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    List _snapshot = snapshot.data as List;
                    RoomModel roomModel = _snapshot[0];
                    return buildRoomData(
                      context: context,
                      roomModel: roomModel,
                      themeFlag: themeFlag,
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}


