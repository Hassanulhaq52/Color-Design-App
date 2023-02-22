import 'package:color_design_app/application/color_design_bloc.dart';
import 'package:color_design_app/screens/saved_colors_screen.dart';
import 'package:color_design_app/utils/styles.dart';
import 'package:flutter/cupertino.dart';
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
          padding: EdgeInsets.only(top: 20, right: 15, left: 15, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: Styles.containerDecoration,
                child: TextField(
                  decoration: Styles.colorFieldDecoration.copyWith(hintText: 'Enter Color Name'),
                  onChanged: (value) {
                    colorDesignBloc.add(OnAddColorName(colorName: value));
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 160,
                decoration: Styles.containerDecoration,
                child: TextField(
                  decoration: Styles.colorFieldDecoration.copyWith(hintText: 'Enter Notes'),
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
                    if (state.colorName != '' &&
                        state.colorNotes != '') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SavedColorsScreen(),
                        ),
                      );
                    } else {
                      print('error');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: CupertinoColors.activeBlue,
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }
}
