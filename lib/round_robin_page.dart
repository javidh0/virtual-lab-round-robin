import 'package:flutter/material.dart';
import 'package:os_virtual_lab/utils/funtions.dart';
import 'package:os_virtual_lab/utils/providers.dart';
import 'package:provider/provider.dart';
import 'utils/text.dart';

class RoundRobinPage extends StatelessWidget {
  const RoundRobinPage({super.key});

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
      body: const RoundRobinBody(),
    );
  }
}

class RoundRobinBody extends StatelessWidget {
  const RoundRobinBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: getWidth(100, context),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Operating System > Round Robin",
              style: text_1.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: getWidth(25, context),
              child: const ProcessAndQuantum(),
            ),
            SizedBox(
              height: getHeight(75, context),
              child: const VerticalDivider(
                endIndent: 15,
                indent: 15,
                width: 1,
              ),
            ),
            const TimeInputWidget(),
          ],
        ),
      ],
    );
  }
}

class TimeInputWidget extends StatelessWidget {
  const TimeInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20, context)),
          child: Container(
            width: getWidth(10, context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(217, 217, 217, 1),
            ),
            child: Column(
              children: buildInputFields(context),
            ),
          ),
        ),
      ),
    );
  }
}

class MyInputFieldWidget extends StatelessWidget {
  const MyInputFieldWidget({
    super.key,
    required this.i,
    required this.j,
  });

  final int i, j;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: context.watch<Process>().getController(i, j),
          style: text_1,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            hintText: '0',
          ),
        ),
      ),
    );
  }
}

class ProcessAndQuantum extends StatelessWidget {
  const ProcessAndQuantum({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputsFieldWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class MySubmitButton extends StatelessWidget {
  const MySubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: getWidth(15, context),
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/execute_page");
          },
          child: Text(
            "Next",
            style: text_1.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class InputsFieldWidget extends StatefulWidget {
  const InputsFieldWidget({
    super.key,
  });

  @override
  State<InputsFieldWidget> createState() => _InputsFieldWidgetState();
}

class _InputsFieldWidgetState extends State<InputsFieldWidget> {
  int noOfProcess = 1, qTime = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Inputs",
                style: text_1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Container(
                  width: getWidth(15, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(217, 217, 217, 1),
                  ),
                  child: DropdownButton(
                    value: context.watch<InputData>().getQuantumn(),
                    borderRadius: BorderRadius.circular(10),
                    items: buildDropDownItems(10),
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        context.read<InputData>().setQuantum(value);
                      });
                    },
                  ),
                ),
              ),
              Text(
                "Quantum Time",
                style: text_1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Container(
                  width: getWidth(15, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(217, 217, 217, 1),
                  ),
                  child: DropdownButton(
                    value: context.watch<InputData>().getProcess(),
                    borderRadius: BorderRadius.circular(10),
                    items: buildDropDownItems(10),
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        context.read<InputData>().setProcess(value);
                      });
                    },
                  ),
                ),
              ),
              Text(
                "No Proceses",
                style: text_1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}

List<DropdownMenuItem<dynamic>> buildDropDownItems(int n) {
  List<DropdownMenuItem<dynamic>> dropDowns = [];
  for (int i = 1; i <= n; i++) {
    var temp = DropdownMenuItem(
      value: i,
      alignment: AlignmentDirectional.center,
      child: Text(
        i.toString(),
        style: text_1,
        textAlign: TextAlign.center,
      ),
    );
    dropDowns.add(temp);
  }
  return dropDowns;
}

List<Widget> buildInputFields(BuildContext context) {
  context.read<Process>().init(context.read<InputData>().getProcess());
  List<Widget> tr = [];
  Widget title = SizedBox(
    width: getWidth(32.5, context),
    child: const Row(
      children: [
        TitleText(text: "ProcessId"),
        TitleText(text: "Arrival Time"),
        TitleText(text: "Burst Time"),
      ],
    ),
  );
  tr.add(title);
  for (int i = 0; i < context.watch<InputData>().getProcess(); i++) {
    Widget temp = SizedBox(
      width: getWidth(32.5, context),
      child: Row(
        children: [
          MyInputFieldWidget(i: i, j: 0),
          MyInputFieldWidget(i: i, j: 1),
          MyInputFieldWidget(i: i, j: 2),
        ],
      ),
    );
    tr.add(temp);
  }
  tr.add(
    const MySubmitButton(),
  );
  return tr;
}

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 150,
        child: Center(
          child: Text(
            text,
            style: text_1,
          ),
        ),
      ),
    );
  }
}
