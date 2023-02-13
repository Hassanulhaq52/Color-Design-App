import 'package:color_design_app/application/color_design_bloc.dart';
import 'package:color_design_app/constants/constants.dart';
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
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: Constants.taskFieldDecoration.copyWith(

                    hintText: 'Enter Color Name',

                  ),
                  onChanged: (value) {
                    colorDesignBloc.add(OnAddColorName(colorName: value));
                  },
                ),
                const SizedBox(height: 20,),
                TextField(
                  decoration: Constants.taskFieldDecoration.copyWith(

                    hintText: 'Enter Color Notes',

                  ),
                  onChanged: (value) {
                    colorDesignBloc.add(OnAddNotes(colorNotes: value));
                  },
                ),
                Text('${state.colorNotes}'),
                Text('${state.colorName}'),


                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
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
                        primary: Colors.purple.shade400,
                      ),
                      child: const Text('Save')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
