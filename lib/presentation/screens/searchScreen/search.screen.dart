import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.assets.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/app/routes/app.routes.dart';
import 'package:room_booking/core/models/room.model.dart';
import 'package:room_booking/core/notifiers/room.notifier.dart';
import 'package:room_booking/core/notifiers/theme.notifier.dart';
import 'package:room_booking/presentation/screens/roomScreen/room.screen.dart';
import 'package:room_booking/presentation/widgets/no.data.dart';
import 'package:room_booking/presentation/screens/searchScreen/widgets/search.items.dart';
import 'package:room_booking/presentation/widgets/custom.styles.dart';
import 'package:room_booking/presentation/widgets/custom.text.field.dart';
import 'package:room_booking/presentation/widgets/shimmer.effects.dart';
import 'package:provider/provider.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchProductController = TextEditingController();
  bool isExecuted = false;

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    double _height = MediaQuery.of(context).size.height / 815;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 25.0),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1.0
                      ),
                      borderRadius: BorderRadius.circular(50.0)
                  ),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(50.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              width: 1.0
                          ),
                          borderRadius: BorderRadius.circular(50.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: CupertinoSearchTextField(
                              controller: searchProductController,
                              prefixIcon: const Icon(
                                Icons.search_outlined,
                                color: Colors.grey,
                              ),
                              prefixInsets: const EdgeInsets.only(left: 10.0, right: 3.0),
                              itemSize: 35.0,
                              itemColor: AppColors.creamColor,
                              // placeholder: 'Hi!, ${_auth.userName ?? "User"}',
                              placeholder: 'Search room here',
                              placeholderStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18.0,
                                  color: Colors.grey
                              ),
                              backgroundColor: AppColors.creamColor,
                              borderRadius: BorderRadius.circular(50.0),
                              onChanged: (val){
                                setState(() {
                                  isExecuted = true;
                                });
                              },
                            ),
                          ),
                          // Container(
                          //   margin: const EdgeInsets.only(right: 8.0),
                          //   child: InkWell(
                          //     onTap: () {
                          //       // setState(() {
                          //       //   showNow();
                          //       // });
                          //     },
                          //     child: CircleAvatar(
                          //       radius: MediaQuery.of(context).size.width * 0.04,
                          //       backgroundImage: NetworkImage(
                          //         '',
                          //       ),
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //             border: Border.all(
                          //               width: 1.0,
                          //               color: Colors.grey,
                          //             ),
                          //             borderRadius: const BorderRadius.all(Radius.circular(50.0))
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       side: BorderSide(
              //         color: AppColors.rawSienna,
              //         width: 1,
              //       ),
              //     ),
              //     elevation: 6,
              //     color: themeFlag ? AppColors.mirage : AppColors.creamColor,
              //     child: CustomTextField.customTextField2(
              //       hintText: 'Search',
              //       inputType: TextInputType.text,
              //       textEditingController: searchProductController,
              //       validator: (val) => val!.isEmpty ? 'Enter a Search' : null,
              //       themeFlag: themeFlag,
              //       onChanged: (val) {
              //         setState(() {
              //
              //         });
              //       },
              //     ),
              //   ),
              // ),
              isExecuted
                  ? searchData(
                      searchContent: searchProductController.text,
                      themeFlag: themeFlag)
                  : Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              // Container(
                              //   child: Image.asset(AppAssets.homeImage),
                              // ),
                              Text(
                                'Search Your Room 🔥🤞',
                                style: kBodyText.copyWith(
                                  fontSize: _height * 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeFlag
                                      ? AppColors.creamColor
                                      : AppColors.mirage,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget searchData({required String searchContent, required bool themeFlag}) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          child: Consumer<RoomNotifier>(
            builder: (context, notifier, _) {
              return FutureBuilder(
                future: notifier.getSearchRooms(
                  roomName: searchProductController.text.replaceAll('', ''),
                ),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ShimmerEffects.loadShimmerFavouriteandSearch(
                        context: context, displayTrash: false);
                  } else {

                    if (snapshot.data == null) {
                      return noDataFound(
                        themeFlag: themeFlag,
                      );
                    } else {
                      List _snapshot = snapshot.data as List;
                      print(searchProductController.text.replaceAll(' ', ''));
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          RoomModel roomModel = _snapshot[index];
                          return SearchItem(
                            roomModel: roomModel,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRouter.roomDetailRoute,
                                arguments: RoomScreenArgs(
                                  room_id: roomModel.roomId,
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
