import 'package:flutter/material.dart';

import '../widget_screens/empty_data_screen.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EmptyDataScreen(
          image: 'empty_box.jpg', title: 'Oops, Its empty in here'),
    );
    // final List<ChartData> chartData = [
    //   ChartData(1, 35),
    //   ChartData(2, 23),
    //   ChartData(3, 34),
    //   ChartData(4, 25),
    //   ChartData(5, 40)
    // ];
    // return Padding(
    //     padding: EdgeInsets.all(12),
    //     child: SfCartesianChart(series: <ChartSeries<ChartData, int>>[
    //       // Renders column chart
    //       ColumnSeries<ChartData, int>(
    //           dataSource: chartData,
    //           xValueMapper: (ChartData data, _) => data.x,
    //           yValueMapper: (ChartData data, _) => data.y)
    //     ]));
  }
}

// class ChartData {
//   ChartData(
//     this.x,
//     this.y,
//   );
//
//   final int x;
//   final double y;
// }
