import 'package:flutter/material.dart';
import 'package:os_virtual_lab/utils/funtions.dart';
import 'package:os_virtual_lab/utils/text.dart';

class ExecutePage extends StatelessWidget {
  const ExecutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          color: Colors.amber,
          width: 100,
          height: 100,
          child: Center(
            child: Text(
              "LOGO",
              style: text_1,
            ),
          ),
        ),
        title: Row(
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Home", style: text_1),
                  Text("Simulation", style: text_1),
                  Text("About Us", style: text_1),
                  Text("Contact", style: text_1),
                ],
              ),
            ),
          ],
        ),
      ),
      body: const ExecutePageBody(),
    );
  }
}

class ExecutePageBody extends StatelessWidget {
  const ExecutePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Operating System > Round Robin",
              style: text_1.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        const RoundRobinExecuteWidget(),
      ],
    );
  }
}

class RoundRobinExecuteWidget extends StatelessWidget {
  const RoundRobinExecuteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(100, context),
      height: getHeight(80, context),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ProcessesDisplay(),
          Table(),
        ],
      ),
    );
  }
}

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
    animator = CurvedAnimation(parent: controler, curve: Curves.bounceInOut);
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
            },
            child: const Text("Next")),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProcessBox(opacity: 1 - opacity),
            ProcessBox(),
            ProcessBox(),
            ProcessBox(),
            ProcessBox(),
            ProcessBox(),
          ],
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
  const ProcessBox({
    super.key,
    this.opacity = 1,
  });

  final double opacity;

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
                "10",
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
              "P1",
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

class Table extends StatelessWidget {
  const Table({super.key});

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

List<Widget> rowBuilder(List<String> data, BuildContext context, bool prim) {
  List<Widget> tr = [];
  for (int i = 0; i < data.length; i++) {
    Widget temp = Padding(
      padding: const EdgeInsets.all(1.5),
      child: Container(
        width: getWidth(10, context),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
        child: Text(
          data[i],
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
