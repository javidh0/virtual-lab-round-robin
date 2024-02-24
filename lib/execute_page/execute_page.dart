import 'package:flutter/material.dart';
import 'package:os_virtual_lab/execute_page/widgets.dart';
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
          MyTable(),
        ],
      ),
    );
  }
}
