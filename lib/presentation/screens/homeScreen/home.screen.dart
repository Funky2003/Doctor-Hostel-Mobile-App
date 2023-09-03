import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/app/routes/app.routes.dart';
import 'package:room_booking/core/models/events.model.dart';
import 'package:room_booking/core/models/room.model.dart';
import 'package:room_booking/core/notifiers/authentication.notifier.dart';
import 'package:room_booking/core/notifiers/events.notifier.dart';
import 'package:room_booking/core/notifiers/favourite.notifier.dart';
import 'package:room_booking/core/notifiers/theme.notifier.dart';
import 'package:room_booking/core/service/admin.service.dart';
import 'package:room_booking/core/service/booking.service.dart';
import 'package:room_booking/core/service/maps.service.dart';
import 'package:room_booking/presentation/screens/adminRoomsOnly/admin.rooms.only.dart';
import 'package:room_booking/presentation/screens/homeScreen/widgets/events.widget.dart';
import 'package:room_booking/presentation/widgets/custom.snackbar.dart';
import 'package:room_booking/presentation/widgets/shimmer.effects.dart';
import 'package:provider/provider.dart';
import '../../../core/service/room.service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final FocusNode _searchFocusNode = FocusNode();

  late final RoomModel roomModel;
  late final RoomService roomService;

  @override
  void dispose() {
    // TODO: implement dispose
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = _themeNotifier.darkTheme;
    double _height = MediaQuery.of(context).size.height / 815;
    Provider.of<MapsService>(context, listen: false).getCurrentLocation();
    var userData = Provider.of<AuthenticationNotifer>(context, listen: true);
    AuthenticationNotifer _auth = Provider.of<AuthenticationNotifer>(context, listen: true);
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 5.0),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12,
                                    width: 1.0
                                ),
                                borderRadius: BorderRadius.circular(50.0)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  width: MediaQuery.of(context).size.width * 0.78,
                                  child: CupertinoSearchTextField(
                                    onTap: (){
                                      setState(() {
                                        Navigator.pushNamed(context, AppRouter.searchRoute);
                                      });
                                    },
                                    prefixIcon: const Icon(
                                      Icons.search_outlined,
                                      color: Colors.grey,
                                    ),
                                    focusNode: _searchFocusNode,
                                    keyboardType: TextInputType.none,
                                    prefixInsets: const EdgeInsets.only(left: 10.0, right: 3.0),
                                    itemSize: 35.0,
                                    itemColor: AppColors.creamColor,
                                    placeholder: 'Hi!, ${_auth.userName ?? "User"}',
                                    placeholderStyle: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18.0,
                                        color: Colors.grey,
                                    ),
                                    autofocus: false,
                                    backgroundColor: AppColors.creamColor,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // setState(() {
                                    //   showNow();
                                    // });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage('${userData.userPhoto}')
                                      ),
                                        border: Border.all(
                                          width: 1.0,
                                          color: Colors.grey,
                                        ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //Latest Hostels in the area...
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Latest Hostels',
                                    style: TextStyle(
                                        color: themeFlag
                                            ? AppColors.creamColor
                                            : AppColors.mirage,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 25.0
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text(
                                    'Top hostels',
                                    style: TextStyle(
                                        color: themeFlag
                                            ? AppColors.creamColor
                                            : AppColors.mirage,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18.0
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),

                  Container(
                    margin: EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width * 1,
                    height: _height * 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0)
                    ),

                    child: Center(
                      child: FutureBuilder(
                        future: mainRooms(),
                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                            return ShimmerEffects.loadShimmerHome(
                              context: context,
                            );
                          } else{
                            final List<Map<String, dynamic>> itemList = snapshot.data as List<Map<String, dynamic>>;
                            // final Map<int, Map<String, dynamic>> uniqueRooms = {};
                            //
                            // for (final room in itemList) {
                            //   final id = room['admin'] as int;
                            //   uniqueRooms[id] = room;
                            // }

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: itemList.length,
                              itemBuilder: (context, index) {

                                print(itemList[0]['hostel_thumbnail'].toString());
                                final roomName = itemList[index]['hostel_name'] as String;
                                final roomPhotos = itemList[index]['hostel_thumbnail'] as String;
                                final roomAddress = itemList[index]['hostel_location'] as String;
                                final uID = itemList[index]['uID'] as int;
                                final roomTelephone = itemList[index]['mobile_number'] as int;


                                // final roomPrice = itemList[index]['room_price'] as int;
                                // final roomID = itemList[index]['room_id'] as int;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Navigator.of(context).pushNamed(
                                        AppRouter.adminRoomsRoute,
                                        arguments: AdminRoomsOnlyArgs(
                                          uID: uID,
                                          roomName: roomName,
                                          roomAddress: roomAddress,
                                          roomTelephone: roomTelephone
                                        )
                                      );
                                    });
                                  },
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
                                                imageUrl: '$roomPhotos',
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
                                                          '$roomName',
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
                                                                    roomAddress,
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
                                                                'Ghc',
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
                                                  onPressed: (){
                                                    setState(() async {
                                                      var data = Provider.of<FavouriteNotifier>(context, listen: false);
                                                      bool isAdded = await data.addToFavourite(
                                                        userId: _auth.userId!,
                                                        room_id: uID,
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
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                          }

                        },
                      ),
                    ),
                  ),



                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.blue[300],
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'See all',
                                style: TextStyle(
                                    color: Colors.blue
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          //The onTap function goes here...
                          Navigator.pushNamed(context, AppRouter.allRoomsRoute);
                        },
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Events",
                          style: TextStyle(
                            color: themeFlag? AppColors.creamColor : AppColors.mirage,
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          "Happening, Near By Hostels",
                          style: TextStyle(
                            color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: _height * 200,
                    child: Consumer<EventsNotifier>(
                      builder: (context, notifier, _) {
                        return FutureBuilder(
                          future: notifier.getAllEvents(),
                          builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                              return ShimmerEffects.loadShimmerEvent(
                                context: context,
                              );
                            } else {
                              List _snapshot = snapshot.data as List;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  EventsModel eventsModel= _snapshot[index];
                                  return EventsItem(
                                    eventsModel: eventsModel,
                                    onTap: (){},
                                  );
                                },
                              );
                            }
                          },
                        );
                      },
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
  }

  @override
  void initState() {
    // TODO: implement initState
    // mainRooms();
    super.initState();
  }
}

