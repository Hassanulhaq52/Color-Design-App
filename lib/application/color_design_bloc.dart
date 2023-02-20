import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/color_design_model.dart';

part 'color_design_event.dart';
part 'color_design_state.dart';

class ColorDesignBloc extends Bloc<ColorDesignEvent, ColorDesignState> {

  ColorDesignBloc() : super(ColorDesignState.initial()) {
    on<OnChangeValueSlider1>((event, emit) {
      emit(state.copyWith(slider1Value: event.slider1Value));
    });
    on<OnChangeValueSlider2>((event, emit) {
      emit(state.copyWith(slider2Value: event.slider2Value));
    });
    on<OnChangeValueSlider3>((event, emit) {
      emit(state.copyWith(slider3Value: event.slider3Value));
    });
    on<OnChangeValueSlider4>((event, emit) {
      emit(state.copyWith(slider4Value: event.slider4Value));
    });
    on<OnAddColorName>((event, emit) {
      emit(state.copyWith(colorName: event.colorName));
    });
    on<OnAddNotes>((event, emit) {
      emit(state.copyWith(colorNotes: event.colorNotes));
    });

    on<OnPressedSave>((event, emit) {
      if (state.colorName != null &&
          state.colorName != '' &&
          state.colorNotes != null &&
          state.colorNotes != '') {
        emit(
          state.copyWith(
            colorDesignModel: state.colorDesignModel
              ..add(ColorDesignModel(
                colorName: state.colorName!,
                colorNotes: state.colorNotes!,
                red: state.slider1Value,
                green: state.slider2Value,
                blue: state.slider3Value,
                opacity: state.slider4Value,
              ),),
          ),
        );
        _saveColorsToSharedPreferences(state.colorDesignModel);
      } else {
        print('Plz fill all the Fields');
      }
    });
  }

  Future<void> loadColorsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final colorsJson = prefs.getString('colors');
    if (colorsJson != null) {
      final colorsMapList = (jsonDecode(colorsJson) as List<dynamic>).map((colorMap) => ColorDesignModel.fromJson(colorMap))
          .toList();
      emit(state.copyWith(colorDesignModel: colorsMapList));
    } else {
      emit(state.copyWith(colorDesignModel: []));
    }
  }

  Future<void> _saveColorsToSharedPreferences(
      List<ColorDesignModel> colorDesignModel) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList =
        jsonEncode(colorDesignModel.map((color) => color.toJson()).toList());
    prefs.setString('colors', encodedList);
  }
}

