import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:room_booking/core/service/room.service.dart';
import 'package:supabase/supabase.dart';
import '../../../app/routes/app.routes.dart';
import '../../../core/service/reference.service.dart';
import '../payStack/api_key.dart';
import '../roomScreen/room.screen.dart';
import 'package:http/http.dart' as http;


class AdminRoomsOnlyArgs {
  final dynamic uID;
  final dynamic roomName;
  final dynamic roomTelephone;
  final dynamic roomAddress;

  AdminRoomsOnlyArgs({
    required this.roomName,
    required this.roomTelephone,
    required this.roomAddress,
    required this.uID,
  });
}

class AdminRoomsOnly extends StatefulWidget {
  final AdminRoomsOnlyArgs adminRoomsOnlyArgs;
  const AdminRoomsOnly({Key? key, required this.adminRoomsOnlyArgs}) : super(key: key);

  @override
  State<AdminRoomsOnly> createState() => _AdminRoomsOnlyState();
}

class _AdminRoomsOnlyState extends State<AdminRoomsOnly> {

  Future<void> _refresh() async {
    var rooms = await verifyTransaction();
    setState(() {
      rooms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Rooms'
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: const EdgeInsets.only(top: 18.0, bottom: 25.0),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(18.0)
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.adminRoomsOnlyArgs.roomName.toString(),
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              Text(
                                  widget.adminRoomsOnlyArgs.roomAddress
                              ),

                              Text(
                                  '0${widget.adminRoomsOnlyArgs.roomTelephone}'
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Available Rooms',
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: RoomService().getAdminRoomsOnly(uID: widget.adminRoomsOnlyArgs.uID),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (!snapshot.hasData || snapshot.data is! PostgrestResponse) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text('No Data Found!')),
                      );
                    } else {
                      PostgrestResponse response = snapshot.data as PostgrestResponse;
                      List items = response.data as List;

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            final allRooms = items[index];
                            final roomPhotos = allRooms['room_photos'][0];
                            final roomPrice = allRooms['room_price'];
                            final roomName = allRooms['room_name'];
                            final roomType = allRooms['room_type'];
                            final roomAddress = allRooms['room_address'];
                            final roomRating = allRooms['room_rating'];
                            final roomID = allRooms['room_id'];
                            bool roomStatus = allRooms['room_status'];

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRouter.roomDetailRoute,
                                  arguments: RoomScreenArgs(
                                    room_id: roomID,
                                  ),
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
                                                                  'Ghc${roomPrice.toString()}',
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
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: roomStatus ? Colors.green : Colors.red,
                                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
                                                        ),

                                                        child: Padding(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: Text(
                                                            roomStatus ? 'Available' : 'Unavailable',
                                                            style: TextStyle(
                                                              color: Colors.white
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
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
                                                        '$roomType',
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
                                                              '$roomRating',
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
                            );},
                          childCount: items.length,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
        ),
      ),
    );
  }


  Future<bool> verifyTransaction() async {
    try {
      var references = await ReferenceService().getAllReference();
      var rooms = await RoomService().getAllRooms();

      // Initialize a list to keep track of successfully updated room IDs
      List<int> updatedRoomIDs = [];
      for (var referenceData in references.data) {
        var reference = referenceData['reference_key'];
        var room_id = referenceData['room_id'];

        // Find the corresponding room
        var roomData = rooms.data.firstWhere(
              (room) => room['room_id'] == room_id,
          orElse: () => null, // Return null if room not found
        );

        if (roomData != null) {
          var roomID = roomData['room_id'];

          final String url = 'https://api.paystack.co/transaction/verify/$reference';
          http.Response response = await http.get(
            Uri.parse(url),
            headers: {
              'Authorization': 'Bearer ${ApiKey.secretKey}',
              'Content-Type': 'application/json',
            },
          );
          var body = response.body;
          print('This is the response body: ${body.toString()}');

          if (response.statusCode == 200) {
            final responseData = jsonDecode(response.body);
            if (reference == responseData['data']['reference'] &&
                responseData['data']['status'] == "success") {
              // Update the room status
              var roomStatus = await RoomService().updateRoomStatus(status: false, roomID: room_id);
              print('Room status updated for room ID: $room_id');
              updatedRoomIDs.add(roomID); // Add successfully updated room ID to the list
            }
          }
        }
      }

      // Check if any room statuses were updated successfully
      if (updatedRoomIDs.isNotEmpty) {
        print('Successfully updated room IDs: $updatedRoomIDs');
        return true;
      } else {
        print('No room statuses were updated.');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    verifyTransaction();
    super.initState();
  }

}
