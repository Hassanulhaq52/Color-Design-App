import 'dart:convert';

import 'package:color_design_app/screens/color_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../application/color_design_bloc.dart';
import '../constants/constants.dart';
import '../model/color_design_model.dart';

class SavedColorsScreen extends StatelessWidget {
  const SavedColorsScreen({Key? key}) : super(key: key);

//   late List<ColorDesignModel> colorDesignModelList;
//
//   Future<void> _loadColorsFromSharedPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     final encodedList = prefs.getString('colorDesignModel');
//     if (encodedList != null) {
//       final List<ColorDesignModel> savedList = (jsonDecode(encodedList) as List<dynamic>)
//           .map((e) => ColorDesignModel.fromJson(e))
//           .toList();
//     } else {
//       colorDesignModelList = [];
//     }
//   }
//
// // Method to save colorDesignModel list through shared preferences
//   Future<void> saveColorDesignModel(
//       List<ColorDesignModel> colorDesignModel) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final List<String> encodedList = colorDesignModel.map((e) => json.encode(e.toJson())).toList();
//     await prefs.setStringList('colorDesignModel', encodedList!);
//   }

  @override
  Widget build(BuildContext context) {
    final ColorDesignBloc colorDesignBloc =
        BlocProvider.of<ColorDesignBloc>(context);
    colorDesignBloc.loadColorsFromSharedPreferences();
    return BlocBuilder<ColorDesignBloc, ColorDesignState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade100,
            elevation: 0.0,
            // bottomOpacity: 0.0,
            title: const Text(
              'Library',
              style: Constants.headingStyle,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  height: 30,
                  width: 40,
                  decoration: Constants.addButtonDecoration,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ColorPickerScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.colorDesignModel.length,
            itemBuilder: (context, index) {
              final Color rgbaColor = Color.fromRGBO(
                state.colorDesignModel[index].red!.toInt(),
                state.colorDesignModel[index].green!.toInt(),
                state.colorDesignModel[index].blue!.toInt(),
                state.colorDesignModel[index].opacity!,
              );

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: SizedBox(
                      height: 90,
                      child: Card(
                        color: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, left: 3, right: 3),
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: SizedBox(
                                width: 45,
                                height: 45,
                                child: CircleAvatar(
                                  backgroundColor: Color.fromRGBO(
                                    state.colorDesignModel[index].red!.toInt(),
                                    state.colorDesignModel[index].green!
                                        .toInt(),
                                    state.colorDesignModel[index].blue!.toInt(),
                                    state.colorDesignModel[index].opacity!,
                                  ),
                                ),
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${state.colorDesignModel[index].colorName}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 1.0,
                                ),
                                Text(
                                  '${state.colorDesignModel[index].colorNotes}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  '0XFF${rgbaColor.value.toRadixString(16).substring(2).toUpperCase()}',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'R: ${state.colorDesignModel[index].red!.toInt()}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'G: ${state.colorDesignModel[index].green!.toInt()}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'B: ${state.colorDesignModel[index].blue!.toInt()}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  'A: ${state.colorDesignModel[index].opacity!.toStringAsFixed(1)}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
