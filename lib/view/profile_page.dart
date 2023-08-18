import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathfinder/model/user_model.dart';
import 'package:pathfinder/utilities/dialogs.dart';
import 'package:pathfinder/utilities/pref_utils.dart';
import 'package:pathfinder/view/onboarding/login_page.dart';
import 'package:pathfinder/view/onboarding/pin_setup_page.dart';
import 'package:pathfinder/widgets/buttons/primary_button.dart';

import '../utilities/consts/color_consts.dart';
import '../utilities/text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'My Profile',
          style: CustomTextStyles().largeText(color: Colors.white),
        ),
        actions: [
          TextButton.icon(
              onPressed: () {
                showLogoutAlert(context);
                // showActionAlertDialog(context,
                //     message: 'Are you sure? You want to log out', onTap: () {
                //   PrefUtils().clearSPData();
                //   Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //       builder: (BuildContext context) => const LoginPage(),
                //     ),
                //     (route) => false,
                //   );
                // });
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                'Logout',
                style: CustomTextStyles().header(color: Palette.white),
              ))
        ],
      ),
      body: FutureBuilder<String?>(
        future: PrefUtils().getUserData(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            UserModel userModel =
                UserModel.fromJson(jsonDecode(snapShot.data!));
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          'https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg',
                          height: 120,
                          width: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userModel.teamRole!,
                        style: CustomTextStyles()
                            .header(color: Colors.white.withOpacity(.7)),
                      )
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 50,
                // ),
                Expanded(
                    child: Container(
                  width: double.maxFinite,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  decoration: const BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      )),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: SizedBox(
                          width: 60,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Name :',
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(.6)))),
                        ),
                        title: Text(
                          userModel.userName!,
                          style: CustomTextStyles().text(),
                        ),
                        minLeadingWidth: 0,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: SizedBox(
                          width: 60,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Email :',
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(.6)))),
                        ),
                        title: Text(
                          userModel.emailAddress!,
                          style: CustomTextStyles().text(),
                        ),
                        minLeadingWidth: 0,
                      ),
                      // ListTile(
                      //   contentPadding: EdgeInsets.all(0),
                      //   trailing: Container(
                      //     width: 30,
                      //     child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('20',
                      //             style: CustomTextStyles().header())),
                      //   ),
                      //   leading: Text(
                      //     'Number of Hospitals :',
                      //     style: GoogleFonts.aBeeZee(
                      //         fontSize: 14,
                      //         color: Colors.black.withOpacity(.6)),
                      //   ),
                      //   minLeadingWidth: 0,
                      // ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PinSetUpPage(
                                      securityPinType: SecurityPinType.reset)));
                        },
                        title: Text(
                          'Change your Security PIN',
                          style: CustomTextStyles().header(),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_outlined),
                          onPressed: () {},
                        ),
                        minLeadingWidth: 0,
                      ),
                    ],
                  ),
                ))
              ],
            );
          }
          return Center(
            child: Text(
              'No Data to show...',
              style: CustomTextStyles().largeText(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  showLogoutAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            content: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                tileColor: Palette.primaryColor,
                title: Text(
                  'Logout',
                  style: CustomTextStyles().largeText(color: Colors.white),
                ),
                subtitle: Text(
                  'Are you sure, you want to logout?',
                  style: CustomTextStyles().header(color: Colors.white),
                ),
                trailing: Icon(
                  Icons.logout,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                child: SizedBox(
                  width: 100,
                  child: PrimaryButton(
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextButton(
                    onPressed: () {
                      PrefUtils().clearSPData();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const LoginPage(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Logout',
                      style: CustomTextStyles()
                          .header(color: Palette.primaryColor),
                    )),
              ),
            ],
          );
        });
  }
}
