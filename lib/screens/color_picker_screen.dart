import 'package:color_design_app/application/color_design_bloc.dart';
import 'package:color_design_app/screens/saved_colors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:color_design_app/widgets/slider_row.dart';
import 'package:color_design_app/widgets/modal_bottom_sheet.dart';

import '../constants/constants.dart';
import '../model/color_design_model.dart';

class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorDesignBloc, ColorDesignState>(
      builder: (context, state) {
        final ColorDesignBloc colorDesignBloc = context.read<ColorDesignBloc>();

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                context: context,
                isScrollControlled: true,
                builder: (context) => const ModalBottomSheet(),
              );
            },
            child: const Icon(
              Icons.file_download_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white12,
            elevation: 0.0,
            title: const Center(
              child: Text(
                'Color Designer',
                style: Constants.headingStyle,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SavedColorsScreen(),
                        ));
                  },
                  icon: const Icon(
                    Icons.save,
                    size: 30,
                  ),
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: Container(
            color: Colors.white12,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(
                          state.slider1Value.toInt(),
                          state.slider2Value.toInt(),
                          state.slider3Value.toInt(),
                          state.slider4Value,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'You can Customize the following sliders to View the changes render on the color palette above.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'You can use the save button to save your designed color.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SliderRow(
                    containerColor: Colors.red,
                    onChanged: (value) {
                      colorDesignBloc
                          .add(OnChangeValueSlider1(slider1Value: value));
                    },
                    value: state.slider1Value,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SliderRow(
                    containerColor: Colors.green,
                    onChanged: (value) {
                      colorDesignBloc
                          .add(OnChangeValueSlider2(slider2Value: value));
                    },
                    value: state.slider2Value,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SliderRow(
                    containerColor: Colors.blue,
                    onChanged: (value) {
                      colorDesignBloc
                          .add(OnChangeValueSlider3(slider3Value: value));
                    },
                    value: state.slider3Value,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [Colors.white10, Colors.grey.shade800]),
                          ),
                        ),
                        SliderTheme(
                          data: const SliderThemeData(
                            trackHeight: 10,
                          ),
                          child: SizedBox(
                            width: 270,
                            child: Slider(
                              max: 1.0,
                              min: 0.0,
                              activeColor: Colors.grey.shade400,
                              inactiveColor: Colors.grey.shade200,
                              thumbColor: Colors.grey.shade300,
                              value: state.slider4Value,
                              onChanged: (value) {
                                colorDesignBloc.add(
                                    OnChangeValueSlider4(slider4Value: value));
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
          ),
        );
      },
    );
  }
}
