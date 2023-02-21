import 'package:color_design_app/screens/color_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/color_design_bloc.dart';
import '../constants/constants.dart';

class SavedColorsScreen extends StatelessWidget {
  const SavedColorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorDesignBloc, ColorDesignState>(
      builder: (context, state) {
        context.read<ColorDesignBloc>().loadColorsFromSharedPreferences();
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

              Widget buildHexCodeWidget() {
                if (state.colorDesignModel[index].opacity! != 0.0) {
                  return Text(
                    '0XFF${rgbaColor.value.toRadixString(16).substring(2).toUpperCase()}',
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey,
                    ),
                  );
                } else {
                  return const Text(
                    '0XFF000000',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey,
                    ),
                  );
                }
              }

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
                                  backgroundColor: rgbaColor,
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
                                buildHexCodeWidget(),
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'R: ${state.colorDesignModel[index].red!.toInt()}',
                                  style: Constants.colorStyle,
                                ),
                                Text(
                                  'G: ${state.colorDesignModel[index].green!.toInt()}',
                                  style: Constants.colorStyle,
                                ),
                                Text(
                                  'B: ${state.colorDesignModel[index].blue!.toInt()}',
                                  style: Constants.colorStyle,
                                ),
                                Text(
                                  'A: ${state.colorDesignModel[index].opacity!.toStringAsFixed(1)}',
                                  style: Constants.colorStyle,
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
