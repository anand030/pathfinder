import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pathfinder/utilities/consts/color_consts.dart';
import 'package:pathfinder/utilities/consts/constants.dart';
import 'package:pathfinder/utilities/text_styles.dart';
import 'package:pathfinder/view/hospital_detail_screens/indicators_page.dart';
import 'package:pathfinder/view/hospital_detail_screens/notes_page.dart';
import 'package:provider/provider.dart';

import '../view_model/dashboard_view_model.dart';
import 'hospital_detail_screens/graph_page.dart';

class HospitalDetailPage extends StatelessWidget {
  const HospitalDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = context.watch<DashboardViewModel>();
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leadingWidth: 50,
            title: dashboardViewModel.loadingHospital
                ? Text(
                    '...',
                    style: CustomTextStyles().header(color: Colors.white),
                  )
                : Text(
                    dashboardViewModel.hospitalDetailsModel.data!.name ?? '...',
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
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: dashboardViewModel.hospitalAlertType ==
                            HospitalAlertType.red
                        ? Colors.red
                        : dashboardViewModel.hospitalAlertType ==
                                HospitalAlertType.green
                            ? Colors.green
                            : Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(3),
                    width: 40,
                    height: 40,
                    child: SvgPicture.asset(
                      'assets/images/hospital_icon.svg',
                    ),
                  ),
                ),
              ),
            ],
            bottom: TabBar(
              // indicatorColor: Colors.black,
              // indicatorWeight: 5,
              indicator: BoxDecoration(color: Colors.white),
              labelColor: Palette.primaryColor,
              unselectedLabelColor: Colors.white,
              labelStyle: CustomTextStyles().text(color: Palette.primaryColor),
              tabs: [
                Tab(text: 'Indicators'),
                Tab(text: 'Graph'),
                Tab(text: 'Notes'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              IndicatorsPage(),
              GraphPage(),
              NotesPage(),
            ],
          ),
        ));
  }
}
