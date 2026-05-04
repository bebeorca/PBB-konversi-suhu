import 'package:equatable/equatable.dart';

abstract class TemperatureState extends Equatable {
  const TemperatureState();

  @override
  List<Object?> get props => [];
}

class TemperatureInitial extends TemperatureState {
  const TemperatureInitial();
}

class TemperatureConverted extends TemperatureState {
  final double input;
  final double result;
  final String fromUnit;
  final String toUnit;

  const TemperatureConverted({
    required this.input,
    required this.result,
    required this.fromUnit,
    required this.toUnit,
  });

  @override
  List<Object?> get props => [input, result, fromUnit, toUnit];
}
