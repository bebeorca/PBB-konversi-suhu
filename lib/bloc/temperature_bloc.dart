import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/temperature_controller.dart';
import 'temperature_event.dart';
import 'temperature_state.dart';

class TemperatureBloc extends Bloc<TemperatureEvent, TemperatureState> {
  final TemperatureController _controller = TemperatureController();

  double _currentInput = 0;
  String _fromUnit = 'Fahrenheit';
  String _toUnit = 'Kelvin';
  double _currentResult = 0;

  TemperatureBloc() : super(const TemperatureInitial()) {
    on<TemperatureInputChanged>(_onTemperatureInputChanged);
    on<FromUnitChanged>(_onFromUnitChanged);
    on<ToUnitChanged>(_onToUnitChanged);
  }

  Future<void> _onTemperatureInputChanged(
    TemperatureInputChanged event,
    Emitter<TemperatureState> emit,
  ) async {
    _currentInput = double.tryParse(event.input) ?? 0;
    _currentResult = _controller.convert(_currentInput, _fromUnit, _toUnit);

    emit(
      TemperatureConverted(
        input: _currentInput,
        result: _currentResult,
        fromUnit: _fromUnit,
        toUnit: _toUnit,
      ),
    );
  }

  Future<void> _onFromUnitChanged(
    FromUnitChanged event,
    Emitter<TemperatureState> emit,
  ) async {
    _fromUnit = event.fromUnit;
    _currentResult = _controller.convert(_currentInput, _fromUnit, _toUnit);

    emit(
      TemperatureConverted(
        input: _currentInput,
        result: _currentResult,
        fromUnit: _fromUnit,
        toUnit: _toUnit,
      ),
    );
  }

  Future<void> _onToUnitChanged(
    ToUnitChanged event,
    Emitter<TemperatureState> emit,
  ) async {
    _toUnit = event.toUnit;
    _currentResult = _controller.convert(_currentInput, _fromUnit, _toUnit);

    emit(
      TemperatureConverted(
        input: _currentInput,
        result: _currentResult,
        fromUnit: _fromUnit,
        toUnit: _toUnit,
      ),
    );
  }
}
