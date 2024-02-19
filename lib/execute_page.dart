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
      width: getWidth(99, context),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProcessesDisplay(),
          Table(),
        ],
      ),
    );
  }
}

class ProcessesDisplay extends StatelessWidget {
  const ProcessesDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProcessBox(),
        ProcessBox(),
        ProcessBox(),
        ProcessBox(),
        ProcessBox(),
        ProcessBox(),
      ],
    );
  }
}

class ProcessBox extends StatelessWidget {
  const ProcessBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: const Color.fromRGBO(135, 107, 170, 1),
        height: getHeight(10, context),
        width: getHeight(10, context),
        child: Center(
          child: Text(
            "10",
            style: text_1.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class Table extends StatelessWidget {
  const Table({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(217, 217, 217, 1),
      ),
      padding: const EdgeInsets.all(2),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TableRow(
            data: ["Col-1", "Col-2", "Col-3"],
            isPrimary: true,
          ),
          TableRow(
            data: ["Col-1", "Col-2", "Col-3"],
            isPrimary: false,
          ),
          TableRow(
            data: ["Col-1", "Col-2", "Col-3"],
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
      children: rowBuilder(data),
    );
  }
}

List<Widget> rowBuilder(List<String> data) {
  List<Widget> tr = [];
  for (int i = 0; i < data.length; i++) {
    Widget temp = Padding(
      padding: const EdgeInsets.all(1.5),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Text(data[i], style: text_1),
      ),
    );
    tr.add(temp);
  }
  return tr;
}
