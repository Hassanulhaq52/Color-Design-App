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
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 15,
            left: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                            builder: (context) =>  SavedColorsScreen(),
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
        );
      },
    );
  }
}
