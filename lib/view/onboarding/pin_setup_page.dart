import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../network/local_auth_api.dart';
import '../../utilities/consts/color_consts.dart';
import '../../utilities/consts/constants.dart';
import '../../utilities/dialogs.dart';
import '../../utilities/text_styles.dart';
import '../../view_model/login_view_model.dart';
import '../../widgets/buttons/basic_button.dart';
import '../../widgets/buttons/primary_button.dart';
import '../am_dashboard_page.dart';
import '../dashboard_page.dart';

enum SecurityPinType { authenticate, setUp, reset }

class PinSetUpPage extends StatefulWidget {
  final SecurityPinType securityPinType;

  const PinSetUpPage({Key? key, required this.securityPinType})
      : super(key: key);

  @override
  State<PinSetUpPage> createState() => _PinSetUpPageState();
}

class _PinSetUpPageState extends State<PinSetUpPage> {
  void initState() {
    if (widget.securityPinType == SecurityPinType.authenticate) {
      initBiometricAuth();
    }
    super.initState();
  }

  // void getToken() async {
  //   var token = await FirebaseMessaging.instance.getToken();
  //   debugPrint('tken $token');
  // }

  initBiometricAuth() async {
    final myModel = Provider.of<LoginViewModel>(context, listen: false);
    var userData = await myModel.userData();
    if (userData != null) {
      UserModel userModel = UserModel.fromJson(jsonDecode(userData));
      bool? isLoggedIn = userData.isNotEmpty;
      final isAvailable = await LocalAuthApi.hasBiometrics();
      if (isAvailable && isLoggedIn) {
        final isAuthenticated = await LocalAuthApi.authenticate();

        if (isAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => userModel.teamRole == UserRole.mr
                    ? const DashboardPage()
                    : const AMDashboardPage()),
          );
        }
      } else {
        showSnackBar(context,
            message: 'Your device does not support biometrics login,');
      }
    }
  }

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
                  key: loginViewModel.formKeySecurityPin,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Security Pin',
                        style: CustomTextStyles().largeText(),
                      ),
                      Text(
                        'Security Pin is used to login into the app.',
                        style: CustomTextStyles().text(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Pinput(
                        length: 6,
                        controller:
                            loginViewModel.textEditingControllerSecurityPin,
                        onChanged: (pin) {},
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Please enter a valid 6 digit Security Pin';
                          }
                          return null;
                        },
                        onCompleted: (pin) {},
                        obscureText: true,
                        defaultPinTheme: const PinTheme(
                          width: 45,
                          height: 45,
                          margin: EdgeInsets.only(right: 10),
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Palette.black)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible: widget.securityPinType ==
                            SecurityPinType.authenticate,
                        child: FutureBuilder(
                          future: loginViewModel.userData(),
                          builder: (context, snapShot) {
                            if (snapShot.hasData) {
                              if (snapShot.data!.isNotEmpty) {
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: BasicButton(
                                      child: const Text('Use Fingerprint'),
                                      onPressed: () async {
                                        initBiometricAuth();
                                      }),
                                );
                              }
                              return Container();
                            }
                            return Container();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: loginViewModel.loading
                            ? const CircularProgressIndicator()
                            : PrimaryButton(
                                isStretched: true,
                                onPressed: () async {
                                  if (loginViewModel
                                      .formKeySecurityPin.currentState!
                                      .validate()) {
                                    String? userData =
                                        await loginViewModel.userData();
                                    UserModel userModel = UserModel.fromJson(
                                        jsonDecode(userData!));

                                    if (widget.securityPinType ==
                                        SecurityPinType.authenticate) {
                                      loginViewModel.authenticateSecurityPin(
                                          onSuccess: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => userModel
                                                            .teamRole ==
                                                        UserRole.mr
                                                    ? const DashboardPage()
                                                    : const AMDashboardPage()));
                                      }, onFailure: (error) {
                                        showSnackBar(context,
                                            message: 'Invalid Pin');
                                      });
                                    }
                                    if (widget.securityPinType ==
                                        SecurityPinType.setUp) {
                                      loginViewModel.setSecurityPin(
                                          onSuccess: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => userModel
                                                            .teamRole ==
                                                        UserRole.mr
                                                    ? const DashboardPage()
                                                    : const AMDashboardPage()));
                                      }, onFailure: (error) {
                                        // loginViewModel.setShowSnackBar(true);
                                        // showSnackBar(context,
                                        //     message: 'Invalid Credentials');
                                      });
                                    }
                                    if (widget.securityPinType ==
                                        SecurityPinType.reset) {
                                      loginViewModel.setSecurityPin(
                                          onSuccess: () {
                                        Navigator.pop(context);
                                      }, onFailure: (error) {
                                        // loginViewModel.setShowSnackBar(true);
                                        // showSnackBar(context,
                                        //     message: 'Invalid Credentials');
                                      });
                                    }
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
