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
        final Color rgbaColor = Color.fromRGBO(
          state.redColorValue.toInt(),
          state.greenColorValue.toInt(),
          state.blueColorValue.toInt(),
          state.opacityValue,
        );

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
                      color: rgbaColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text('- ' * 33, style: Styles.descriptionStyle.copyWith(fontSize: 21)),

                // CustomPaint(painter: LineDashedPainter()),
                // CustomPaint(
                //   painter: LineDashedPainter(
                //     dashWidth: 13,
                //     dashSpace: 8,
                //     numDashes: 20,
                //     color: Colors.grey.shade400,
                //   ),
                //   size: Size(double.infinity, 2),
                // ),

                // ListView.builder(
                //
                //     itemCount: 10,
                //     itemBuilder: (context, index){
                //
                //   return  Row(
                //     children: [
                //       Divider(
                //         indent: 6,
                //         endIndent: 10,
                //         height: 5,
                //         color: Colors.grey,
                //         thickness: 2,
                //       ),
                //     ],
                //   );
                //
                // }),
                // for(int i =0; i<20; i++){
                //   Divider(
                //     indent: 6,
                //     endIndent: 10,
                //     height: 5,
                //     color: Colors.grey,
                //     thickness: 2,
                //   ),
                // }
                //
                //  Divider(
                //   indent: 6,
                //   endIndent: 10,
                //   height: 5,
                //   color: Colors.grey,
                //   thickness: 2,
                // ),

                // Divider(
                //   child: CustomPaint(
                //     painter: LineDashedPainter(
                //       dashWidth: 5,
                //       dashSpace: 5,
                //       color: Colors.grey,
                //       numDashes: 20,
                //     ),
                //   ),
                // ),

                // Container(
                //   width: 200,
                //   height: 2,
                //   decoration: BoxDecoration(
                //     border: Border(
                //       bottom: BorderSide(
                //         width: 2,
                //         color: Colors.grey,
                //         style: BorderStyle.solid
                //       ),
                //     ),
                //   ),
                // ),

                const SizedBox(height: 10),
                const DescriptionText(
                    text:
                        'You can customize the following sliders to view the changes render on the color palette above'),
                const SizedBox(height: 10),

                const DescriptionText(text: 'You can use the save button to save your designed color.'),
                const SizedBox(height: 20),
                SliderRow(
                  containerColor: Colors.redAccent.shade400,
                  onChanged: (value) {
                    colorDesignBloc.add(OnChangeRedColorValue(redColorValue: value));
                  },
                  sliderValue: state.redColorValue,
                ),
                const SizedBox(height: 10),
                SliderRow(
                  containerColor: Colors.lightGreenAccent.shade700,
                  onChanged: (value) {
                    colorDesignBloc.add(OnChangeGreenColorValue(greenColorValue: value));
                  },
                  sliderValue: state.greenColorValue,
                ),
                const SizedBox(height: 10),
                SliderRow(
                  containerColor: Colors.blueAccent.shade700,
                  onChanged: (value) {
                    colorDesignBloc.add(OnChangeBlueColorValue(blueColorValue: value));
                  },
                  sliderValue: state.blueColorValue,
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
