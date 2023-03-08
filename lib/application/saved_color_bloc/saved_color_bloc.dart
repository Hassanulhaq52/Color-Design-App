import 'dart:convert';
import 'package:bloc/bloc.dart';
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

    add(OnLoadAtStart());
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
}
