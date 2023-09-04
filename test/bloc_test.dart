// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:calculator_apps/cubit/calculate_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('calculate', () {
    late CalculateCubit calculateCubit;
    setUp(() {
      EquatableConfig.stringify = true;
      calculateCubit = CalculateCubit();
    });
    blocTest(
      'emit result with empty input',
      build: () => calculateCubit,
      act: (cubit) => cubit.calculate(""),
      expect: () => [CalculateCubitInitial()],
    );

    blocTest(
      'emit result with input positif case',
      build: () => calculateCubit,
      act: (cubit) => cubit.calculate("9,4+0,6"),
      expect: () => [CalculateCubitResult(result: "10")],
    );

    blocTest(
      'emit result with input negatif case',
      build: () => calculateCubit,
      act: (cubit) => cubit.calculate("90/0"),
      expect: () => [CalculateCubitResult(result: "Infinity")],
    );

    blocTest(
      'emit result with input negatif case',
      build: () => calculateCubit,
      act: (cubit) => cubit.calculate("(1231)X(11)+-1"),
      expect: () => [CalculateCubitResult(result: "Error")],
    );

    blocTest(
      'clear all',
      build: () => calculateCubit,
      act: (cubit) => cubit.clearAll(),
      expect: () => [CalculateCubitInitial()],
    );
    tearDown(() => calculateCubit.close());
  });
}
