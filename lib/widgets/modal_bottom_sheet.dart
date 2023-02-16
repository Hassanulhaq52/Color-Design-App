import 'package:color_design_app/application/color_design_bloc.dart';
import 'package:color_design_app/constants/constants.dart';
import 'package:color_design_app/model/color_design_model.dart';
import 'package:color_design_app/screens/saved_colors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorDesignBloc, ColorDesignState>(
      builder: (context, state) {
        final ColorDesignBloc colorDesignBloc = context.read<ColorDesignBloc>();
        return Container(
          padding: const EdgeInsets.only(top: 20),
          height: 330,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: Constants.containerDecoration,
                  child: TextField(
                    decoration: Constants.taskFieldDecoration.copyWith(
                      hintText: 'Enter Color Name',
                    ),
                    onChanged: (value) {
                      colorDesignBloc.add(OnAddColorName(colorName: value));
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 185,
                  decoration: Constants.containerDecoration,
                  child: TextField(
                    decoration: Constants.taskFieldDecoration
                        .copyWith(hintText: 'Enter Notes'),
                    onChanged: (value) {
                      colorDesignBloc.add(OnAddNotes(colorNotes: value));
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text('${state.colorName}'),
                // Text('${state.colorNotes}'),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      colorDesignBloc.add(OnPressedSave());
                      print(ColorDesignModel().colorNotes);
                      if (state.colorName != null &&
                          state.colorName != '' &&
                          state.colorNotes != null &&
                          state.colorNotes != '') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SavedColorsScreen(),
                            ));
                      } else {
                        print('error');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.blueAccent,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
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
