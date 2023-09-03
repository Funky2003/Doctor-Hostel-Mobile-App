import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/app/routes/app.routes.dart';
import 'package:room_booking/core/notifiers/room.notifier.dart';
import 'package:room_booking/core/notifiers/sorts.notifier.dart';
import 'package:room_booking/core/notifiers/theme.notifier.dart';
import 'package:room_booking/presentation/screens/allRoomsScreen/widgets/sort.menu.two.widget.dart';
import 'package:room_booking/presentation/screens/allRoomsScreen/widgets/sort.menu.widget.dart';
import 'package:room_booking/presentation/widgets/shimmer.effects.dart';
import 'package:provider/provider.dart';
import '../../../core/service/admin.service.dart';
import '../../../core/service/room.service.dart';
import '../adminRoomsOnly/admin.rooms.only.dart';

class AllRoomScreen extends StatelessWidget {
  const AllRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = _themeNotifier.darkTheme;

    double _height = MediaQuery.of(context).size.height / 815;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Text(
                  "All Rooms",
                  style: TextStyle(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Find The Best Available Room",
                      style: TextStyle(
                        color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SortMenuTwo(),
                        SizedBox(
                          width: 10,
                        ),
                        SortMenuOne(),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _height * 670,
                child: FutureBuilder(
                  future: mainRooms(),
                  builder: (context, snapshot){
                    if (!snapshot.hasData){
                      return ShimmerEffects.loadShimmerFavouriteandSearch(
                        context: context,
                        displayTrash: false,
                      );
                    } else{
                      final List<Map<String, dynamic>> itemList = snapshot.data as List<Map<String, dynamic>>;

                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {

                          print(itemList[0]['hostel_thumbnail'].toString());
                          final roomName = itemList[index]['hostel_name'] as String;
                          final roomPhotos = itemList[index]['hostel_thumbnail'] as String;
                          final roomAddress = itemList[index]['hostel_location'] as String;
                          final uID = itemList[index]['uID'] as int;
                          final roomTelephone = itemList[index]['mobile_number'] as int;

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  AppRouter.adminRoomsRoute,
                                  arguments: AdminRoomsOnlyArgs(
                                      uID: uID,
                                      roomName: roomName,
                                      roomAddress: roomAddress,
                                      roomTelephone: roomTelephone
                                  )
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.white,
                                      ),
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                              imageUrl: '$roomPhotos',
                                              imageBuilder: (context, imageProvider) =>
                                                  Container(
                                                    height: MediaQuery.of(context).size.height * 0.13,
                                                    width: MediaQuery.of(context).size.width * 0.30,
                                                    margin: EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15.0),
                                                        image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.fill
                                                        )
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.all(5.0),
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(8.0),
                                                              ),
                                                              margin: EdgeInsets.all(8.0),
                                                              child: Text(
                                                                'Room price',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.w900,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                          ),

                                          Container(
                                            // height: MediaQuery.of(context).size.height * 0.13,
                                            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                            width: MediaQuery.of(context).size.width * 0.54,
                                            clipBehavior: Clip.values.last,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.0),
                                              // color: Colors.black38
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  '$roomName',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      overflow: TextOverflow.ellipsis,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 20.0
                                                  ),
                                                ),
                                                SizedBox(height: 8.0,),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.type_specimen,
                                                      color: Colors.deepOrange.withOpacity(0.5),
                                                      size: 18.0,
                                                    ),
                                                    SizedBox(width: 5.0),
                                                    Text(
                                                      'Room type',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black.withOpacity(0.8),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on_rounded,
                                                      color: Colors.deepOrange.withOpacity(0.5),
                                                      size: 18.0,
                                                    ),
                                                    SizedBox(width: 5.0),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                                      child: Text(
                                                        '$roomAddress',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black.withOpacity(0.8),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Container(
                                                  clipBehavior: Clip.values.last,
                                                  decoration: BoxDecoration(
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors.deepOrange.withOpacity(0.5),
                                                            size: 18.0,
                                                          ),
                                                          SizedBox(width: 5.0),
                                                          Text(
                                                            'Room rating',
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.black.withOpacity(0.8),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> mainRooms() async{
    var admin = await AdminService().getAllAdmin();
    var rooms = await RoomService().getAllRooms();

    // var hostelName = admin.data['hostel_name'];
    // var hostelLocation = admin.data['hostel_location'];
    // var hostelThumbnail = admin.data['hostel_thumbnail'];
    //
    // print('${"Hostel Name: " + hostelName + "\n" + "Hostel Location: " + hostelLocation + "\n" + "Hostel Thumbnail: " + hostelThumbnail}');

    // var uID;
    // var roomUiD;
    // var uniqueID = <int>{};
    // var finalRooms;


    // for (var x in admin.data){
    //   uID = x['uID'];
    //   print(x['hostel_name']);
    //   print(x['hostel_location']);
    //   print(x['hostel_thumbnail']);
    //   // print(uID.toString());
    //
    //   for (var y in rooms.data) {
    //     roomUiD = y['admin'];
    //     // print(roomUiD.toString());
    //
    //     if (uID == roomUiD) {
    //       if (!uniqueID.contains(roomUiD)){
    //         uniqueID.add(roomUiD);
    //         finalRooms = y['room_name'];
    //         print(finalRooms.toString());
    //       }
    //     }
    //   }
    // }
    return (admin.data as List).cast<Map<String, dynamic>>();
  }}
