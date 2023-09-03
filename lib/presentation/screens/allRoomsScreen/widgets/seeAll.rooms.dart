import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/core/models/room.model.dart';

class AllRooms extends StatelessWidget {
  //Let's create a AllRooms function in oder to call it in different sections/pages...
  const AllRooms({Key? key, this.onTap, required this.roomModel}) : super(key: key);

  final GestureTapCallback? onTap; //onTap callBack function...
  final RoomModel roomModel; //Let's define the roomModel class...

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
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
                      imageUrl: roomModel.roomPhotos[0],
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
                                    'Ghc${roomModel.roomPrice.toString()}',
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
                            roomModel.roomName.toString(),
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
                                roomModel.roomType.toString(),
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
                                  roomModel.roomAddress.toString(),
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
                                      roomModel.roomRating.toString(),
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
  }
}
