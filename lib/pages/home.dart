import 'dart:async';
import 'package:dashboard_valuenotifier/classes/MoodVerticalBarWidget.dart';
import 'package:dashboard_valuenotifier/classes/dashboard_value_notifier.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DashboardValueNotifier dashboardValueNotifier;
  late Timer timerTotalEspresso;
  late Timer timerTotalCoffee;
  late Timer timerTotalLatte;
  int numberToPlotMax = 125;

  @override
  void initState() {
    super.initState();
    dashboardValueNotifier = DashboardValueNotifier(
      value: DashboardSection(
        numberOfEspresso: ValueNotifier<int>(25),
        numberOfCoffee: ValueNotifier<int>(40),
        numberOfLatte: ValueNotifier<int>(15),
      ),
    );
    timerTotalEspresso = Timer.periodic(const Duration(seconds: 1), (timerTotalEspresso) {
      if (timerTotalEspresso.tick >= 30) {
        timerTotalEspresso.cancel();
        debugPrint('--------- Espresso DONE ---------');
      } else {
        dashboardValueNotifier.addNumberOfEspresso(2);
      }
    });
    timerTotalCoffee = Timer.periodic(const Duration(seconds: 3), (timerTotalCoffee) {
      if (timerTotalCoffee.tick >= 20) {
        timerTotalCoffee.cancel();
        debugPrint('--------- Coffee DONE ---------');
      } else {
        dashboardValueNotifier.addNumberOfCoffee(5);
      }
    });
    timerTotalLatte = Timer.periodic(const Duration(seconds: 2), (timerTotalLatte) {
      if (timerTotalLatte.tick >= 25) {
        timerTotalLatte.cancel();
        debugPrint('--------- Latte DONE ---------');
      } else {
        dashboardValueNotifier.addNumberOfLatte(4);
      }
    });
  }

  @override
  void dispose() {
    dashboardValueNotifier.dispose();
    timerTotalEspresso.cancel();
    timerTotalCoffee.cancel();
    timerTotalLatte.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: Text('Dashboard',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade800,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(1, 1),
                  blurRadius: 3,
                ),
              ]
          ),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(32.0),
            child: Container()
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlue, Colors.lightBlue.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                ValueListenableBuilder(
                  valueListenable: dashboardValueNotifier.value.numberOfEspresso,
                  builder: (BuildContext context, int value, Widget? child) {
                    debugPrint('numberOfEspresso: ${dashboardValueNotifier.value.numberOfEspresso.value}');
                    return MoodVerticalBarWidget(
                      icon: Icons.coffee_maker_outlined,
                      numberToPlot: dashboardValueNotifier.value.numberOfEspresso.value,
                      numberToPlotMax: numberToPlotMax,
                      title: 'Espresso',
                    );
                  },
                ),
                  const Padding(padding: EdgeInsets.only(left: 48.0)),
                  ValueListenableBuilder(
                    valueListenable: dashboardValueNotifier.value.numberOfCoffee,
                    builder: (BuildContext context, int value, Widget? child) {
                      debugPrint('numberOfCoffee: ${dashboardValueNotifier.value.numberOfCoffee.value}');
                      return MoodVerticalBarWidget(
                        icon: Icons.coffee,
                          numberToPlot: dashboardValueNotifier.value.numberOfCoffee.value,
                          numberToPlotMax: numberToPlotMax,
                        title: 'Coffee'
                      );
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(left: 48.0)),
                  ValueListenableBuilder(
                    valueListenable: dashboardValueNotifier.value.numberOfLatte,
                    builder: (BuildContext context, int value, Widget? child) {
                      debugPrint('numberOfLatte: ${dashboardValueNotifier.value.numberOfLatte.value}');
                      return MoodVerticalBarWidget(
                          icon: Icons.local_drink_outlined,
                          numberToPlot: dashboardValueNotifier.value.numberOfLatte.value,
                          numberToPlotMax: numberToPlotMax,
                          title: 'Latte'
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}