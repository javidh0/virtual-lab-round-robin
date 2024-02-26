import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:os_virtual_lab/execute_page/widgets.dart';
import 'package:os_virtual_lab/utils/funtions.dart';
import 'package:os_virtual_lab/utils/providers.dart';
import 'package:os_virtual_lab/utils/text.dart';
import 'package:provider/provider.dart';

class ExecutePage extends StatelessWidget {
  const ExecutePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TableContent>().init(context);
    return const Scaffold(
      body: ExecutePageBody(),
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
            child: AutoSizeText(
              "Operating System > Round Robin",
              minFontSize: 5,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (!context.watch<Process>().isAllCompleted)
            const ProcessesDisplay(),
          const MyTable(),
        ],
      ),
    );
  }
}
