import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:room_booking/app/constants/app.assets.dart';
import 'package:room_booking/app/constants/app.colors.dart';
import 'package:room_booking/app/routes/app.routes.dart';
import 'package:room_booking/core/models/user.model.dart';
import 'package:room_booking/core/notifiers/authentication.notifier.dart';
import 'package:room_booking/core/notifiers/password.notifier.dart';
import 'package:room_booking/core/utils/obscure.text.util.dart';
import 'package:room_booking/presentation/screens/signupScreen/widgets/custom.password.check.dart';
import 'package:room_booking/presentation/widgets/custom.button.dart';
import 'package:room_booking/presentation/widgets/custom.snackbar.dart';
import 'package:room_booking/presentation/widgets/custom.styles.dart';
import 'package:room_booking/presentation/widgets/custom.text.field.dart';
import 'package:provider/provider.dart';
import 'package:room_booking/core/notifiers/theme.notifier.dart';
import 'package:flutter/material.dart';
// import 'package:hostel_booking/pages/connection/connection.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

// class SignUpScreen extends StatelessWidget {
//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController userPassController = TextEditingController();
//   final TextEditingController userEmailController = TextEditingController();
//   final TextEditingController userPhoneNController = TextEditingController();
//
//   final _formKey = GlobalKey<FormState>();
//   SignUpScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
//     var themeFlag = _themeNotifier.darkTheme;
//     PasswordNotifier passNotifier(bool renderUI) =>
//         Provider.of<PasswordNotifier>(context, listen: renderUI);
//
//     return Scaffold(
//       backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
//       appBar: AppBar(
//         backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios_new,
//             size: 24,
//             color: themeFlag ? AppColors.creamColor : AppColors.mirage,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Flexible(
//                   fit: FlexFit.loose,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Register",
//                         style: kHeadline.copyWith(
//                           color: themeFlag
//                               ? AppColors.creamColor
//                               : AppColors.mirage,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Create new account to get started.",
//                         style: kBodyText2.copyWith(
//                           color: themeFlag
//                               ? AppColors.creamColor
//                               : AppColors.mirage,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             CustomTextField.customTextField(
//                               themeFlag: themeFlag,
//                               hintText: 'Username',
//                               inputType: TextInputType.text,
//                               textEditingController: userNameController,
//                               validator: (val) =>
//                                   val!.isEmpty ? 'Enter a username' : null,
//                             ),
//                             CustomTextField.customTextField(
//                               themeFlag: themeFlag,
//                               hintText: 'Email',
//                               textEditingController: userEmailController,
//                               validator: (val) =>
//                                   val!.isEmpty ? 'Enter a Email' : null,
//                               inputType: TextInputType.text,
//                             ),
//                             CustomTextField.customTextField(
//                               themeFlag: themeFlag,
//                               hintText: 'Enter Mobile No',
//                               inputType: TextInputType.number,
//                               maxLength: 10,
//                               textEditingController: userPhoneNController,
//                               validator: (val) =>
//                                   val!.isEmpty || val.length < 10
//                                       ? 'Enter a valid Mobile'
//                                       : null,
//                             ),
//                             CustomTextField.customPasswordField(
//                               themeFlag: themeFlag,
//                               context: context,
//                               validator: (val) =>
//                                   val!.isEmpty ? 'Enter a password' : null,
//                               onChanged: (val) {
//                                 passNotifier(false)
//                                     .checkPasswordStrength(password: val);
//                               },
//                               onTap: () {
//                                 Provider.of<ObscureTextUtil>(context,
//                                         listen: false)
//                                     .toggleObs();
//                               },
//                               textEditingController: userPassController,
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Text(passNotifier(true).passwordEmoji!),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           if (passNotifier(true).passwordLevel! == 'Weak')
//                             CustomAnimatedContainer.customAnimatedContainer(
//                               height: 10,
//                               width: MediaQuery.of(context).size.width * 0.10,
//                               context: context,
//                               color: Colors.red,
//                               curve: Curves.easeIn,
//                             ),
//                           if (passNotifier(true).passwordLevel! == 'Medium')
//                             CustomAnimatedContainer.customAnimatedContainer(
//                               height: 10,
//                               width: MediaQuery.of(context).size.width * 0.40,
//                               context: context,
//                               color: Colors.blue,
//                               curve: Curves.easeIn,
//                             ),
//                           if (passNotifier(true).passwordLevel! == 'Strong')
//                             CustomAnimatedContainer.customAnimatedContainer(
//                               height: 10,
//                               width: MediaQuery.of(context).size.width * 0.81,
//                               context: context,
//                               color: Colors.green,
//                               curve: Curves.easeIn,
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Already have an account? ",
//                       style: kBodyText.copyWith(
//                         color:
//                             themeFlag ? AppColors.creamColor : AppColors.mirage,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pushNamed(AppRouter.loginRoute);
//                       },
//                       child: Text(
//                         'Sign In',
//                         style: kBodyText.copyWith(
//                           color: themeFlag
//                               ? AppColors.creamColor
//                               : AppColors.mirage,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 CustomButton.customBtnLogin(
//                   buttonName: 'Register',
//                   onTap: () {
//                     signUp(context: context);
//                   },
//                   bgColor: themeFlag ? AppColors.creamColor : AppColors.mirage,
//                   textColor:
//                       themeFlag ? AppColors.mirage : AppColors.creamColor,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   signUp({required BuildContext context}) async {
//     if (_formKey.currentState!.validate()) {
//       String createdAt = DateFormat("EEEEE, dd, yyyy").format(
//         DateTime.now(),
//       );
//       UserModel userModel = UserModel(
//         createdAt: createdAt,
//         userName: userNameController.text,
//         userEmail: userEmailController.text,
//         userPassword: userPassController.text,
//         userPhoneNo: userPhoneNController.text,
//       );
//       bool isValid =
//           await Provider.of<AuthenticationNotifer>(context, listen: false)
//               .signUp(userModel: userModel);
//       if (isValid) {
//         Navigator.of(context).pushReplacementNamed(AppRouter.navRoute);
//         SnackUtil.showSnackBar(
//           context: context,
//           text: "Signup Successfull",
//           textColor: AppColors.creamColor,
//           backgroundColor: Colors.green,
//         );
//       } else {
//         var errorType =
//             Provider.of<AuthenticationNotifi er>(context, listen: false).error;
//         SnackUtil.showSnackBar(
//           context: context,
//           text: errorType!,
//           textColor: AppColors.creamColor,
//           backgroundColor: Colors.red.shade200,
//         );
//       }
//     }
//   }
// }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String value, userName, userEmail, userPassword, userPhoneNo, createdAt;

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  late bool _isLoading, _obscureText;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    createdAt = '';
    userName = '';
    userEmail = '';
    userPassword = '';
    userPhoneNo = '';
    _obscureText = true;
    _isLoading = false;

    super.initState();
  }

  //SignUp function to process the user account registration: I am using async method...
  // signUp({required BuildContext context}) async{
  //   if(_formKey.currentState!.validate()){
  //     //-------Let's create a 'setSate(){}' function to show the circularProgressBar-------//
  //     setState(() {
  //       _isLoading = true;
  //     });
  //
  //     //-------Let's declare and assign all the variables that we will insert into the database-------//
  //     String createdAt = DateFormat('EEEE, YYYY, DD').format(
  //       DateTime.now()
  //     );
  //     //-------Let's declare and assign all the variables that we will insert into the database-------//
  //     UserModel userModel = UserModel(
  //         createdAt: createdAt,
  //         userName: _fullName.text,
  //         userEmail: _email.text,
  //         userPassword: _password.text,
  //         userPhoneNo: _phoneNo.text
  //     );
  //
  //     //-------Let's create a variable to upload the user data-------//
  //     bool isValid = await Provider.of<AuthenticationNotifer>(context, listen: false).signUp(
  //         userModel: userModel
  //     );
  //     setState(() {
  //       _isLoading = false;
  //     });
  //
  //     //-------Let's check if the upload was/is successful-------//
  //     if (isValid){
  //       Navigator.of(context).pushReplacementNamed(AppRouter.navRoute);
  //       SnackUtil.showSnackBar(
  //         context: context,
  //         text: "Signup Successfull",
  //         textColor: AppColors.creamColor,
  //         backgroundColor: Colors.green,
  //       );
  //     }
  //
  //     //-------In case of an error, let's receive the error and display it-------//
  //     else{
  //       var errorText = Provider.of<AuthenticationNotifer>(context, listen: false).error;
  //       SnackUtil.showSnackBar(
  //           context: context,
  //           text: errorText!,
  //           textColor: AppColors.creamColor,
  //           backgroundColor: Colors.red.shade200,
  //       );
  //     }
  //   }
  // }

  // Function to display alert messages...
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
        stops: const [
          0.2,
          0.5,
          0.8,
          0.7
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
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
                              'Sign Up Now',
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
                                  'Please enter your details to create your account',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
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
                                          TextFormField(
                                            controller: _fullName,
                                            autovalidateMode: AutovalidateMode.always,
                                            keyboardType: TextInputType.text,
                                            textAlign: TextAlign.start,
                                            decoration: const InputDecoration(
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.blueAccent,
                                                      width: 1.0,
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.blueAccent,
                                                      width: 1.0,
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10.0))),
                                                hintText: 'Username',
                                                hintStyle: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w300
                                                )),
                                          ),

                                          const SizedBox(
                                            height: 15.0,
                                          ),

                                          TextField(
                                            controller: _email,
                                            keyboardType: TextInputType.emailAddress,
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
                                                hintText: 'Email',
                                                hintStyle: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w300
                                                )),
                                          ),

                                          const SizedBox(
                                            height: 15.0,
                                          ),

                                          TextFormField(
                                            controller: _phoneNo,
                                            keyboardType: TextInputType.number,
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
                                                hintText: 'Enter Mobile Number',
                                                hintStyle: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w300
                                                )),
                                          ),

                                          const SizedBox(
                                            height: 15.0,
                                          ),

                                          TextField(
                                            controller: _password,
                                            keyboardType: TextInputType.visiblePassword,
                                            obscureText: _obscureText,
                                            textAlign: TextAlign.start,
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
                                                    )),
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
                                                hintText: 'Password',
                                                hintStyle: const TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w300
                                                )),
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
                                                signUp(context: context);
                                              });
                                            },
                                            child: _isLoading?
                                            const SizedBox(
                                              height:30, width:30,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                                              ),
                                            ): const Text(
                                              "Sign up",
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
                                              "Already have account?",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.18,
                                              child: RawMaterialButton(
                                                onPressed: () {
                                                  Navigator.popAndPushNamed(context, '/login');
                                                },
                                                child: const Text(
                                                  "Sign in",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.bold),
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


  signUp({required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      createdAt = DateFormat("EEEEE, dd, yyyy").format(
        DateTime.now(),
      );
      UserModel userModel = UserModel(
        createdAt: createdAt,
        userName: _fullName.text,
        userEmail: _email.text,
        userPassword: _password.text,
        userPhoneNo: _phoneNo.text,
      );
      bool isValid = await Provider.of<AuthenticationNotifer>(context, listen: false).signUp(userModel: userModel);
      setState(() {
        _isLoading = false;
      });

      if (isValid) {
        Navigator.of(context).pushReplacementNamed(AppRouter.navRoute);
        SnackUtil.showSnackBar(
          context: context,
          text: "Signup Successfull",
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

