import 'package:color_design_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/color_picker_bloc/color_design_bloc.dart';

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
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    colorDesignBloc.add(OnPressedSave());
                    Navigator.pop(context);

                    state.colorName != '' && state.colorNotes != ''
                        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Center(child: Text('${state.colorName} Color is Added to Color\'s Library')),
                            backgroundColor: Colors.green,
                          ))
                        : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Center(child: Text('Please Fill all the Fields')),
                            backgroundColor: Colors.red,
                          ));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text('Save', style: TextStyle(fontSize: 18)),
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
