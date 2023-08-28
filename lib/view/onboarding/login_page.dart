import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pathfinder/model/user_model.dart';
import 'package:pathfinder/utilities/consts/color_consts.dart';
import 'package:pathfinder/utilities/consts/constants.dart';
import 'package:pathfinder/utilities/dialogs.dart';
import 'package:pathfinder/utilities/utility_functions.dart';
import 'package:pathfinder/view/am_dashboard_page.dart';
import 'package:pathfinder/view/onboarding/otp_page.dart';
import 'package:pathfinder/view/onboarding/pin_setup_page.dart';
import 'package:pathfinder/widgets/buttons/basic_button.dart';
import 'package:pathfinder/widgets/floating_snack_bar.dart';
import 'package:provider/provider.dart';

import '../../network/local_auth_api.dart';
import '../../utilities/text_styles.dart';
import '../../view_model/login_view_model.dart';
import '../../widgets/buttons/primary_button.dart';
import '../dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  // void initState() {
  //   initBiometricAuth();
  //   super.initState();
  // }
  //
  // initBiometricAuth() async {
  //   final myModel = Provider.of<LoginViewModel>(context, listen: false);
  //   var userData = await myModel.userData();
  //   if (userData != null) {
  //     UserModel userModel = UserModel.fromJson(jsonDecode(userData));
  //     bool? isLoggedIn = userData.isNotEmpty;
  //     final isAvailable = await LocalAuthApi.hasBiometrics();
  //     if (isAvailable && isLoggedIn) {
  //       final isAuthenticated = await LocalAuthApi.authenticate();
  //
  //       if (isAuthenticated) {
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(
  //               builder: (context) => userModel.teamRole == UserRole.mr
  //                   ? const DashboardPage()
  //                   : const AMDashboardPage()),
  //         );
  //       }
  //     } else {
  //       showSnackBar(context,
  //           message: 'Your device does not support biometrics login,');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = context.watch<LoginViewModel>();
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Image.asset(
                'assets/images/white_logo.png',
                height: 120,
              ),
            ),
            // const SizedBox(
            //   height: 50,
            // ),
            Expanded(
                child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 50, bottom: 10),
              decoration: const BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  )),
              child: SingleChildScrollView(
                child: Form(
                  key: loginViewModel.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log In',
                        style: CustomTextStyles().largeText(),
                      ),
                      Text(
                        'Enter your email and password to continue.',
                        style: CustomTextStyles().text(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Email',
                        style: CustomTextStyles()
                            .text(color: Colors.grey.shade800),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: loginViewModel.textEditingControllerEmail,
                        textInputAction: TextInputAction.next,
                        // onChanged: (value) {
                        //   loginViewModel.email = value;
                        // },
                        validator: (value) {
                          if (value!.isEmpty || !isValidEmail(value)) {
                            return 'Please enter a valid e-mail';
                          }
                          return null;
                        },
                        style: CustomTextStyles()
                            .text(color: Colors.grey.shade800),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: 'Enter Email',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Palette.primaryColor))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Password',
                        style: CustomTextStyles()
                            .text(color: Colors.grey.shade800),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: loginViewModel.textEditingControllerPass,
                        textInputAction: TextInputAction.done,
                        // onChanged: (value) {
                        //   loginViewModel.password = value;
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        style: CustomTextStyles()
                            .text(color: Colors.grey.shade800),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: loginViewModel.hidePassword,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: Icon(
                                loginViewModel.hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onTap: () {
                                loginViewModel.setHidePassword();
                              },
                            ),
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: 'Enter Password',
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Palette.primaryColor))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: loginViewModel.showSnackBar,
                        child: FloatingSnackBar(
                          message: 'Invalid Credentials',
                          alertType: AlertType.Failure,
                          onCloseClick: () {
                            loginViewModel.setShowSnackBar(false);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: BasicButton(
                          child: const Text('Forgot Password?'),
                          onPressed: () {
                            if (isValidEmail(loginViewModel
                                .textEditingControllerEmail.text)) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const OTPPage()));
                              loginViewModel.sendOTP(onSuccess: () {
                                showSnackBar(context,
                                    message:
                                        'OTP sent to the registered email');
                              }, onFailure: (error) {
                                showSnackBar(context,
                                    message:
                                        'Failed to send OTP, Please check your mail and try again');
                              });
                            } else {
                              showSnackBar(context,
                                  message: 'Enter a valid email address');
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: loginViewModel.loading
                            ? const CircularProgressIndicator()
                            : PrimaryButton(
                                isStretched: true,
                                onPressed: () {
                                  if (loginViewModel.formKey.currentState!
                                      .validate()) {
                                    loginViewModel.login(onSuccess: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PinSetUpPage(
                                                      securityPinType:
                                                          SecurityPinType
                                                              .setUp)));
                                    }, onFailure: (error) {
                                      debugPrint('error $error');
                                      loginViewModel.setShowSnackBar(true);
                                      // showSnackBar(context,
                                      //     message: 'Invalid Credentials');
                                    });
                                  }
                                },
                                text: 'Continue',
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
