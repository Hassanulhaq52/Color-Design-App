import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/color_design_model.dart';
part 'color_design_event.dart';
part 'color_design_state.dart';

class ColorDesignBloc extends Bloc<ColorDesignEvent, ColorDesignState> {

  ColorDesignBloc() : super(ColorDesignState.initial()) {

    on<OnChangeRedColorValue>((event, emit) {
      emit(state.copyWith(redColorValue: event.redColorValue));
    });

    on<OnLoadAtStart>((event, emit) async {
      final colorsList = await loadColorsFromSharedPreferences();
      emit(state.copyWith(colorDesignModel: colorsList));
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

    add(OnLoadAtStart());

    on<OnPressedSave>((event, emit) {
      if (state.colorName != '' && state.colorNotes != '') {
        emit(
          state.copyWith(
            colorDesignModel: state.colorDesignModel
              ..add(
                ColorDesignModel(
                  colorName: state.colorName,
                  colorNotes: state.colorNotes,
                  red: state.redColorValue,
                  green: state.greenColorValue,
                  blue: state.blueColorValue,
                  opacity: state.opacityValue,
                ),
              ),
          ),
        );
        saveColorsToSharedPreferences();
      } else {
        print('Plz fill all the Fields');
      }
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

  Future<void> saveColorsToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = jsonEncode(state.colorDesignModel.map((color) => color.toJson()).toList());
    prefs.setString('colors', encodedList);
    // loadColorsFromSharedPreferences();
  }
}

// import 'dart:convert';
// import 'package:bloc/bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../model/color_design_model.dart';
//
// part 'color_design_event.dart';
// part 'color_design_state.dart';
//
// class ColorDesignBloc extends Bloc<ColorDesignEvent, ColorDesignState> {
//   ColorDesignBloc() : super(ColorDesignState.initial()) {
//     on<OnChangeRedColorValue>((event, emit) {
//       emit(state.copyWith(redColorValue: event.redColorValue));
//     });
//
//     on<OnLoadAtStart>((event, emit) => onLoadAtStart(event, emit));
//
//
//     on<OnChangeGreenColorValue>((event, emit) {
//       emit(state.copyWith(greenColorValue: event.greenColorValue));
//     });
//
//     on<OnChangeBlueColorValue>((event, emit) {
//       emit(state.copyWith(blueColorValue: event.blueColorValue));
//     });
//
//     on<OnChangeOpacityValue>((event, emit) {
//       emit(state.copyWith(opacityValue: event.opacityValue));
//     });
//
//     on<OnAddColorName>((event, emit) {
//       emit(state.copyWith(colorName: event.colorName));
//     });
//
//     on<OnAddNotes>((event, emit) {
//       emit(state.copyWith(colorNotes: event.colorNotes));
//     });
//
//     on<OnPressedSave>((event, emit) async {
//       if (state.colorName != '' && state.colorNotes != '') {
//         emit(
//           state.copyWith(
//             colorDesignModel: state.colorDesignModel
//               ..add(
//                 ColorDesignModel(
//                   colorName: state.colorName,
//                   colorNotes: state.colorNotes,
//                   red: state.redColorValue,
//                   green: state.greenColorValue,
//                   blue: state.blueColorValue,
//                   opacity: state.opacityValue,
//                 ),
//               ),
//           ),
//         );
//         await _saveColorsToSharedPreferences(state.colorDesignModel);
//       } else {
//         print('Plz fill all the Fields');
//       }
//     });
//
//     add(OnLoadAtStart());
//   }
//
//   Future<void> _loadColorsFromSharedPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     final colorsJson = prefs.getString('colors');
//     if (colorsJson != null) {
//       final colorsMapList = (jsonDecode(colorsJson) as List<dynamic>)
//           .map((colorMap) => ColorDesignModel.fromJson(colorMap))
//           .toList();
//      emit(state.copyWith(colorDesignModel: colorsMapList));
//     } else {
//       emit(state.copyWith(colorDesignModel: []));
//     }
//   }
//
//   Future<void> _saveColorsToSharedPreferences(
//       List<ColorDesignModel> colors) async {
//     final prefs = await SharedPreferences.getInstance();
//     final encodedList =
//     jsonEncode(colors.map((color) => color.toJson()).toList());
//     prefs.setString('colors', encodedList);
//   }
//
//   onLoadAtStart(OnLoadAtStart event, Emitter<ColorDesignState> emit) {
//     _loadColorsFromSharedPreferences();
//   }
// }
