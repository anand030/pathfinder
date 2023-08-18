// import 'package:flutter/material.dart';
// import 'package:pathfinder/utilities/consts/color_consts.dart';
// import 'package:pathfinder/utilities/utility_functions.dart';
// import 'package:pathfinder/view/onboarding/login_page.dart';
// import 'package:pathfinder/view/onboarding/otp_page.dart';
// import 'package:pathfinder/widgets/buttons/basic_button.dart';
// import 'package:provider/provider.dart';
//
// import '../../view_model/login_view_model.dart';
// import '../../widgets/buttons/primary_button.dart';
// import '../dashboard_page.dart';
//
// class ResetPasswordPage extends StatelessWidget {
//   const ResetPasswordPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     LoginViewModel loginViewModel = context.watch<LoginViewModel>();
//     return Scaffold(
//       backgroundColor: Palette.primaryColor,
//       body: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(50),
//               child: Image.asset(
//                 'assets/images/white_logo.png',
//                 height: 120,
//               ),
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             Expanded(
//                 child: Container(
//               width: double.maxFinite,
//               padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
//               decoration: const BoxDecoration(
//                   color: Palette.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(50),
//                   )),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: loginViewModel.formKeyPassword,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Reset Password',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w700),
//                       ),
//                       const Text(
//                         'Set the new password for your account',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w400),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       const Text(
//                         'Password',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w400),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       TextFormField(
//                         onChanged: (value) {
//                           loginViewModel.newPassword = value;
//                         },
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Password is required';
//                           }
//                           return null;
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 10),
//                             hintText: 'Enter Email',
//                             border: OutlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: Palette.primaryColor))),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Text(
//                         'Re-enter Password',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w400),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       TextFormField(
//                         onChanged: (value) {
//                           loginViewModel.password = value;
//                         },
//                         validator: (value) {
//                           if (value!.isEmpty ||
//                               value != loginViewModel.newPassword) {
//                             return "Passwords don't match";
//                           }
//                           return null;
//                         },
//                         keyboardType: TextInputType.visiblePassword,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 10),
//                             hintText: 'Enter Password',
//                             border: OutlineInputBorder(
//                                 borderSide:
//                                     BorderSide(color: Palette.primaryColor))),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: loginViewModel.loading
//                             ? const CircularProgressIndicator()
//                             : PrimaryButton(
//                                 onPressed: () {
//                                   if (loginViewModel
//                                       .formKeyPassword.currentState!
//                                       .validate()) {
//                                     loginViewModel.resetPassword(
//                                         onSuccess: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       LoginPage()));
//                                         },
//                                         onFailure: (error) {});
//                                   }
//                                 },
//                                 text: 'Continue',
//                               ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }
