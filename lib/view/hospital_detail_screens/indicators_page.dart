import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utilities/consts/color_consts.dart';
import '../../utilities/text_styles.dart';
import '../../view_model/dashboard_view_model.dart';
import '../widget_screens/empty_data_screen.dart';

class IndicatorsPage extends StatelessWidget {
  const IndicatorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = context.watch<DashboardViewModel>();
    return dashboardViewModel.loadingHospital
        ? Center(
            child: CircularProgressIndicator(),
          )
        : dashboardViewModel.hospitalDetailsModel.data!.indicators!.isEmpty
            ? EmptyDataScreen(
                image: 'empty_box.jpg', title: 'Oops, Its empty in here')
            : GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 4),
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemCount: dashboardViewModel
                    .hospitalDetailsModel.data!.indicators!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Palette.primaryColor)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Palette.primaryColor),
                                    top: BorderSide(
                                        color: Palette.primaryColor, width: 2)),
                                color: Color(0xFFEDCBE2).withOpacity(0.7)),
                            child: Center(
                              child: Text(
                                '${dashboardViewModel.hospitalDetailsModel.data!.indicators![index].value} ${dashboardViewModel.hospitalDetailsModel.data!.indicators![index].symbol}',
                                style: CustomTextStyles()
                                    .header(color: Palette.primaryColor),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            // decoration: BoxDecoration(
                            //     color: Color(0xFFEDCBE2).withOpacity(0.7)),
                            child: Center(
                              child: Text(
                                dashboardViewModel.hospitalDetailsModel.data!
                                        .indicators![index].name ??
                                    '...',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
  }
}
