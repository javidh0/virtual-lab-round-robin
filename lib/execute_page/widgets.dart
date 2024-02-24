import 'package:flutter/material.dart';
import 'package:os_virtual_lab/utils/funtions.dart';
import 'package:os_virtual_lab/utils/text.dart';

import 'functions.dart';

class ProcessesDisplay extends StatefulWidget {
  const ProcessesDisplay({super.key});

  @override
  State<ProcessesDisplay> createState() => _ProcessesDisplayState();
}

class _ProcessesDisplayState extends State<ProcessesDisplay>
    with SingleTickerProviderStateMixin {
  double opacity = 0;
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
        opacity = animator.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            controler.forward();
            Future.delayed(const Duration(seconds: 2), () {
              controler.reverse();
            });
          },
          child: const Text("Next"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                ProcessBox(
                  opacity: 1 - opacity,
                  name: "X",
                  time: "10",
                ),
              ] +
              processBoxBuilder(context),
        ),
        Column(
          children: [
            Container(
              width: getWidth(8, context),
              height: getHeight(20, context),
              color: Colors.amber,
              child: Padding(
                padding: EdgeInsets.only(top: getHeight(3, context)),
                child: ProcessBox(
                  opacity: opacity,
                  name: "X",
                  time: "10",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text("CPU", style: text_1),
            )
          ],
        )
      ],
    );
  }
}

class ProcessBox extends StatelessWidget {
  const ProcessBox(
      {super.key, this.opacity = 1, required this.name, required this.time});

  final double opacity;
  final String time, name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(135, 107, 170, opacity),
              border: Border.all(
                color: Color.fromRGBO(0, 0, 0, opacity),
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
                  color: Color.fromRGBO(255, 255, 255, opacity),
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
                color: Color.fromRGBO(0, 0, 0, opacity),
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
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TableRow(
            data: ["Process", "AT", "BT", "CT", "TAT", "WT"],
            isPrimary: true,
          ),
          TableRow(
            data: ["P1", "20", "10", '12', '1', '12'],
            isPrimary: false,
          ),
          TableRow(
            data: ["P1", "20", "10", '12', '1', '12'],
            isPrimary: false,
          ),
          TableRow(
            data: ["P1", "20", "10", '12', '1', '12'],
            isPrimary: false,
          ),
          TableRow(
            data: ["P1", "20", "10", '12', '1', '12'],
            isPrimary: false,
          )
        ],
      ),
    );
  }
}

class TableRow extends StatelessWidget {
  const TableRow({
    super.key,
    required this.data,
    this.isPrimary = false,
  });

  final List<String> data;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: rowBuilder(data, context, isPrimary),
    );
  }
}
