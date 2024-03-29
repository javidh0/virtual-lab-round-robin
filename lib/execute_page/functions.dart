import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:os_virtual_lab/execute_page/widgets.dart';
import 'package:os_virtual_lab/utils/funtions.dart';
import 'package:os_virtual_lab/utils/providers.dart';
import 'package:os_virtual_lab/utils/text.dart';
import 'package:provider/provider.dart';

void runItter(BuildContext context, int ptr, AnimationController controler) {
  controler.forward();

  Future.delayed(const Duration(seconds: 1), () {
    controler.reverse();
  });

  Future.delayed(const Duration(seconds: 2), () {
    try {
      context.read<RoundRobin>().inCPUProcess(context);
      context.read<RoundRobin>().incrementPointer(context);
      // ignore: empty_catches
    } catch (e) {}
  });
}

List<Widget> rowBuilder(List<String> data, BuildContext context, bool prim,
    {bool current = false}) {
  List<Widget> tr = [];
  for (int i = 0; i < data.length; i++) {
    Widget temp = Padding(
      padding: const EdgeInsets.all(1.5),
      child: Container(
        width: getWidth(10, context),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: current && i == 0
              ? const Color.fromARGB(255, 21, 213, 17)
              : Colors.white,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
        child: AutoSizeText(
          data[i],
          minFontSize: 5,
          style: text_1.copyWith(
            fontWeight: prim ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
    tr.add(temp);
  }
  return tr;
}

List<Widget> processBoxBuilder(BuildContext context, double opacity) {
  List<Widget> tr = [];
  int ptr = context.watch<RoundRobin>().getPointer();
  for (int i = 0; i < context.read<Process>().controller.length; i++) {
    Widget temp = ProcessBox(
      name: context.watch<Process>().id[i],
      time: context.watch<Process>().getBurst(i),
      isActive: ptr == i,
      opacity: opacity,
    );
    tr.add(temp);
  }
  return tr;
}

List<Widget> builderTableRow(BuildContext context) {
  List<Widget> tr = [];
  MyTableRow head = const MyTableRow(
    data: ["Process", "AT", "BT", "CT", "TAT", "WT"],
    isPrimary: true,
  );
  tr.add(head);
  for (int i = 0; i < context.read<TableContent>().process.length; i++) {
    MyTableRow temp = MyTableRow(
      data: context.watch<TableContent>().getRow(i),
      current: context.watch<RoundRobin>().getCurrentProcess(context) ==
          context.watch<TableContent>().process[i],
    );
    tr.add(temp);
  }
  return tr;
}
