import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import '../../../core/models/admin.model.dart';

class AdminItem extends StatelessWidget {
  AdminItem({Key? key, this.onTap, required this.adminModel}) : super(key: key);

  final GestureTapCallback? onTap;
  final AdminModel adminModel;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height / 815;
    double _width = MediaQuery.of(context).size.width / 375;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _height * 205,
        width: _width * 375,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Stack(
            children: [
              // CachedNetworkImage(
              //   imageUrl: eventsModel.eventImage,
              //   imageBuilder: (context, imageProvider) => Container(
              //     height: _height * 205,
              //     width: _width * 375,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: imageProvider,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),
              Container(
                height: _height * 205,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.5, 0.8],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 115,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      adminModel.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _height * 12,
                      ),
                    ),
                    Text(
                      adminModel.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _height * 14,
                      ),
                    ),
                    Text(
                      '${adminModel.uID} , ${adminModel.mobileNumber}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _height * 12,
                      ),
                    ),
                    Text(
                      adminModel.createdAt,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.yellowish,
                        fontSize: _height * 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
