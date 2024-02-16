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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: getWidth(25, context),
          child: const ProcessAndQuantum(),
        ),
      ],
    );
  }
}

class ProcessAndQuantum extends StatelessWidget {
  const ProcessAndQuantum({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Operating System > Round Robin",
                  style: text_1.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              const InputsFieldWidget(),
              const MySubmitButton(),
            ],
          ),
        ),
        Container(
          height: getHeight(30, context),
          width: getWidth(99.99, context),
          color: const Color.fromRGBO(51, 26, 83, 1),
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
        width: 250,
        height: 40,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            "Submit",
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
                  width: 250,
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
                "Quantum Time",
                style: text_1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Container(
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(217, 217, 217, 1),
                  ),
                  child: DropdownButton(
                    value: context.watch<InputData>().quantumTime,
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
