// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputData with ChangeNotifier {
  int noOfProcess = 3;
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

class TableContent with ChangeNotifier {
  List<String> process = [], at = [], bt = [], ct = [], tat = [], wt = [];
  void init(BuildContext context) {
    process.clear();
    at.clear();
    bt.clear();
    ct.clear();
    tat.clear();
    wt.clear();
    int n = context.read<Process>().id.length;
    for (int i = 0; i < n; i++) {
      print(context.read<Process>().getArival(i));
      process.add(context.read<Process>().getId(i));
      at.add(context.read<Process>().getArival(i));
      bt.add(context.read<Process>().getBurst(i));
      ct.add('-');
      tat.add('-');
      wt.add('-');
    }
  }

  void setCompletion(BuildContext context, String pro) {
    for (int i = 0; i < process.length; i++) {
      if (process[i] == pro) {
        ct[i] = context.read<RoundRobin>().timePointer.toString();
        tat[i] = (int.parse(ct[i]) - int.parse(at[i])).toString();
        wt[i] = (int.parse(ct[i]) - int.parse(bt[i])).toString();
        break;
      }
    }
    notifyListeners();
  }

  List<String> getRow(int i) {
    List<String> tr = [
      process[i],
      at[i],
      bt[i],
      ct[i],
      tat[i],
      wt[i],
    ];
    return tr;
  }
}

class Process with ChangeNotifier {
  late List<List<TextEditingController>> controller = [];
  List<String> id = [], arivalTime = [], burstTime = [];
  bool isAllCompleted = false;
  void init(int n, BuildContext context) {
    context.read<RoundRobin>().pointer = 0;
    context.read<RoundRobin>().timePointer = 0;
    controller.clear();
    isAllCompleted = false;
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
      controller.last[2].text = "10";
    }
  }

  TextEditingController getController(int i, int j) {
    return controller[i][j];
  }

  int getN() {
    return controller.length;
  }

  String getValue(int i, int j) {
    return controller[i][j].text;
  }

  void setBurst(int i, double val) {
    controller[i][2].text = val.toString();
    notifyListeners();
  }

  void setCompleted() {
    isAllCompleted = true;
    notifyListeners();
  }

  void removeProcess(int i) {
    controller.removeAt(i);
    id.removeAt(i);
    arivalTime.removeAt(i);
    burstTime.removeAt(i);
  }

  String getArival(int i) {
    return controller[i][1].text;
  }

  String getBurst(int i) {
    return controller[i][2].text;
  }

  String getId(int i) {
    return controller[i][0].text;
  }
}

class RoundRobin extends ChangeNotifier {
  int pointer = 0, timePointer = 0;
  void incrementPointer(BuildContext context, {int i = 1}) {
    pointer += i;
    if (context.read<Process>().getN() == 0) {
      context.read<Process>().setCompleted();
    }
    if (pointer >= context.read<Process>().getN()) {
      pointer = 0;
    }
    notifyListeners();
  }

  String getCurrentProcess(BuildContext context) {
    if (context.read<Process>().isAllCompleted) return "-1";
    return context.read<Process>().id[pointer];
  }

  void inCPUProcess(BuildContext context) {
    int qTime = context.read<InputData>().quantumTime;
    double val =
        double.parse(context.read<Process>().getBurst(pointer)) - qTime;
    if (val <= 0) {
      timePointer += int.parse(context.read<Process>().getBurst(pointer));
      context
          .read<TableContent>()
          .setCompletion(context, getCurrentProcess(context));
      context.read<Process>().removeProcess(pointer);
      pointer -= 1;
    } else {
      timePointer += qTime;
      context.read<Process>().setBurst(pointer, val);
    }
    if (context.read<Process>().getN() == 0) {
      context.read<Process>().setCompleted();
    }
    notifyListeners();
  }

  int getPointer() {
    return pointer;
  }
}
