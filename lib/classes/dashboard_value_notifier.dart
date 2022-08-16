import 'package:flutter/material.dart';

class DashboardSection {
  ValueNotifier<int> numberOfEspresso = ValueNotifier<int>(0);
  ValueNotifier<int> numberOfCoffee = ValueNotifier<int>(0);
  ValueNotifier<int> numberOfLatte = ValueNotifier<int>(0);

  DashboardSection(
      {required this.numberOfEspresso,
      required this.numberOfCoffee,
      required this.numberOfLatte});
}

class DashboardValueNotifier extends ValueNotifier<DashboardSection> {
  DashboardValueNotifier({required DashboardSection value}) : super(value);

  void addNumberOfEspresso(int numberOfEspresso) {
    value.numberOfEspresso.value += numberOfEspresso;
    notifyListeners();
  }

  void addNumberOfCoffee(int numberOfCoffee) {
    value.numberOfCoffee.value += numberOfCoffee;
    notifyListeners();
  }

  void addNumberOfLatte(int numberOfLatte) {
    value.numberOfLatte.value += numberOfLatte;
    notifyListeners();
  }
}
