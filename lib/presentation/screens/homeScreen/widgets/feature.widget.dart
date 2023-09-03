import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/core/models/admin.model.dart';
import 'package:room_booking/core/models/room.model.dart';
import 'package:room_booking/core/service/room.service.dart';

import '../../../../core/service/admin.service.dart';
import '../../../../core/service/room.service.dart';

class FeatureRooms extends StatefulWidget {
  const FeatureRooms({Key? key, this.onTap, this.onTapFavorite, required this.roomModel}) : super(key: key);

  final RoomModel roomModel;
  final GestureTapCallback? onTapFavorite;
  final GestureTapCallback? onTap;
  @override
  State<FeatureRooms> createState() => _FeatureRoomsState();
}

class _FeatureRoomsState extends State<FeatureRooms> {


  Future<List<Map<String, dynamic>>> mainRooms() async{
    var admin = await AdminService().getAllAdmin();
    var rooms = await RoomService().getAllRooms();

    var uID;
    var roomUiD;
    var uniqueID = <int>{};
    var finalRooms;

    for (var x in admin.data){
      uID = x['uID'];
      // print(uID.toString());

      for (var y in rooms.data) {
        roomUiD = y['admin'];
        // print(roomUiD.toString());

        if (uID == roomUiD) {
          if (!uniqueID.contains(roomUiD)){
            uniqueID.add(roomUiD);
            finalRooms = y['room_name'];
            print(finalRooms.toString());
          }
        }
      }
    }
    return (rooms.data as List).cast<Map<String, dynamic>>();
  }


  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height / 700;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 15.0),
        width: MediaQuery.of(context).size.width * 0.65,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeBottom: true,
          context: context,
          child: Card(
            color: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.roomModel.roomPhotos[0],
                    imageBuilder: (context, imageProvider) => Container(
                      margin: EdgeInsets.all(8.0),
                      height: _height * 150,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.white,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  Container(

                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 5, 15.0),
                      decoration: BoxDecoration(
                      ),
                      child: Center(
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.roomModel.roomName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: _height * 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.black54,
                                        size: 14.0,
                                      ),
                                      Text(
                                        '${widget.roomModel.roomAddress}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: _height * 12,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            // const SizedBox(height: 10.0),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Ghc${widget.roomModel.roomPrice.toString()}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: _height * 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.yellowish,

                                    ),
                                  ),
                                  Text(
                                    '/Semester',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: _height * 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_outline_rounded,
                        size: _height * 25,
                        color: Colors.white,
                      ),
                      onPressed: widget.onTapFavorite,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
