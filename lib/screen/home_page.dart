import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_dashboard/resources/model/ActionData.dart';
import 'package:iot_dashboard/resources/repo/DataRepo.dart';
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
  ActionData actionData =
      ActionData(id: 0, device: "fan", status: false, time: DateTime.now());

  RxBool isBlink = false.obs;
  List<LiveData> chartTemperature = [];
  List<LiveData> chartHumidity = [];
  List<LiveData> chartLight = [];
  List<LiveData> chartDust = [];
  late ChartSeriesController _chartSeriesControllerTemperature;
  late ChartSeriesController _chartSeriesControllerHumidity;
  late ChartSeriesController _chartSeriesControllerLight;
  late ChartSeriesController _chartSeriesControllerDust;

  @override
  void initState() {
    super.initState();
    updateDataSource();
    // randomContinuous();
  }

  void randomContinuous() {
    final random = Random();

    void generateRandomNumber() {
      double randomNumber = random.nextDouble();
      print('Random number: $randomNumber');
    }

    Duration duration = Duration(seconds: 2);
    Timer.periodic(duration, (Timer timer) {
      DHT11Data data = DHT11Data(
          temperature: (math.Random().nextInt(60) + 30),
          humidity: (math.Random().nextInt(60) + 30),
          lux: (math.Random().nextInt(60) + 30),
          dust: (math.Random().nextInt(60) + 30),
          time: DateTime.now(),
          id: 0);
      MQTT.instance.setDHT11Data(data);
    });
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
                  color: Colors.red,
                  value: chartTemperature.isNotEmpty
                      ? chartTemperature.last.speed
                      : 0,
                  suffix: '°C',
                  condition: 40,
                )),
            SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: GradientBox(
                  title: 'Humidity',
                  color: Colors.blue,
                  value:
                      chartHumidity.isNotEmpty ? chartHumidity.last.speed : 0,
                  suffix: '%',
                  condition: 70,
                )),
            SizedBox(width: 10),
            Expanded(
                child: GradientBox(
              title: 'Light',
              color: Colors.orange,
              value: chartLight.isNotEmpty ? chartLight.last.speed : 0,
              suffix: 'lux',
              condition: 1000,
            )),
            SizedBox(width: 10),
            Expanded(
                child: GradientBox(
              title: 'Dust level',
              color: Colors.orange,
              value: chartDust.isNotEmpty ? chartDust.last.speed : 0,
              suffix: 'µg/m³',
              condition: 50,
            )),
            SizedBox(width: 10),
          ],
        ),
        // Middle Row with 2 Buttons on the left
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: buildSfCartesianChart(),
              ),
              Expanded(
                flex: 3,
                child: buildSfCartesianChartDust(),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Box for "Pan" with Lottie Animation, Toggle, and Detail Text
                      SizedBox(height: 10),
                      AnimatedBox(
                        title: 'Pan',
                        animationPath: 'assets/lottie/fan.json',
                        detail: 'Turn on the pan',
                        onSwitchChanged: (bool value) {
                          setState(() {
                            actionData = actionData.copyWith(
                                device: "fan",
                                status: value,
                                time: DateTime.now());
                          });
                          DataRepo.instance.setAction(actionData);
                          MQTT.instance.setFan(value.toString());
                        },
                        isBlink: isBlink,
                      ),
                      SizedBox(height: 10),
                      // Box for "Light Bulb" with Lottie Animation, Toggle, and Detail Text
                      AnimatedBox(
                        title: 'Light Bulb',
                        animationPath: 'assets/lottie/light_bulb.json',
                        detail: 'Turn on the light bulb',
                        onSwitchChanged: (bool value) {
                          setState(() {
                            actionData = actionData.copyWith(
                                device: "led",
                                status: value,
                                time: DateTime.now());
                          });
                          DataRepo.instance.setAction(actionData);
                          MQTT.instance.setLed(value.toString());
                        },
                        isBlink: isBlink,
                      ),
                      SizedBox(height: 10),
                      AnimatedBox(
                        title: 'Air Conditioner',
                        animationPath: 'assets/lottie/air_conditioner.json',
                        detail: 'Turn on the air conditioner',
                        onSwitchChanged: (bool value) {
                          setState(() {
                            actionData = actionData.copyWith(
                                device: "dust",
                                status: value,
                                time: DateTime.now());
                          });
                          DataRepo.instance.setAction(actionData);
                          MQTT.instance.setDust(value.toString());
                        },
                        isBlink: isBlink,
                      ),
                      SizedBox(height: 10),
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
      primaryXAxis: DateTimeAxis(),
      legend: const Legend(isVisible: true),
      series: <LineSeries<LiveData, DateTime>>[
        LineSeries<LiveData, DateTime>(
          name: 'Temperature',
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesControllerTemperature = controller;
          },
          dataSource: chartTemperature,
          color: const Color(0xFFF44636),
          xValueMapper: (LiveData sales, _) => sales.time,
          yValueMapper: (LiveData sales, _) => sales.speed,
        ),
        LineSeries<LiveData, DateTime>(
          name: 'Humidity',
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesControllerHumidity = controller;
          },
          dataSource: chartHumidity,
          color: const Color(0xFF1E98F3),
          xValueMapper: (LiveData sales, _) => sales.time,
          yValueMapper: (LiveData sales, _) => sales.speed,
        ),
        LineSeries<LiveData, DateTime>(
          name: 'Light',
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesControllerLight = controller;
          },
          dataSource: chartLight,
          color: const Color(0xFFFFE839),
          xValueMapper: (LiveData sales, _) => sales.time,
          yValueMapper: (LiveData sales, _) => sales.speed / 10,
        ),
      ],
    );
  }

  SfCartesianChart buildSfCartesianChartDust() {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      legend: const Legend(isVisible: true),
      series: <LineSeries<LiveData, DateTime>>[
        LineSeries<LiveData, DateTime>(
          name: 'Dust',
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesControllerDust = controller;
          },
          dataSource: chartDust,
          color: const Color(0xFFE91E63),
          xValueMapper: (LiveData sales, _) => sales.time,
          yValueMapper: (LiveData sales, _) => sales.speed,
        ),
      ],
    );
  }

  void updateDataSource() {
    DataRepo.instance.listDHT11Data.addListener(() {
      // log('updateDataSource ${DataRepo.instance.listDHT11Data.read().length}');
      // pick last 30 data
      chartTemperature = DataRepo.instance.listDHT11Data
          .read()
          .getRange(
              DataRepo.instance.listDHT11Data.read().length - 30 > 0
                  ? DataRepo.instance.listDHT11Data.read().length - 30
                  : 0,
              DataRepo.instance.listDHT11Data.read().length)
          .map((e) => LiveData(e.time, e.temperature))
          .toList();

      chartHumidity = DataRepo.instance.listDHT11Data
          .read()
          .getRange(
              DataRepo.instance.listDHT11Data.read().length - 30 > 0
                  ? DataRepo.instance.listDHT11Data.read().length - 30
                  : 0,
              DataRepo.instance.listDHT11Data.read().length)
          .map((e) => LiveData(e.time, e.humidity))
          .toList();

      chartLight = DataRepo.instance.listDHT11Data
          .read()
          .getRange(
              DataRepo.instance.listDHT11Data.read().length - 30 > 0
                  ? DataRepo.instance.listDHT11Data.read().length - 30
                  : 0,
              DataRepo.instance.listDHT11Data.read().length)
          .map((e) => LiveData(e.time, e.lux))
          .toList();

      chartDust = DataRepo.instance.listDHT11Data
          .read()
          .getRange(
              DataRepo.instance.listDHT11Data.read().length - 5 > 0
                  ? DataRepo.instance.listDHT11Data.read().length - 5
                  : 0,
              DataRepo.instance.listDHT11Data.read().length)
          .map((e) => LiveData(e.time, e.dust))
          .toList();

      if (chartTemperature.length > 30) {
        _chartSeriesControllerTemperature.updateDataSource(
            addedDataIndex: chartTemperature.length - 1, removedDataIndex: 0);
      }

      if (chartHumidity.length > 30) {
        _chartSeriesControllerHumidity.updateDataSource(
            addedDataIndex: chartHumidity.length - 1, removedDataIndex: 0);
      }

      if (chartLight.length > 30) {
        _chartSeriesControllerLight.updateDataSource(
            addedDataIndex: chartLight.length - 1, removedDataIndex: 0);
      }

      if (chartDust.length > 5) {
        _chartSeriesControllerDust.updateDataSource(
            addedDataIndex: chartDust.length - 1, removedDataIndex: 0);
      }

      setState(() {
        isBlink.value = chartDust.isNotEmpty
            ? chartDust.last.speed > 50
                ? true
                : false
            : false;
        print("BLInk $isBlink");
        // Rebuild UI
      });
    });
  }
}
