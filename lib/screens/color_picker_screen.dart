import 'package:color_design_app/application/color_design_bloc.dart';
import 'package:color_design_app/screens/saved_colors_screen.dart';
import 'package:color_design_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:color_design_app/widgets/slider_row.dart';
import 'package:color_design_app/widgets/modal_bottom_sheet.dart';
import 'package:color_design_app/widgets/description_text.dart';

class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorDesignBloc, ColorDesignState>(
      builder: (context, state) {
        final ColorDesignBloc colorDesignBloc = context.read<ColorDesignBloc>();

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                ),
                context: context,
                isScrollControlled: true,
                builder: (context) => const ModalBottomSheet(),
              );
            },
            child: const Icon(Icons.file_download_outlined, color: Colors.white, size: 35),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white12,
            elevation: 0.0,
            title: const Center(
              child: Text('Color Designer', style: Styles.headingStyle),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SavedColorsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.save, size: 30),
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(
                        state.redColorValue.toInt(),
                        state.greenColorValue.toInt(),
                        state.blueColorValue.toInt(),
                        state.opacityValue,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text('- ' * 33, style: Styles.descriptionStyle.copyWith(fontSize: 21)),


                const SizedBox(height: 8),

                const SizedBox(height: 15),
                const DescriptionText(text: 'You can use the save button to save your designed color.'),
                const SizedBox(height: 20),
                SliderRow(
                  containerColor: Colors.red,
                  onChanged: (value) {
                    colorDesignBloc.add(OnChangeRedColorValue(redColorValue: value));
                  },
                  value: state.redColorValue,
                ),
                const SizedBox(height: 10),
                SliderRow(
                  containerColor: Colors.green,
                  onChanged: (value) {
                    colorDesignBloc.add(OnChangeGreenColorValue(greenColorValue: value));
                  },
                  value: state.greenColorValue,
                ),
                const SizedBox(height: 10),
                SliderRow(
                  containerColor: Colors.blueAccent,
                  onChanged: (value) {
                    colorDesignBloc.add(OnChangeBlueColorValue(blueColorValue: value));
                  },
                  value: state.blueColorValue,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [Colors.white10, Colors.grey.shade800]),
                        ),
                      ),
                      SliderTheme(
                        data: const SliderThemeData(trackHeight: 10),
                        child: SizedBox(
                          width: 280,
                          child: Slider(
                            max: 1.0,
                            min: 0.0,
                            activeColor: Colors.grey.shade400,
                            inactiveColor: Colors.grey.shade200,
                            thumbColor: Colors.grey.shade300,
                            value: state.opacityValue,
                            onChanged: (value) {
                              colorDesignBloc.add(OnChangeOpacityValue(opacityValue: value));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
