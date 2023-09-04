import 'package:calculator_apps/cubit/calculate_cubit.dart';
import 'package:calculator_apps/widget/button_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final text = [
    "C",
    "DEL",
    "(",
    ")",
    "7",
    "8",
    "9",
    "÷",
    "4",
    "5",
    "6",
    "x",
    "1",
    "2",
    "3",
    "-",
    ",",
    "0",
    "=",
    "+",
  ];

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculateCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calculator App',
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(255, 234, 234, 234),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: controller,
                    enabled: false,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black38),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const SizedBox(height: 4),
                  BlocBuilder<CalculateCubit, CalculateCubitState>(
                      builder: (context, state) {
                    return Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Text(
                        (state is CalculateCubitResult) ? state.result : "",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    );
                  })
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: BlocBuilder<CalculateCubit, CalculateCubitState>(
                  builder: (context, state) {
                    return GridView.builder(
                        key: const Key("GridViewKey"),
                        shrinkWrap: true,
                        itemCount: text.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12),
                        itemBuilder: (context, index) {
                          Color color = Theme.of(context).primaryColorLight;
                          if (index == 0) {
                            color = const Color.fromARGB(255, 250, 123, 123);
                          } else if (index == 1) {
                            color = const Color.fromARGB(255, 250, 231, 123);
                          } else if (index < 4 || (index + 1) % 4 == 0) {
                            color = const Color.fromARGB(236, 255, 154, 65);
                          } else if (index == 18) {
                            color = Colors.greenAccent;
                          }
                          return ButtonCalculator(
                            color: color,
                            text: text[index],
                            keyValue: "cal${text[index]}",
                            onTap: () {
                              if (index == 0) {
                                controller.clear();
                                context.read<CalculateCubit>().clearAll();
                              } else if (index == 1) {
                                if (controller.text.isNotEmpty) {
                                  controller.text = controller.text
                                      .substring(0, controller.text.length - 1);
                                }
                              } else if (index == 18) {
                                context
                                    .read<CalculateCubit>()
                                    .calculate(controller.text);
                              } else {
                                //validate don't double symbol
                                if (isInputDoubleSymbol(text[index])) {
                                  //if double symbol replace last input to new inputed symbol
                                  controller.text = controller.text
                                      .substring(0, controller.text.length - 1);
                                }
                                controller.text += text[index];
                              }
                            },
                          );
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isInputDoubleSymbol(String text) {
    var currentInput = controller.text;
    if (currentInput.isEmpty) {
      return false;
    }
    if (text == "(" || text == ")") {
      return false;
    }
    //get current input to number
    int? number = int.tryParse(text);
    if (number != null) {
      //if current input is number return false
      return false;
    } else {
      //get last input
      var lastInput = controller.text.substring(controller.text.length - 1);
      int? number2 = int.tryParse(lastInput);
      if (number2 != null) {
        //if last input is number return false
        return false;
      } else {
        return true;
      }
    }
  }
}
