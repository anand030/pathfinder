import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pathfinder/utilities/consts/constants.dart';
import 'package:pathfinder/view/dashboard_page.dart';
import 'package:pathfinder/view/profile_page.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../notification_services.dart';
import '../utilities/consts/color_consts.dart';
import '../utilities/pref_utils.dart';
import '../utilities/text_styles.dart';
import '../view_model/dashboard_view_model.dart';
import 'hospital_detail_page.dart';
import 'notifications_page.dart';

class AMDashboardPage extends StatefulWidget {
  const AMDashboardPage({Key? key}) : super(key: key);

  @override
  State<AMDashboardPage> createState() => _AMDashboardPageState();
}

class _AMDashboardPageState extends State<AMDashboardPage> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();

    notificationServices.requestNotificationPermission();
    notificationServices.foregroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);

    final dashBoardViewModel =
        Provider.of<DashboardViewModel>(context, listen: false);
    dashBoardViewModel.getAMUserPerformanceFromLocalStorage();
    dashBoardViewModel.getAMUserPerformance();
  }

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = context.watch<DashboardViewModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Area',
              style: CustomTextStyles().largeText(),
            ),
            FutureBuilder(
              future: PrefUtils().getUserData(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  if (snapShot.data!.isNotEmpty) {
                    UserModel userModel =
                        UserModel.fromJson(jsonDecode(snapShot.data!));
                    return Text(
                      '${userModel.userName}, ${userModel.areaCode}',
                      style: CustomTextStyles()
                          .text(color: Palette.secondaryColor),
                    );
                  }
                  return Container();
                }
                return Container();
              },
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                dashboardViewModel.getNotificationsFromLocalStorage();
                dashboardViewModel.getAllNotifications();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsPage()));
              },
              icon: const Icon(
                Icons.notifications,
                color: Palette.primaryColor,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              },
              icon: const Icon(
                Icons.account_circle_rounded,
                color: Palette.primaryColor,
                size: 30,
              )),
        ],
      ),
      body: dashboardViewModel.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 30),
                  child: TextFormField(
                    onChanged: (value) {
                      dashboardViewModel.searchForMR(value);
                    },
                    decoration: InputDecoration(
                        hintText: 'Search For MRs',
                        suffixIcon: Icon(Icons.search)),
                  ),
                ),
                Wrap(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: const BoxDecoration(
                          color: Palette.primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: Text(
                        'My Performance',
                        style: CustomTextStyles().header(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 220,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemCount: dashboardViewModel
                          .amPerformanceModel.data!.territorySummary!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              height: 60,
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: Palette.primaryColor),
                                  color: Color(0xFFEDCBE2).withOpacity(0.7)),
                              child: Center(
                                child: Text(
                                  '${dashboardViewModel.amPerformanceModel.data!.territorySummary![index].value} %',
                                  style: CustomTextStyles()
                                      .header(color: Palette.primaryColor),
                                ),
                              ),
                            ),
                            Text(
                              dashboardViewModel.amPerformanceModel.data!
                                      .territorySummary![index].name ??
                                  '...',
                              textAlign: TextAlign.center,
                              style: CustomTextStyles().text(),
                            )
                          ],
                        );
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                Wrap(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: const BoxDecoration(
                          color: Palette.primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: Text(
                        'My Territories',
                        style: CustomTextStyles().header(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: dashboardViewModel.mrList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          dashboardViewModel.selectedMR =
                              dashboardViewModel.mrList[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardPage(
                                        userRole: UserRole.am,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Card(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Palette.primaryColor.withOpacity(0.4),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    dashboardViewModel.mrList[index].name!,
                                    style: CustomTextStyles().header(),
                                  ),
                                  // trailing: Container(
                                  //   height: 20,
                                  //   width: 20,
                                  //   decoration: BoxDecoration(
                                  //       color: Colors.green,
                                  //       shape: BoxShape.circle),
                                  // ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, bottom: 5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.orangeAccent),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: SvgPicture.asset(
                                                  'assets/images/mr_icon.svg'),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(dashboardViewModel
                                              .mrList[index].areaCode!)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Palette.primaryColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30))),
                                      width: 250,
                                      height: 120,
                                      child: ListView.builder(
                                          itemCount: dashboardViewModel
                                              .mrList[index].indicators!.length,
                                          itemBuilder: (context, i) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  top: 10, left: 15),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      '${dashboardViewModel.mrList[index].indicators![i].value!} %',
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                              textStyle:
                                                                  TextStyle(
                                                        fontSize: 13,
                                                        color: Palette
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Colors.white
                                                                  .withOpacity(
                                                                      .8),
                                                              Colors.white
                                                                  .withOpacity(
                                                                      .8),
                                                              Colors.white
                                                                  .withOpacity(
                                                                      .7),
                                                              Colors.white
                                                                  .withOpacity(
                                                                      .5),
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      dashboardViewModel
                                                          .mrList[index]
                                                          .indicators![i]
                                                          .name!,
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                              textStyle:
                                                                  TextStyle(
                                                        fontSize: 14,
                                                        color: Palette.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
    );
    ;
  }
}
