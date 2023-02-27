import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:color_design_app/application/color_design_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/color_design_model.dart';

part 'saved_color_event.dart';

part 'saved_color_state.dart';

class SavedColorBloc extends Bloc<SavedColorEvent, SavedColorState> {
  SavedColorBloc() : super(SavedColorState.initial()) {

    on<OnLoadAtStart>((event, emit) async {
      final colorsList = await loadColorsFromSharedPreferences();
      emit(state.copyWith(colorsList));
    });

    on<OnPressedSaved>((event, emit) {
      emit(state.copyWith(state.colorDesignModel));

      // saveColorsToSharedPreferences();

      //   if (state.colorName != '' && state.colorNotes != '') {
      //     emit(
      //       state.copyWith(
      //         colorDesignModel: state.colorDesignModel
      //           ..add(
      //             ColorDesignModel(
      //               colorName: state.colorName,
      //               colorNotes: state.colorNotes,
      //               red: state.redColorValue,
      //               green: state.greenColorValue,
      //               blue: state.blueColorValue,
      //               opacity: state.opacityValue,
      //             ),
      //           ),
      //       ),
      //     );
      //     saveColorsToSharedPreferences();
      //   } else {
      //     print('Plz fill all the Fields');
      //   }
    });


    add(OnLoadAtStart());
  }

  Future<List<ColorDesignModel>> loadColorsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final colorsJson = prefs.getString('colors');
    if (colorsJson != null) {
      final colorsMapList = (jsonDecode(colorsJson) as List<dynamic>).map((colorMap) => ColorDesignModel.fromJson(colorMap)).toList();
      return colorsMapList;
    } else {
      return [];
    }
  }
}


