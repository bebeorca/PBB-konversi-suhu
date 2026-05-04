import 'package:equatable/equatable.dart';

abstract class TemperatureEvent extends Equatable {
  const TemperatureEvent();

  @override
  List<Object?> get props => [];
}

class TemperatureInputChanged extends TemperatureEvent {
  final String input;

  const TemperatureInputChanged(this.input);

  @override
  List<Object?> get props => [input];
}

class FromUnitChanged extends TemperatureEvent {
  final String fromUnit;

  const FromUnitChanged(this.fromUnit);

  @override
  List<Object?> get props => [fromUnit];
}

class ToUnitChanged extends TemperatureEvent {
  final String toUnit;

  const ToUnitChanged(this.toUnit);

  @override
  List<Object?> get props => [toUnit];
}
