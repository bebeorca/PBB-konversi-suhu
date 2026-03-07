import 'package:flutter/material.dart';
import '../controllers/temperature_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<String> list = ['Fahrenheit', 'Kelvin', 'Celcius'];

  String fromValue = 'Fahrenheit';
  String toValue = 'Kelvin';

  TextEditingController suhuController = TextEditingController();

  double hasil = 0;

  final TemperatureController controller = TemperatureController();

  void updateResult() {

    double input = double.tryParse(suhuController.text) ?? 0;

    hasil = controller.convert(
      input,
      fromValue,
      toValue,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Konversi Suhu"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              TextField(
                controller: suhuController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  updateResult();
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
                    value: fromValue,
                    onChanged: (value) {
                      setState(() {
                        fromValue = value!;
                      });
                      updateResult();
                    },
                    items: list.map((value) {
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
                    value: toValue,
                    onChanged: (value) {
                      setState(() {
                        toValue = value!;
                      });
                      updateResult();
                    },
                    items: list.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              const Text(
                "Hasil",
                style: TextStyle(fontSize: 30),
              ),

              const SizedBox(height: 10),

              Text(
                hasil.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}