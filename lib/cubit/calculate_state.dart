part of 'calculate_cubit.dart';

@immutable
sealed class CalculateCubitState extends Equatable {}

final class CalculateCubitInitial extends CalculateCubitState {
  CalculateCubitInitial();

  @override
  List<Object?> get props => [];
}

final class CalculateCubitResult extends CalculateCubitState {
  final String result;
  CalculateCubitResult({required this.result});

  @override
  List<Object?> get props => [result];
}
