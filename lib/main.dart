import 'package:color_design_app/application/color_design_bloc.dart';
import 'package:color_design_app/screens/color_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColorDesignBloc(),
      child: const MaterialApp(
        title: 'Color Design App',
        home: ColorPickerScreen(),
      ),
    );
  }
}


