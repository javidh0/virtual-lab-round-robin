import 'package:flutter/material.dart';
import 'package:os_virtual_lab/utils/funtions.dart';
import 'package:os_virtual_lab/utils/providers.dart';
import 'package:os_virtual_lab/utils/text.dart';
import 'package:provider/provider.dart';

import 'functions.dart';

class ProcessesDisplay extends StatefulWidget {
  const ProcessesDisplay({super.key});

  @override
  State<ProcessesDisplay> createState() => _ProcessesDisplayState();
}

class _ProcessesDisplayState extends State<ProcessesDisplay>
    with SingleTickerProviderStateMixin {
  double opacity = 0;
  bool isDone = false;
  late AnimationController controler;
  late CurvedAnimation animator;
  @override
  void initState() {
    controler = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );
    animator = CurvedAnimation(parent: controler, curve: Curves.easeIn);
    super.initState();
    animator.addListener(() {
      setState(() {
        isDone = false;
        opacity = animator.value;
        if (opacity == 1) isDone = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: getWidth(13.5, context)),
          child: Text(
            "Time = ${context.watch<RoundRobin>().timePointer.toString()} units",
            style: text_1.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                runItter(
                  context,
                  context.read<RoundRobin>().getPointer(),
                  controler,
                );
                Future.delayed(const Duration(seconds: 2), () {
                  runReverse(
                    context,
                    context.read<RoundRobin>().getPointer(),
                    controler,
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7F4EBD),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text("Next"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: processBoxBuilder(context, 1 - opacity),
            ),
            Column(
              children: [
                MyCPU(
                  opacity: opacity,
                  name: context
                      .read<Process>()
                      .getId(context.read<RoundRobin>().getPointer()),
                  time: context
                      .read<Process>()
                      .getBurst(context.read<RoundRobin>().getPointer()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("CPU", style: text_1),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}

class MyCPU extends StatelessWidget {
  const MyCPU({
    super.key,
    required this.opacity,
    required this.name,
    required this.time,
  });

  final double opacity;
  final String name, time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 167, 165, 169),
        borderRadius: BorderRadius.circular(10),
      ),
      width: getWidth(8, context),
      height: getHeight(20, context),
      child: Padding(
        padding: EdgeInsets.only(top: getHeight(3, context)),
        child: ProcessBox(
          opacity: opacity,
          name: name,
          time: time,
          isActive: true,
        ),
      ),
    );
  }
}

class ProcessBox extends StatelessWidget {
  const ProcessBox({
    super.key,
    this.opacity = 1,
    this.isActive = false,
    required this.name,
    required this.time,
  });

  final double opacity;
  final String time, name;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(135, 107, 170, isActive ? opacity : 1),
              border: Border.all(
                color: Color.fromRGBO(0, 0, 0, isActive ? opacity : 1),
                width: 1,
              ),
            ),
            height: getHeight(10, context),
            width: getHeight(10, context),
            child: Center(
              child: Text(
                time,
                style: text_1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(255, 255, 255, isActive ? opacity : 1),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: text_1.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color.fromRGBO(0, 0, 0, isActive ? opacity : 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyTable extends StatelessWidget {
  const MyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: builderTableRow(context),
      ),
    );
  }
}

class MyTableRow extends StatelessWidget {
  const MyTableRow({
    super.key,
    required this.data,
    this.isPrimary = false,
    this.current = false,
  });

  final List<String> data;
  final bool isPrimary;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: rowBuilder(data, context, isPrimary, current: current),
    );
  }
}
