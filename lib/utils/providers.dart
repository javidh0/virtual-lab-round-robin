// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class InputData with ChangeNotifier {
  int noOfProcess = 1;
  int quantumTime = 1;

  int getProcess() {
    return noOfProcess;
  }

  int getQuantumn() {
    return quantumTime;
  }

  void setProcess(int value) {
    noOfProcess = value;
    notifyListeners();
  }

  void setQuantum(int value) {
    quantumTime = value;
    notifyListeners();
  }
}

class Process with ChangeNotifier {
  late List<List<TextEditingController>> controller = [];
  List<String> id = [], arivalTime = [], burstTime = [];
  void init(int n) {
    controller.clear();
    id.clear();
    arivalTime.clear();
    burstTime.clear();
    for (int i = 1; i <= n; i++) {
      id.add("P$i");
      arivalTime.add('0');
      burstTime.add('0');
      List<TextEditingController> temp = [
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ];
      controller.add(temp);
      controller.last[0].text = "P$i";
      controller.last[1].text = "0";
      controller.last[2].text = "0";
    }
  }

  TextEditingController getController(int i, int j) {
    return controller[i][j];
  }

  void getValue(int i, int j) {
    print(controller[i][j].text);
  }
}
