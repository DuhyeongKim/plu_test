import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget buildCategoryAxis(BuildContext context){
  return Container(
    child: SfCartesianChart(
      primaryXAxis: NumericAxis(),
      primaryYAxis: NumericAxis(minimum: 0, maximum: 50),
      series: <ChartSeries<SalesData, String>>[
        ColumnSeries<SalesData, String>(
            dataSource: [
              // Bind data source
              SalesData('Jan', 35),
              SalesData('Feb', 28),
              SalesData('Mar', 34),
              SalesData('Apr', 32),
              SalesData('May', 40)
              ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales
        )
      ],
    ),
  );
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

final List<ChartData> chartData = [
  ChartData('John', 10),
  ChartData('David', 9),
  ChartData('Brit', 10),
];

final List<ChartData> chartData2 = [
  ChartData('Anto', 11),
  ChartData('Peter', 12),
  ChartData('Parker', 8),
];


class SalesData{
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

Widget _buildTextLabels(BuildContext context,progressValue,_isHorizontalOrientation) {
  final Brightness _brightness = Theme.of(context).brightness;
  double _deliveryStatus = progressValue;
  const double _orderState = 0;
  const double _packedState = 30;
  const double _shippedState = 60;
  const double _deliveredState = 90;
  Color _activeColor =
  _deliveryStatus > _orderState ? Color(0xff0DC9AB) : Color(0xffD1D9DD);
  final Color _inactiveColor = _brightness == Brightness.dark
      ? const Color(0xff62686A)
      : const Color(0xFFD1D9DD);

  return SizedBox(
      height: _isHorizontalOrientation ? 100 : 300,
      child: SfLinearGauge(
        orientation: _isHorizontalOrientation
            ? LinearGaugeOrientation.horizontal
            : LinearGaugeOrientation.vertical,
        minimum: 0,
        maximum: 90,
        labelOffset: 24,
        isAxisInversed: !_isHorizontalOrientation,
        showTicks: false,
        onGenerateLabels: () {
          return <LinearAxisLabel>[
            const LinearAxisLabel(text: '???????????????', value: _orderState),
            const LinearAxisLabel(text: '?????????', value: _packedState),
            const LinearAxisLabel(text: '?????????', value: _shippedState),
            const LinearAxisLabel(text: '??????', value: _deliveredState),
          ];
        },
        axisTrackStyle: LinearAxisTrackStyle(
          color: _inactiveColor,
        ),
        barPointers: <LinearBarPointer>[
          LinearBarPointer(
            value: _deliveryStatus,
            color: _activeColor,
            enableAnimation: false,
            position: LinearElementPosition.cross,
          ),
        ],
        markerPointers: <LinearMarkerPointer>[
          LinearWidgetPointer(
            value: _orderState,
            enableAnimation: false,
            position: LinearElementPosition.cross,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  border: Border.all(width: 4, color: _activeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Center(
                child:
                Icon(Icons.check_rounded, size: 14, color: _activeColor),
              ),
            ),
          ),
          LinearWidgetPointer(
            enableAnimation: false,
            value: _packedState,
            position: LinearElementPosition.cross,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  border: Border.all(width: 4, color: _activeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Center(
                child:
                Icon(Icons.check_rounded, size: 14, color: _activeColor),
              ),
            ),
          ),
          LinearWidgetPointer(
            value: _shippedState,
            enableAnimation: false,
            position: LinearElementPosition.cross,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(width: 4, color: _activeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Center(
                child:
                Icon(Icons.check_rounded, size: 14, color: _activeColor),
              ),
            ),
          ),
          LinearShapePointer(
            value: _deliveredState,
            enableAnimation: false,
            color: _inactiveColor,
            width: 24,
            height: 24,
            position: LinearElementPosition.cross,
            shapeType: LinearShapePointerType.circle,
          ),
        ],
      ));
}

Widget _getGauge({bool isRadialGauge = false, progressValue}) {
  if (isRadialGauge) {
    return _getRadialGauge();
  } else {
    return _getLinearGauge(progressValue);
  }
}

Widget _getRadialGauge() {
  return SfRadialGauge(
      title: GaugeTitle(
          text: 'Speedometer',
          textStyle:
          const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      axes: <RadialAxis>[
        RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
          GaugeRange(
              startValue: 0,
              endValue: 50,
              color: Colors.green,
              startWidth: 10,
              endWidth: 10),
          GaugeRange(
              startValue: 50,
              endValue: 100,
              color: Colors.orange,
              startWidth: 10,
              endWidth: 10),
          GaugeRange(
              startValue: 100,
              endValue: 150,
              color: Colors.red,
              startWidth: 10,
              endWidth: 10)
        ], pointers: <GaugePointer>[
          NeedlePointer(value: 90)
        ], annotations: <GaugeAnnotation>[
          GaugeAnnotation(
              widget: Container(
                  child: const Text('90.0',
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold))),
              angle: 90,
              positionFactor: 0.5)
        ])
      ]);
}

Widget _getLinearGauge(progressValue) {
  return Container(
    child: SfLinearGauge(
        minimum: 0.0,
        maximum: 100.0,
        animateAxis: true,
        barPointers: <LinearBarPointer>[
          LinearBarPointer(
            value: progressValue,
            position: LinearElementPosition.inside,
            color: Colors.deepPurple,
          )
        ],
        orientation: LinearGaugeOrientation.horizontal,
        majorTickStyle: LinearTickStyle(length: 10),
        axisLabelStyle: TextStyle(fontSize: 10.0, color: Colors.black),
        axisTrackStyle: LinearAxisTrackStyle(
            color: Colors.black,
            edgeStyle: LinearEdgeStyle.bothFlat,
            thickness: 15.0,
            borderColor: Colors.grey)),
    margin: EdgeInsets.all(20),
  );
}

Widget getProgressBarWithCircle(_size,progressValue) {
  return SizedBox(
      height: _size,
      width: _size,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.8,
            axisLineStyle: const AxisLineStyle(
              thickness: 0.1,
              color: Color.fromARGB(30, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
              //cornerStyle: CornerStyle.startCurve,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                  value: progressValue,
                  width: 0.1,
                  sizeUnit: GaugeSizeUnit.factor,
                  enableAnimation: true,
                  animationDuration: 30,
                  animationType: AnimationType.linear,
                  //cornerStyle: CornerStyle.startCurve,
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF00a9b5), Color(0xFFa4edeb)],
                      stops: <double>[0.25, 0.75])),
              MarkerPointer(
                value: progressValue,
                markerType: MarkerType.circle,
                markerHeight: 20,
                markerWidth: 20,
                enableAnimation: true,
                animationDuration: 30,
                animationType: AnimationType.linear,
                color: const Color(0xFF87e8e8),
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  positionFactor: 0.1,
                  widget: Text(progressValue.toStringAsFixed(0) + '%', style: TextStyle(color: Colors.white, fontSize: 20),))
            ]),
      ]));
}

/// Returns gradient progress style circular progress bar.
Widget getProgressBarWithRectangle(_size,progressValue) {
  return SizedBox(
      height: _size,
      width: _size,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.8,
            axisLineStyle: const AxisLineStyle(
              thickness: 0.1,
              color: Color.fromARGB(30, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
             // cornerStyle: CornerStyle.startCurve,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                  value: progressValue,
                  width: 0.1,
                  sizeUnit: GaugeSizeUnit.factor,
                  enableAnimation: true,
                  animationDuration: 30,
                  animationType: AnimationType.linear,
                  //cornerStyle: CornerStyle.startCurve,
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF00a9b5), Color(0xFFa4edeb)],
                      stops: <double>[0.25, 0.75])),
              MarkerPointer(
                value: progressValue,
                markerType: MarkerType.rectangle,
                markerHeight: 18,
                markerWidth: 18,
                enableAnimation: true,
                animationDuration: 30,
                animationType: AnimationType.linear,
                color: const Color(0xFF87e8e8),
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  positionFactor: 0.1,
                  widget: Text(progressValue.toStringAsFixed(0) + '%'))
            ]),
      ]));
}

/// Returns gradient progress style circular progress bar.
Widget getProgressBarWithImage(_size,progressValue) {
  return SizedBox(
      height: _size,
      width: _size,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.8,
            axisLineStyle: const AxisLineStyle(
              thickness: 0.1,
              color: Color.fromARGB(30, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
              //cornerStyle: CornerStyle.startCurve,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                  value: progressValue,
                  width: 0.1,
                  sizeUnit: GaugeSizeUnit.factor,
                  enableAnimation: true,
                  animationDuration: 30,
                  animationType: AnimationType.linear,
                  //cornerStyle: CornerStyle.startCurve,
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF00a9b5), Color(0xFFa4edeb)],
                      stops: <double>[0.25, 0.75])),
              MarkerPointer(
                value: progressValue,
                markerType: MarkerType.image,
                imageUrl: 'assets/images/daesung1.png',
                overlayRadius: 5,
                markerHeight: 30,
                markerWidth: 30,
                enableAnimation: true,
                animationDuration: 30,
                animationType: AnimationType.linear,
                color: const Color(0xFF87e8e8),
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  positionFactor: 0.1,
                  widget: Text(progressValue.toStringAsFixed(0) + '%'))
            ]),
      ]));
}