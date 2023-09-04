import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:meta/meta.dart';

part 'calculate_state.dart';

class CalculateCubit extends Cubit<CalculateCubitState> {
  CalculateCubit() : super(CalculateCubitInitial());

  void clearAll() {
    emit(CalculateCubitInitial());
  }

  void calculate(String text) {
    if (text.isEmpty) {
      emit(CalculateCubitInitial());
      return;
    }
    try {
      var input = text.replaceAll("x", "*");
      input = input.replaceAll(",", ".");
      input = input.replaceAll("÷", "/");
      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel ctx = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, ctx);
      RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
      String result = eval.toString().replaceAll(regex, '');
      result = result.replaceAll(".", ",");

      emit(CalculateCubitResult(result: result));
    } catch (e) {
      log(e.toString());
      emit(CalculateCubitResult(result: "Error"));
    }
  }
}
