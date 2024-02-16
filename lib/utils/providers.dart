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
  }

  void setQuantum(int value) {
    quantumTime = value;
  }
}
