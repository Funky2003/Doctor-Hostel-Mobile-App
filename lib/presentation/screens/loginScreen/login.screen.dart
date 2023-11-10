import 'package:flutter/material.dart';
import 'package:room_booking/app/constants/app.assets.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/app/routes/app.routes.dart';
import 'package:room_booking/core/notifiers/authentication.notifier.dart';
import 'package:room_booking/core/utils/obscure.text.util.dart';
import 'package:room_booking/presentation/widgets/custom.button.dart';
import 'package:room_booking/presentation/widgets/custom.snackbar.dart';
import 'package:room_booking/presentation/widgets/custom.styles.dart';
import 'package:room_booking/presentation/widgets/custom.text.field.dart';
import 'package:room_booking/core/notifiers/theme.notifier.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool error, showProgress, _obscureText;
  late String email, password, errorMessage, successMessage;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    email = "";
    password = "";
    errorMessage = "";
    error = false;
    showProgress = false;
    _obscureText = true;
    super.initState();
  }
  Widget errmsg(String text){
    //error message widget.
    return Container(
      padding: const EdgeInsets.all(15.00),
      margin: const EdgeInsets.only(bottom: 10.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
          border: Border.all(color:Colors.red, width:2)
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right:6.00),
            child: const Icon(Icons.info, color: Colors.white),
          ), // icon for error message

          Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
          //show error message text
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScaffoldGradientBackground(
      gradient: LinearGradient(
          colors: [
            Colors.blue[50]!,
            Colors.blue[100]!,
            Colors.blue[200]!,
            Colors.blue[300]!,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const [
            0.2,
            0.5,
            0.8,
            0.7
          ]
      ),
      body: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.blue[50],
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2.5,
                              spreadRadius: 0.5,
                              offset: Offset(0.0, 0.0)
                          )
                        ]
                    ),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(25.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.5,
                                      color: Colors.black12
                                  ),
                                  borderRadius: BorderRadius.circular(50.0)
                              ),
                              child: CircleAvatar(
                                backgroundImage: AssetImage(AppAssets.homeImage),
                                radius: MediaQuery.of(context).size.width * 0.08,
                              ),
                            ),

                            const Text(
                              'Log Into Your Account',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0
                              ),
                            ),

                            //Taking user credentials...
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              child: const Center(
                                child: Text(
                                  'Please enter your details to log in',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 15.0,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                    margin: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Form(
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(bottom: 5.0),
                                                    child: const Text(
                                                      "Email",
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    validator: (val) => !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val!) ? 'Enter an email' : null,
                                                    controller: _email,
                                                    keyboardType: TextInputType.text,
                                                    textAlign: TextAlign.start,
                                                    decoration: const InputDecoration(
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors.blueAccent,
                                                              width: 1.0,
                                                              style: BorderStyle.solid,
                                                            ),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(5.0))),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors.blueAccent,
                                                              width: 1.0,
                                                              style: BorderStyle.solid,
                                                            ),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(10.0))),
                                                        hintText: 'funky@gmail.com',
                                                        hintStyle: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight: FontWeight.w300
                                                        )
                                                    ),
                                                    onChanged: (value){
                                                      email = value;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15.0,
                                          ),

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(bottom: 5.0),
                                                child: const Text(
                                                  "Password",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              TextFormField(
                                                controller: _password,
                                                keyboardType: TextInputType.visiblePassword,
                                                textAlign: TextAlign.start,
                                                obscureText: _obscureText,
                                                decoration: InputDecoration(
                                                  suffixIconColor: Colors.black54,
                                                    suffixIcon: IconButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          _obscureText = !_obscureText;
                                                        });
                                                      },
                                                      icon: Icon(
                                                          _obscureText ? Icons.visibility_off : Icons.visibility
                                                      ),
                                                    ),
                                                    focusedBorder: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.blueAccent,
                                                          width: 1.0,
                                                          style: BorderStyle.solid,
                                                        ),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(5.0))),
                                                    enabledBorder: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.blueAccent,
                                                          width: 1.0,
                                                          style: BorderStyle.solid,
                                                        ),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10.0))),
                                                    hintText: 'Enter password',
                                                    hintStyle: const TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight: FontWeight.w300,
                                                    )
                                                ),
                                                onChanged: (value){
                                                  password = value;
                                                },
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.03,
                                                    child: RawMaterialButton(
                                                      onPressed: (){
                                                        setState(() {});
                                                      },
                                                      child: const Text(
                                                        "Forgot Password?",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 15.0,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),

                                          const SizedBox(
                                            height: 15.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    // color: Colors.grey,
                                    margin: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 1,
                                          decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              setState(() {
                                                login(context: context);
                                              });
                                              //startLogin();
                                            },
                                            child: showProgress?
                                            const SizedBox(
                                              height:30, width:30,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                                              ),
                                            ): const Text(
                                              "Sign in",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Don't have account?",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.18,
                                              child: RawMaterialButton(
                                                onPressed: (){
                                                  Navigator.popAndPushNamed(context, '/signup');
                                                },
                                                child: const Text(
                                                  "Sign up",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),]
      ),
    );
  }

  login({required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        showProgress = true;
      });

      bool isValid = await Provider.of<AuthenticationNotifer>(context, listen: false).login(
        email: _email.text,
        password: _password.text,
      );

      setState(() {
        showProgress = false;
      });

      if (isValid) {
        Navigator.of(context).pushReplacementNamed(AppRouter.navRoute);
        SnackUtil.showSnackBar(
          context: context,
          text: "Login Successfully",
          textColor: AppColors.creamColor,
          backgroundColor: Colors.green,
        );
      } else {
        var errorType = Provider.of<AuthenticationNotifer>(context, listen: false).error;
        SnackUtil.showSnackBar(
          context: context,
          text: errorType!,
          textColor: AppColors.creamColor,
          backgroundColor: Colors.red.shade200,
        );
      }
    }
  }
}

