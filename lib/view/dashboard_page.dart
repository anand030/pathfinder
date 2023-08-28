import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pathfinder/model/user_model.dart';
import 'package:pathfinder/utilities/consts/color_consts.dart';
import 'package:pathfinder/utilities/consts/constants.dart';
import 'package:pathfinder/utilities/text_styles.dart';
import 'package:pathfinder/view/hospital_detail_page.dart';
import 'package:pathfinder/view/profile_page.dart';
import 'package:pathfinder/view/widget_screens/empty_data_screen.dart';
import 'package:provider/provider.dart';

import '../network/local_auth_api.dart';
import '../notification_services.dart';
import '../utilities/pref_utils.dart';
import '../view_model/dashboard_view_model.dart';
import 'notifications_page.dart';
import 'onboarding/login_page.dart';

class DashboardPage extends StatefulWidget {
  final String userRole;

  const DashboardPage({Key? key, this.userRole = UserRole.mr})
      : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
    if (widget.userRole == UserRole.mr) {
      dashBoardViewModel.getUserPerformanceFromLocalStorage();
      dashBoardViewModel.getUserPerformance(onFailure: (response) {
        if (response.code == 401) {
          logOut();
        }
      });
    } else {
      dashBoardViewModel.getMRPerformance(onFailure: (response) {
        if (response.code == 401) {
          logOut();
        }
      });
    }
  }

  logOut() {
    PrefUtils().clearSPData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = context.watch<DashboardViewModel>();
    return Scaffold(
      appBar: widget.userRole == UserRole.mr
          ? AppBar(
              elevation: 0,
              leadingWidth: 0,
              backgroundColor: Colors.transparent,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Territory',
                    style: CustomTextStyles().largeText(),
                  ),
                  FutureBuilder(
                    future: PrefUtils().getUserData(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        if (snapShot.data!.isNotEmpty) {
                          UserModel userModel =
                              UserModel.fromJson(jsonDecode(snapShot.data!));
                          return userModel.teamRole == UserRole.mr
                              ? Text(
                                  '${userModel.userName}, ${userModel.areaCode}',
                                  style: CustomTextStyles()
                                      .text(color: Palette.secondaryColor),
                                )
                              : Container();
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
                      size: 40,
                    )),
              ],
            )
          : AppBar(
              centerTitle: true,
              leadingWidth: 50,
              title: Text(
                dashboardViewModel.selectedMR.name ?? '...',
                style: CustomTextStyles().header(color: Colors.white),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              actions: [
                Container(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SvgPicture.asset(
                    'assets/images/mr_icon.svg',
                    width: 40,
                  ),
                )
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
                      dashboardViewModel.searchForHospitals(value);
                    },
                    decoration: InputDecoration(
                        hintText: 'Search For Hospitals',
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
                        'Territory Summary',
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
                          .performanceModel.data!.territorySummary!.length,
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
                                  '${dashboardViewModel.performanceModel.data!.territorySummary![index].value} ${dashboardViewModel.performanceModel.data!.territorySummary![index].symbol}'
                                      .toString(),
                                  style: CustomTextStyles()
                                      .header(color: Palette.primaryColor),
                                ),
                              ),
                            ),
                            Text(
                              dashboardViewModel.performanceModel.data!
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
                        'Territory Detailed',
                        style: CustomTextStyles().header(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                dashboardViewModel.hospitalList.isEmpty
                    ? EmptyDataScreen(
                        image: 'empty_box.jpg',
                        title: 'Oops, Its empty in here')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: dashboardViewModel.hospitalList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              dashboardViewModel.selectedHospital =
                                  dashboardViewModel.hospitalList[index];
                              dashboardViewModel.getHospitalDetails();
                              dashboardViewModel.getNotes();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HospitalDetailPage()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Card(
                                margin: EdgeInsets.zero,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color:
                                        Palette.primaryColor.withOpacity(0.4),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        dashboardViewModel
                                            .hospitalList[index].name!,
                                        style: CustomTextStyles().header(),
                                      ),
                                      trailing: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: dashboardViewModel
                                                        .hospitalList[index]
                                                        .alertType! ==
                                                    HospitalAlertType.green
                                                ? Colors.green
                                                : dashboardViewModel
                                                            .hospitalList[index]
                                                            .alertType! ==
                                                        HospitalAlertType.red
                                                    ? Colors.red
                                                    : Colors.orange,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
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
                                                      BorderRadius.circular(80),
                                                  child: dashboardViewModel
                                                          .hospitalList[index]
                                                          .icon!
                                                          .isEmpty
                                                      ? SvgPicture.asset(
                                                          'assets/images/hospital_icon.svg')
                                                      : Image.network(
                                                          dashboardViewModel
                                                              .hospitalList[
                                                                  index]
                                                              .icon!),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(dashboardViewModel
                                                  .hospitalList[index]
                                                  .strategy!)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Palette.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(30))),
                                          width: 250,
                                          height: 120,
                                          child: ListView.builder(
                                              itemCount: dashboardViewModel
                                                  .hospitalList[index]
                                                  .indicators!
                                                  .length,
                                              itemBuilder: (context, i) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10, left: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                            '${dashboardViewModel.hospitalList[index].indicators![i].value!} ${dashboardViewModel.hospitalList[index].indicators![i].symbol!}',
                                                            style: GoogleFonts
                                                                .aBeeZee(
                                                                    textStyle:
                                                                        TextStyle(
                                                              fontSize: 13,
                                                              color: Palette
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ))),
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                        colors: [
                                                                      Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .8),
                                                                      Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .8),
                                                                      Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .7),
                                                                      Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .5),
                                                                    ]),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8,
                                                                vertical: 4),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          dashboardViewModel
                                                              .hospitalList[
                                                                  index]
                                                              .indicators![i]
                                                              .name!,
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                                  textStyle:
                                                                      TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Palette.white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                ListTile(
                                                  leading: Text(
                                                    dashboardViewModel
                                                        .performanceModel
                                                        .data!
                                                        .hospitals![index]
                                                        .indicators![i]
                                                        .value!
                                                        .toString(),
                                                    style: CustomTextStyles()
                                                        .text(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  trailing: SizedBox(
                                                    width: 200,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        dashboardViewModel
                                                            .performanceModel
                                                            .data!
                                                            .hospitals![index]
                                                            .indicators![i]
                                                            .name!,
                                                        style: CustomTextStyles()
                                                            .text(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ),
                                                  dense: true,
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
  }
}
