// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  int getN() {
    return controller.length;
  }

  void getValue(int i, int j) {
    print(controller[i][j].text);
  }

  void setBurst(int i, double val) {
    controller[i][2].text = val.toString();
    notifyListeners();
  }

  String getBurst(int i) {
    print(controller[i][2].text);
    return controller[i][2].text;
  }

  String getId(int i) {
    return controller[i][0].text;
  }
}

class RoundRobin extends ChangeNotifier {
  int pointer = 0;
  void incrementPointer(BuildContext context, {int i = 1}) {
    pointer += i;
    if (pointer >= context.read<Process>().getN()) pointer = 0;
    notifyListeners();
  }

  void inCPUProcess(BuildContext context) {
    int qTime = context.read<InputData>().quantumTime;
    double val =
        double.parse(context.read<Process>().getBurst(pointer)) - qTime;
    if (val < 0) val = 0;
    context.read<Process>().setBurst(pointer, val);
    notifyListeners();
  }

  int getPointer() {
    return pointer;
  }
}
