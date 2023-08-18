import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pathfinder/utilities/dialogs.dart';
import 'package:pathfinder/view/onboarding/reset_password_page.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../utilities/consts/color_consts.dart';
import '../../utilities/text_styles.dart';
import '../../view_model/login_view_model.dart';
import '../../widgets/buttons/basic_button.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/floating_snack_bar.dart';
import 'login_page.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({Key? key}) : super(key: key);

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
                  key: loginViewModel.formKeyPassword,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: CustomTextStyles().largeText(),
                      ),
                      Text(
                        'Looks like you have forgotten your password! Do not worry, we have sent a verification code to the below email to login further',
                        style: CustomTextStyles().text(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        loginViewModel.textEditingControllerEmail.text,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'OTP',
                        style: CustomTextStyles()
                            .text(color: Colors.grey.shade800),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Pinput(
                        length: 6,
                        onChanged: (pin) {
                          loginViewModel.otp = pin;
                          if (pin.length == 6) {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             const ResetPasswordPage()));
                          }
                        },
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Please enter a valid 6 digit OTP';
                          }
                          return null;
                        },
                        onCompleted: (pin) {},
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
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: BasicButton(
                          child: const Text('Resend OTP'),
                          onPressed: () {
                            loginViewModel.sendOTP(onSuccess: () {
                              showSnackBar(context,
                                  message: 'OTP sent to the registered email');
                            }, onFailure: (error) {
                              showSnackBar(context,
                                  message:
                                      'Failed to send OTP, Please check your mail and try again');
                            });
                          },
                        ),
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
                        onChanged: (value) {
                          loginViewModel.newPassword = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        style: CustomTextStyles()
                            .text(color: Colors.grey.shade800),
                        obscureText: loginViewModel.hidePassword,
                        keyboardType: TextInputType.visiblePassword,
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
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: 'Enter Password',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Palette.primaryColor))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Re-enter Password',
                        style: CustomTextStyles()
                            .text(color: Colors.grey.shade800),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: loginViewModel.textEditingControllerPass,
                        // onChanged: (value) {
                        //   loginViewModel.password = value;
                        // },
                        validator: (value) {
                          if (value!.isEmpty ||
                              value != loginViewModel.newPassword) {
                            return "Passwords don't match";
                          }
                          return null;
                        },
                        style: CustomTextStyles()
                            .text(color: Colors.grey.shade800),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: loginViewModel.hidePasswordConfirm,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: Icon(
                                loginViewModel.hidePasswordConfirm
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onTap: () {
                                loginViewModel.setHidePasswordConfirm();
                              },
                            ),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: 'Re-Enter Password',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Palette.primaryColor))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: loginViewModel.showSnackBarOTP,
                        child: FloatingSnackBar(
                          message: 'Invalid OTP',
                          alertType: AlertType.Failure,
                          onCloseClick: () {
                            loginViewModel.setShowSnackBarOTP(false);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: loginViewModel.loading
                              ? const CircularProgressIndicator()
                              : PrimaryButton(
                                  isStretched: true,
                                  onPressed: () {
                                    if (loginViewModel
                                        .formKeyPassword.currentState!
                                        .validate()) {
                                      loginViewModel.resetPassword(
                                          onSuccess: () {
                                        Navigator.pop(context);
                                      }, onFailure: (error) {
                                        loginViewModel.setShowSnackBarOTP(true);
                                        // showSnackBar(context,
                                        //     message:
                                        //         'Invalid Credentials/OTP');
                                      });
                                    }
                                  },
                                  text: 'Continue',
                                ),
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
