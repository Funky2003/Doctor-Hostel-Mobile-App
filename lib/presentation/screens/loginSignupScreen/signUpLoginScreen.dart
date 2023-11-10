import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.assets.dart';
import 'package:room_booking/app/routes/app.routes.dart';

class SignupLogin extends StatefulWidget {
  const SignupLogin({super.key});

  @override
  State<SignupLogin> createState() => _SignupLoginState();
}

class _SignupLoginState extends State<SignupLogin> {

  Widget landscape(){
    return const Center(
      child: Text("Landscape"),
    );
  }

  Widget portrait(){
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.multiply),
                  image: AssetImage(AppAssets.homeImage),
                  fit: BoxFit.cover
              ),
              // color: Colors.blue[400]
            ),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.5,
            child: const Center(
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white
                ),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Get connected with\nthe best hostel booking network',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 22.0
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 45.0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              decoration: const BoxDecoration(
                                  color: Colors.blue
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    Navigator.pushNamed(context, AppRouter.loginRoute);
                                  });
                                },
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              decoration: const BoxDecoration(
                                  color: Colors.black87
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  setState(() {
                                    Navigator.pushNamed(context, AppRouter.signupRoute);
                                  });
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38,
                          blurStyle: BlurStyle.outer,
                          blurRadius: 1.0
                      )
                    ],
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(25.0)
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'D.H',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 55.0,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      Text(
                        'Doctor-Hostel',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return portrait();
            } else {
              return landscape();
            }
          },
        )
    );
  }
}
