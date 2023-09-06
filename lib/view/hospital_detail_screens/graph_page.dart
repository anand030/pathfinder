import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/view_model/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../widget_screens/empty_data_screen.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  final Color leftBarColor = Colors.yellowAccent;
  final Color rightBarColor = Colors.redAccent;
  final Color avgColor = Colors.indigoAccent;

  final double width = 10;

  // List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    final dashBoardViewModel =
        Provider.of<DashboardViewModel>(context, listen: false);

    // dashBoardViewModel.hospitalDetailsModel.data.graphData.

    // final barGroup1 = makeGroupData(0, 5, 12);
    // final barGroup2 = makeGroupData(1, 16, 12);
    // final barGroup3 = makeGroupData(2, 18, 5);
    // final barGroup4 = makeGroupData(3, 20, 16);
    // final barGroup5 = makeGroupData(4, 17, 6);
    // final barGroup6 = makeGroupData(5, 19, 1.5);
    // final barGroup7 = makeGroupData(6, 10, 1.5);

    // final items = [
    //   barGroup1,
    //   barGroup2,
    //   barGroup3,
    //   barGroup4,
    //   barGroup5,
    //   barGroup6,
    //   barGroup7,
    // ];
    //
    // rawBarGroups = items;
    //
    // showingBarGroups = rawBarGroups;

    for (int i = 0;
        i <
            dashBoardViewModel.hospitalDetailsModel.data!.graphData!.datasets!
                .first.data!.length;
        i++) {
      showingBarGroups.add(BarChartGroupData(
          barsSpace: 4,
          x: i,
          barRods: addBardChartRodData(i, dashBoardViewModel)
          // [
          //   BarChartRodData(
          //     toY: dashBoardViewModel
          //         .hospitalDetailsModel.data!.graphData!.datasets!.first.data![i]
          //         .toDouble(),
          //     // color: leftBarColor,
          //     width: width,
          //   ),
          //   BarChartRodData(
          //     toY: dashBoardViewModel
          //         .hospitalDetailsModel.data!.graphData!.datasets!.last.data![i]
          //         .toDouble(),
          //     // color: rightBarColor,
          //     width: width,
          //   ),
          // ],
          ));
    }
  }

  List<BarChartRodData> addBardChartRodData(
      int index, DashboardViewModel dashboardViewModel) {
    List<BarChartRodData> barChartRodData = [];
    for (var data
        in dashboardViewModel.hospitalDetailsModel.data!.graphData!.datasets!) {
      barChartRodData.add(
        BarChartRodData(
          toY: data.data![index].toDouble(),
          // color: leftBarColor,
          width: width,
        ),
      );
    }
    return barChartRodData;
  }

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = context.watch<DashboardViewModel>();
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: <Widget>[
            //     // makeTransactionsIcon(),
            //     const SizedBox(
            //       width: 38,
            //     ),
            //     const Text(
            //       'Transactions',
            //       style: TextStyle(color: Colors.black, fontSize: 22),
            //     ),
            //     const SizedBox(
            //       width: 4,
            //     ),
            //     const Text(
            //       'state',
            //       style: TextStyle(color: Color(0xff77839a), fontSize: 16),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 38,
            // ),
            Expanded(
              child: BarChart(
                BarChartData(
                  // maxY: 20,
                  // barTouchData: BarTouchData(
                  //   touchTooltipData: BarTouchTooltipData(
                  //     tooltipBgColor: Colors.grey,
                  //     getTooltipItem: (a, b, c, d) => null,
                  //   ),
                  //   touchCallback: (FlTouchEvent event, response) {
                  //     if (response == null || response.spot == null) {
                  //       setState(() {
                  //         touchedGroupIndex = -1;
                  //         showingBarGroups = List.of(rawBarGroups);
                  //       });
                  //       return;
                  //     }
                  //
                  //     touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                  //
                  //     setState(() {
                  //       if (!event.isInterestedForInteractions) {
                  //         touchedGroupIndex = -1;
                  //         showingBarGroups = List.of(rawBarGroups);
                  //         return;
                  //       }
                  //       showingBarGroups = List.of(rawBarGroups);
                  //       if (touchedGroupIndex != -1) {
                  //         var sum = 0.0;
                  //         for (final rod
                  //         in showingBarGroups[touchedGroupIndex].barRods) {
                  //           sum += rod.toY;
                  //         }
                  //         final avg = sum /
                  //             showingBarGroups[touchedGroupIndex]
                  //                 .barRods
                  //                 .length;
                  //
                  //         showingBarGroups[touchedGroupIndex] =
                  //             showingBarGroups[touchedGroupIndex].copyWith(
                  //               barRods: showingBarGroups[touchedGroupIndex]
                  //                   .barRods
                  //                   .map((rod) {
                  //                 return rod.copyWith(
                  //                     toY: avg, color: avgColor);
                  //               }).toList(),
                  //             );
                  //       }
                  //     });
                  //   },
                  // ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return bottomTitles(value, meta, dashboardViewModel);
                        },
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 10,
                        // getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  // Widget leftTitles(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     color: Color(0xff7589a2),
  //     fontWeight: FontWeight.bold,
  //     fontSize: 14,
  //   );
  //   String text;
  //   if (value == 0) {
  //     text = '1K';
  //   } else if (value == 10) {
  //     text = '5K';
  //   } else if (value == 19) {
  //     text = '10K';
  //   } else {
  //     return Container();
  //   }
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     space: 0,
  //     child: Text(text, style: style),
  //   );
  // }

  Widget bottomTitles(
      double value, TitleMeta meta, DashboardViewModel dashboardViewModel) {
    final titles =
        dashboardViewModel.hospitalDetailsModel.data!.graphData!.labels;

    final Widget text = Text(
      titles![value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

// BarChartGroupData makeGroupData(DashboardViewModel dashboardViewModel) {
//   return BarChartGroupData(
//     barsSpace: 4,
//     x: x,
//     barRods: [
//       BarChartRodData(
//         toY: y1,
//         // color: leftBarColor,
//         width: width,
//       ),
//       BarChartRodData(
//         toY: y2,
//         // color: rightBarColor,
//         width: width,
//       ),
//     ],
//   );
// }

// Widget makeTransactionsIcon() {
//   const width = 4.5;
//   const space = 3.5;
//   return Row(
//     mainAxisSize: MainAxisSize.min,
//     children: <Widget>[
//       Container(
//         width: width,
//         height: 10,
//         color: Colors.white.withOpacity(0.4),
//       ),
//       const SizedBox(
//         width: space,
//       ),
//       Container(
//         width: width,
//         height: 28,
//         color: Colors.white.withOpacity(0.8),
//       ),
//       const SizedBox(
//         width: space,
//       ),
//       Container(
//         width: width,
//         height: 42,
//         color: Colors.white.withOpacity(1),
//       ),
//       const SizedBox(
//         width: space,
//       ),
//       Container(
//         width: width,
//         height: 28,
//         color: Colors.white.withOpacity(0.8),
//       ),
//       const SizedBox(
//         width: space,
//       ),
//       Container(
//         width: width,
//         height: 10,
//         color: Colors.white.withOpacity(0.4),
//       ),
//     ],
//   );
// }
}
