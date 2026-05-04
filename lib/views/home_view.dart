import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_exports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> temperatureUnits = ['Celsius', 'Fahrenheit', 'Kelvin'];
    final TextEditingController suhuController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Konversi Suhu")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<TemperatureBloc, TemperatureState>(
            builder: (context, state) {
              // Update text field if input changed from BLoC
              if (state is TemperatureConverted &&
                  suhuController.text.isEmpty) {
                suhuController.text = state.input.toString();
              }

              return Column(
                children: [
                  TextField(
                    controller: suhuController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      context.read<TemperatureBloc>().add(
                        TemperatureInputChanged(value),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: "Masukkan suhu",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dari"),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: state is TemperatureConverted
                            ? state.fromUnit
                            : 'Fahrenheit',
                        onChanged: (value) {
                          if (value != null) {
                            context.read<TemperatureBloc>().add(
                              FromUnitChanged(value),
                            );
                          }
                        },
                        items: temperatureUnits.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Ke"),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: state is TemperatureConverted
                            ? state.toUnit
                            : 'Kelvin',
                        onChanged: (value) {
                          if (value != null) {
                            context.read<TemperatureBloc>().add(
                              ToUnitChanged(value),
                            );
                          }
                        },
                        items: temperatureUnits.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Text("Hasil", style: TextStyle(fontSize: 30)),
                  const SizedBox(height: 10),
                  Text(
                    state is TemperatureConverted
                        ? state.result.toStringAsFixed(2)
                        : '0.00',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
