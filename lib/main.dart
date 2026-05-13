import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc_exports.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TemperatureBloc(),
        child: const LoginView(),
      ),
      routes: {
        '/home': (context) => BlocProvider(
          create: (context) => TemperatureBloc(),
          child: const HomeView(),
        ),
        '/login': (context) => const LoginView(),
      },
    );
  }
}
