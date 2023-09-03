import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/core/models/booking.model.dart';

class BookingItem extends StatefulWidget {
  final BookingModel bookingModel;
  final bool themeFlag;
  final GestureTapCallback? onTap;

  const BookingItem({
    Key? key,
    required this.bookingModel,
    this.onTap,
    required this.themeFlag,
  }) : super(key: key);

  @override
  State<BookingItem> createState() => _BookingItemState();
}

class _BookingItemState extends State<BookingItem> {
  late bool roomStatus = widget.bookingModel.rooms!.roomStatus;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width / 375;
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(27, 5, 27, 0),
        child: Card(
          color: widget.themeFlag ? AppColors.creamColor : AppColors.mirage,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: _width * 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.bookingModel.rooms!.roomPhotos[1],
                        imageBuilder: (context, imageProvider) =>
                          Container(
                            height: 80,
                            width: 70,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // child: Container(
                            //   decoration: BoxDecoration(
                            //       color: roomStatus ? Colors.green : Colors.red,
                            //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
                            //   ),

                            //   child: Padding(
                            //     padding: const EdgeInsets.all(5.0),
                            //     child: Text(
                            //       roomStatus ? 'Available' : 'Unavailable',
                            //       style: TextStyle(
                            //           color: Colors.white
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: roomStatus ? Colors.red :  Colors.green,
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
                                ),

                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      roomStatus ? 'Failed' : 'Successful',
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                              ),
                              ],
                            ),
                          ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            'Name : ${widget.bookingModel.rooms!.roomName}',
                            maxLines: 1,
                            style: TextStyle(
                              color: widget.themeFlag
                                  ? AppColors.mirage
                                  : AppColors.creamColor,
                              fontWeight: FontWeight.w500,
                              fontSize: _width * 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6, top: 2),
                          child: Text(
                            'Address : ${widget.bookingModel.rooms!.roomAddress.toString()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: widget.themeFlag
                                  ? AppColors.mirage
                                  : AppColors.creamColor,
                              fontSize: _width * 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6, top: 2),
                          child: Text(
                            'Date : ${widget.bookingModel.bookingDate}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: widget.themeFlag
                                  ? AppColors.mirage
                                  : AppColors.creamColor,
                              fontSize: _width * 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6, top: 2),
                          child: Text(
                            'Price : Ghc${widget.bookingModel.rooms!.roomPrice.toString()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: _width * 13,
                              color: AppColors.yellowish,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
