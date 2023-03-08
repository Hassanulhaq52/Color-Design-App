import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/color_design_model.dart';

part 'color_design_event.dart';

part 'color_design_state.dart';

class ColorDesignBloc extends Bloc<ColorDesignEvent, ColorDesignState> {
  ColorDesignBloc() : super(ColorDesignState.initial()) {
    on<OnChangeRedColorValue>((event, emit) {
      emit(state.copyWith(redColorValue: event.redColorValue));
    });

    on<OnChangeGreenColorValue>((event, emit) {
      emit(state.copyWith(greenColorValue: event.greenColorValue));
    });

    on<OnChangeBlueColorValue>((event, emit) {
      emit(state.copyWith(blueColorValue: event.blueColorValue));
    });

    on<OnChangeOpacityValue>((event, emit) {
      emit(state.copyWith(opacityValue: event.opacityValue));
    });

    on<OnAddColorName>((event, emit) {
      emit(state.copyWith(colorName: event.colorName));
    });

    on<OnAddNotes>((event, emit) {
      emit(state.copyWith(colorNotes: event.colorNotes));
    });

    on<OnPressedSave>((event, emit) async {
      if (state.colorName != '' && state.colorNotes != '') {
        final newColorDesign = ColorDesignModel(
          colorName: state.colorName,
          colorNotes: state.colorNotes,
          red: state.redColorValue,
          green: state.greenColorValue,
          blue: state.blueColorValue,
          opacity: state.opacityValue,
        );

        final loadList = await loadColorsFromSharedPreferences();
        loadList.add(newColorDesign);

        await saveColorsToSharedPreferences(loadList);
      } else {
        print('Please fill all the fields');
      }
    });

    // on<OnRemoveColor>((event, emit) async {
    //   final removeList = await loadColorsFromSharedPreferences();
    //   List<ColorDesignModel>.from(removeList).removeAt(event.index);
    //   // removeList.remove(newColorDesign);
    //
    //   await saveColorsToSharedPreferences(removeList);
    //
    // });

    on<OnRemoveColor>((event, emit) async {
      final removeList = await loadColorsFromSharedPreferences();
      List<ColorDesignModel> newList = List<ColorDesignModel>.from(removeList);
      newList.removeAt(event.index);
      await saveColorsToSharedPreferences(newList);
    });
  }

  Future<List<ColorDesignModel>> loadColorsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final colorsJson = prefs.getString('colors');
    if (colorsJson != null) {
      final colorsMapList =
          (jsonDecode(colorsJson) as List<dynamic>).map((colorMap) => ColorDesignModel.fromJson(colorMap)).toList();
      return colorsMapList;
    } else {
      return [];
    }
  }

  Future<void> saveColorsToSharedPreferences(List<ColorDesignModel> colorDesignModel) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = jsonEncode(colorDesignModel.map((color) => color.toJson()).toList());
    prefs.setString('colors', encodedList);
  }
}
