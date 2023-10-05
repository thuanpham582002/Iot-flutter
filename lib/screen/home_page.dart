import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iot_dashboard/resources/repo/MQTT.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../resources/model/DHT11Data.dart';
import '../resources/model/LiveData.dart';
import '../resources/widgets/AnimatedBox.dart';
import '../resources/widgets/GradientBox.dart';
import 'dart:math' as math;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<LiveData> chartTemperature;
  late List<LiveData> chartHumidity;
  late List<LiveData> chartLight;
  late ChartSeriesController _chartSeriesControllerTemperature;
  late ChartSeriesController _chartSeriesControllerHumidity;
  late ChartSeriesController _chartSeriesControllerLight;

  @override
  void initState() {
    super.initState();
    chartTemperature = getChartTemperature();
    chartHumidity = getChartHumidity();
    chartLight = getChartLight();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Column(
      children: [
        // Top Row with 3 Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 1,
                child: GradientBox(
                  title: 'Temperature',
                  gradientColors: [Colors.red, Colors.yellow],
                  detail: '${chartTemperature.last.speed}°C',
                )),
            const Spacer(flex: 1),
            Expanded(
                flex: 1,
                child: GradientBox(
                  title: 'Humidity',
                  gradientColors: [Colors.blue, Colors.lightBlue],
                  detail: '${chartHumidity.last.speed}%',
                )),
            const Spacer(flex: 1),
            Expanded(
                child: GradientBox(
              title: 'Light',
              gradientColors: [Colors.orange, Colors.yellow],
              detail: '${chartLight.last.speed}Lux',
            )),
          ],
        ),
        // Middle Row with 2 Buttons on the left
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: buildSfCartesianChart(),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Box for "Pan" with Lottie Animation, Toggle, and Detail Text
                      AnimatedBox(
                        title: 'Pan',
                        animationPath: 'assets/lottie/fan.json',
                        // Replace with your Lottie animation file path
                        detail: 'Turn on the pan',
                        onSwitchChanged: (bool value) {
                          MQTT.instance.setFan(value.toString());
                        },
                      ),
                      // Box for "Light Bulb" with Lottie Animation, Toggle, and Detail Text
                      AnimatedBox(
                        title: 'Light Bulb',
                        animationPath: 'assets/lottie/light_bulb.json',
                        // Replace with your Lottie animation file path
                        detail: 'Turn on the light bulb',
                        onSwitchChanged: (bool value) {
                          MQTT.instance.setLed(value.toString());
                        },
                      ),
                    ],
                  )),
              // Empty space to separate buttons
              // Container to fill the remaining space
            ],
          ),
        ),
      ],
    );
  }

  SfCartesianChart buildSfCartesianChart() {
    return SfCartesianChart(
      legend: const Legend(isVisible: true),
      series: <LineSeries<LiveData, int>>[
        LineSeries<LiveData, int>(
          name: 'Temperature',
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesControllerTemperature = controller;
          },
          dataSource: chartTemperature,
          color: const Color(0xFFF44636),
          xValueMapper: (LiveData sales, _) => sales.time,
          yValueMapper: (LiveData sales, _) => sales.speed,
        ),
        LineSeries<LiveData, int>(
          name: 'Humidity',
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesControllerHumidity = controller;
          },
          dataSource: chartHumidity,
          color: const Color(0xFF1E98F3),
          xValueMapper: (LiveData sales, _) => sales.time,
          yValueMapper: (LiveData sales, _) => sales.speed,
        ),
        LineSeries<LiveData, int>(
          name: 'Light',
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesControllerLight = controller;
          },
          dataSource: chartLight,
          color: const Color(0xFFFFE839),
          xValueMapper: (LiveData sales, _) => sales.time,
          yValueMapper: (LiveData sales, _) => sales.speed,
        )
      ],
    );
  }

  int time = 19;

  void updateDataSource(Timer timer) {
    chartTemperature.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartTemperature.removeAt(0);
    _chartSeriesControllerTemperature.updateDataSource(
        addedDataIndex: chartTemperature.length - 1, removedDataIndex: 0);
    chartHumidity.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartHumidity.removeAt(0);
    _chartSeriesControllerHumidity.updateDataSource(
        addedDataIndex: chartHumidity.length - 1, removedDataIndex: 0);

    chartLight.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartLight.removeAt(0);
    _chartSeriesControllerLight.updateDataSource(
        addedDataIndex: chartLight.length - 1, removedDataIndex: 0);
    setState(() {
      // Rebuild UI
    });
  }

  List<LiveData> getChartTemperature() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
      LiveData(3, 49),
      LiveData(4, 54),
      LiveData(5, 41),
      LiveData(6, 58),
      LiveData(7, 51),
      LiveData(8, 98),
      LiveData(9, 41),
      LiveData(10, 53),
      LiveData(11, 72),
      LiveData(12, 86),
      LiveData(13, 52),
      LiveData(14, 94),
      LiveData(15, 92),
      LiveData(16, 86),
      LiveData(17, 72),
      LiveData(18, 94)
    ];
  }

  List<LiveData> getChartHumidity() {
    return <LiveData>[
      LiveData(0, 12),
      LiveData(1, 17),
      LiveData(2, 13),
      LiveData(3, 19),
      LiveData(4, 14),
      LiveData(5, 11),
      LiveData(6, 18),
      LiveData(7, 11),
      LiveData(8, 18),
      LiveData(9, 11),
      LiveData(10, 13),
      LiveData(11, 12),
      LiveData(12, 16),
      LiveData(13, 12),
      LiveData(14, 14),
      LiveData(15, 12),
      LiveData(16, 16),
      LiveData(17, 12),
      LiveData(18, 14)
    ];
  }

  List<LiveData> getChartLight() {
    return <LiveData>[
      LiveData(0, 12),
      LiveData(1, 17),
      LiveData(2, 13),
      LiveData(3, 19),
      LiveData(4, 14),
      LiveData(5, 11),
      LiveData(6, 18),
      LiveData(7, 11),
      LiveData(8, 18),
      LiveData(9, 11),
      LiveData(10, 13),
      LiveData(11, 12),
      LiveData(12, 16),
      LiveData(13, 12),
      LiveData(14, 14),
      LiveData(15, 12),
      LiveData(16, 16),
      LiveData(17, 12),
      LiveData(18, 14)
    ];
  }
}
