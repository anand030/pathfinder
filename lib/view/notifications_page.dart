import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pathfinder/view/profile_page.dart';
import 'package:pathfinder/view/widget_screens/empty_data_screen.dart';
import 'package:provider/provider.dart';

import '../utilities/consts/color_consts.dart';
import '../utilities/text_styles.dart';
import '../view_model/dashboard_view_model.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = context.watch<DashboardViewModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'Notifications',
          style: CustomTextStyles().largeText(),
        ),
        actions: [
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
          // SizedBox(
          //   width: 10,
          // )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: dashboardViewModel.loadingNotification
            ? Center(
                child: CircularProgressIndicator(),
              )
            : dashboardViewModel.notificationModel.data!.isEmpty
                ? Center(
                    child: EmptyDataScreen(
                        image: 'empty_box.jpg',
                        title: 'Oops, Its empty in here'),
                  )
                : ListView.builder(
                    itemCount:
                        dashboardViewModel.notificationModel.data!.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              minLeadingWidth: 0,
                              leading: dashboardViewModel.notificationModel
                                          .data![index].alertType! ==
                                      'Red'
                                  ? SvgPicture.asset(
                                      'assets/images/alert_red.svg')
                                  : Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              tileColor: Color(0xFFCBBFE5).withOpacity(0.5),
                              title: Text(dashboardViewModel
                                  .notificationModel.data![index].title!),
                              subtitle: Text(dashboardViewModel
                                  .notificationModel.data![index].message!),
                              trailing: Visibility(
                                visible: dashboardViewModel.notificationModel
                                        .data![index].alertType! ==
                                    'Red',
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFEDCBE2),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Palette.primaryColor,
                                          width: 1.5)),
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20,
                                    color: Palette.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
      ),
    );
  }
}
