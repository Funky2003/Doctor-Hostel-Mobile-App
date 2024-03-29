import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/core/models/room.model.dart';
import 'package:room_booking/core/notifiers/authentication.notifier.dart';
import 'package:room_booking/core/notifiers/favourite.notifier.dart';
import 'package:room_booking/presentation/widgets/custom.snackbar.dart';
import 'package:provider/provider.dart';

Widget imageSlider({required RoomModel roomModel, required BuildContext context}) {
  AuthenticationNotifer _auth = Provider.of<AuthenticationNotifer>(context, listen: true);
  return SafeArea(
    child: Container(
      height: MediaQuery.of(context).size.width - 50,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Swiper(
            itemCount: roomModel.roomPhotos.length,
            pagination: const SwiperPagination(
              builder: SwiperPagination.dots,
            ),
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: roomModel.roomPhotos[index],
                imageBuilder: (context, imageProvider) => Container(
                  margin: EdgeInsets.only(left: 15.0, right: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              );
            },
          ),
          Positioned(
            right: 30,
            bottom: -15,
            child: InkWell(
              onTap: () async {
                var data = await Provider.of<FavouriteNotifier>(context, listen: false);
                bool isAdded = await data.addToFavourite(
                  userId: _auth.userId!,
                  room_id: roomModel.roomId,
                );
                if (isAdded) {
                  SnackUtil.showSnackBar(
                    context: context,
                    text: 'Added To Favourite',
                    textColor: AppColors.creamColor,
                    backgroundColor: Colors.red.shade200,
                  );
                } else {
                  SnackUtil.showSnackBar(
                    context: context,
                    text: data.error!,
                    textColor: AppColors.creamColor,
                    backgroundColor: Colors.red.shade200,
                  );
                }
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.pink.shade400,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
