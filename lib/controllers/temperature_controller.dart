class TemperatureController {

  double convert(double input, String from, String to) {

    if (from == "Celcius" && to == "Fahrenheit") {
      return (input * 9/5) + 32;
    }

    if (from == "Celcius" && to == "Kelvin") {
      return input + 273.15;
    }

    if (from == "Fahrenheit" && to == "Celcius") {
      return (input - 32) * 5/9;
    }

    if (from == "Fahrenheit" && to == "Kelvin") {
      return (input - 32) * 5/9 + 273.15;
    }

    if (from == "Kelvin" && to == "Celcius") {
      return input - 273.15;
    }

    if (from == "Kelvin" && to == "Fahrenheit") {
      return (input - 273.15) * 9/5 + 32;
    }

    return input;
  }
}