// import 'dart:convert';
// import 'package:bloc/bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../model/color_design_model.dart';
//
// part 'color_design_event.dart';
//
// part 'color_design_state.dart';
//
// class ColorDesignBloc extends Bloc<ColorDesignEvent, ColorDesignState> {
//   ColorDesignBloc() : super(ColorDesignState.initial()) {
//     on<OnChangeRedColorValue>((event, emit) {
//       emit(state.copyWith(redColorValue: event.redColorValue));
//     });
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
//         final newColorDesign = ColorDesignModel(
//           colorName: state.colorName,
//           colorNotes: state.colorNotes,
//           red: state.redColorValue,
//           green: state.greenColorValue,
//           blue: state.blueColorValue,
//           opacity: state.opacityValue,
//         );
//
//         final loadList = await loadColorsFromSharedPreferences();
//         loadList.add(newColorDesign);
//
//         await saveColorsToSharedPreferences(loadList);
//       } else {
//         print('Please fill all the fields');
//       }
//     });
//
//     on<OnRemoveColor>((event, emit) async {
//       final removeList = await loadColorsFromSharedPreferences();
//       List<ColorDesignModel> newList = List<ColorDesignModel>.from(removeList);
//       newList.removeAt(event.index);
//       await saveColorsToSharedPreferences(newList);
//     });
//   }
//
//   Future<List<ColorDesignModel>> loadColorsFromSharedPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     final colorsJson = prefs.getString('colors');
//     if (colorsJson != null) {
//       final colorsMapList =
//           (jsonDecode(colorsJson) as List<dynamic>).map((colorMap) => ColorDesignModel.fromJson(colorMap)).toList();
//       return colorsMapList;
//     } else {
//       return [];
//     }
//   }
//
//   Future<void> saveColorsToSharedPreferences(List<ColorDesignModel> colorDesignModel) async {
//     final prefs = await SharedPreferences.getInstance();
//     final encodedList = jsonEncode(colorDesignModel.map((color) => color.toJson()).toList());
//     prefs.setString('colors', encodedList);
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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

        final db = await _initDatabase();
        await db.insert('colors', newColorDesign.toJson());

        // emit(state.copyWith(
        //   colorName: '',
        //   colorNotes: '',
        //   redColorValue: 0,
        //   greenColorValue: 0,
        //   blueColorValue: 0,
        //   opacityValue: 1.0,
        // ));
      } else {
        print('Please fill all the fields');
      }
    });

    on<OnRemoveColor>((event, emit) async {
      print('Removing color at index ${event.index}');
      final db = await _initDatabase();
      await db.delete(
        'colors',
        where: 'id = ?',
        whereArgs: [event.index],
      );

      // final colorsList = await loadColorsFromSharedPreferences(db);
      // emit(state.copyWith(colorsList: colorsList));
      // add(OnColorsUpdated(colorsList));
    });
  }

  Future<List<ColorDesignModel>> loadColorsFromSharedPreferences() async {
    final db = await _initDatabase();
    final result = await db.query('colors');
    return List.generate(result.length, (index) => ColorDesignModel.fromJson(result[index]));
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'color_design_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE colors(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          colorName TEXT,
          colorNotes TEXT,
          red REAL,
          green REAL,
          blue REAL,
          opacity REAL
        )
        ''');
      },
    );
  }
}





// import 'package:bloc/bloc.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'dart:async';
// import '../../model/color_design_model.dart';
//
// part 'color_design_event.dart';
// part 'color_design_state.dart';
//
// class ColorDesignBloc extends Bloc<ColorDesignEvent, ColorDesignState> {
//   late Database _database;
//
//   ColorDesignBloc() : super(ColorDesignState.initial()) {
//     _initDatabase();
//
//     on<OnChangeRedColorValue>((event, emit) {
//       emit(state.copyWith(redColorValue: event.redColorValue));
//     });
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
//         final newColorDesign = ColorDesignModel(
//           colorName: state.colorName,
//           colorNotes: state.colorNotes,
//           red: state.redColorValue,
//           green: state.greenColorValue,
//           blue: state.blueColorValue,
//           opacity: state.opacityValue,
//         );
//         await _database.insert('colors', newColorDesign.toJson());
//         emit(state.copyWith());
//       } else {
//         print('Please fill all the fields');
//       }
//     });
//
//     on<OnRemoveColor>((event, emit) async {
//       await _database.delete(
//         'colors',
//         where: 'id = ?',
//         whereArgs: [event.index],
//       );
//       emit(state.copyWith());
//     });
//   }
//
//   void _initDatabase() async {
//     _database = await openDatabase(
//       join(await getDatabasesPath(), 'color_design.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE colors(id INTEGER PRIMARY KEY, name TEXT, notes TEXT, red INTEGER, green INTEGER, blue INTEGER, opacity INTEGER)',
//         );
//       },
//       version: 1,
//     );
//   }
//
//   Future<List<ColorDesignModel>> loadColorsFromDatabase() async {
//     final List<Map<String, dynamic>> colorMaps = await _database.query('colors');
//     final List<ColorDesignModel> colors = colorMaps.map((colorMap) => ColorDesignModel.fromJson(colorMap)).toList();
//     return colors;
//   }
//
//   Future<void> saveColorsToDatabase(List<ColorDesignModel> colors) async {
//     await _database.transaction((txn) async {
//       for (final color in colors) {
//         await txn.insert('colors', color.toJson());
//       }
//     });
//   }
//
//   @override
//   Future<void> close() async {
//     await _database.close();
//     super.close();
//   }
// }

// import 'package:bloc/bloc.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'dart:async';
// import '../../model/color_design_model.dart';
//
// part 'color_design_event.dart';
// part 'color_design_state.dart';
//
// class ColorDesignBloc extends Bloc<ColorDesignEvent, ColorDesignState> {
//   late Database _database;
//
//   ColorDesignBloc() : super(ColorDesignState.initial()) {
//     _initDatabase();
//
//     on<OnChangeRedColorValue>((event, emit) {
//       emit(state.copyWith(redColorValue: event.redColorValue));
//     });
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
//         final newColorDesign = ColorDesignModel(
//           colorName: state.colorName,
//           colorNotes: state.colorNotes,
//           red: state.redColorValue,
//           green: state.greenColorValue,
//           blue: state.blueColorValue,
//           opacity: state.opacityValue,
//         );
//         await _database.insert('colors', newColorDesign.toJson());
//         emit(state.copyWith());
//       } else {
//         print('Please fill all the fields');
//       }
//     });
//
//     on<OnRemoveColor>((event, emit) async {
//       await _database.delete(
//         'colors',
//         where: 'id = ?',
//         whereArgs: [event.index],
//       );
//       emit(state.copyWith());
//     });
//   }
//
//   void _initDatabase() async {
//     _database = await openDatabase(
//       join(await getDatabasesPath(), 'color_design.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE colors(id INTEGER PRIMARY KEY, name TEXT, notes TEXT, red INTEGER, green INTEGER, blue INTEGER, opacity INTEGER)',
//         );
//       },
//       version: 1,
//     );
//   }
//
//   Future<List<ColorDesignModel>> loadColorsFromDatabase() async {
//     final List<Map<String, dynamic>> colorMaps = await _database.query('colors');
//     final List<ColorDesignModel> colors = colorMaps.map((colorMap) => ColorDesignModel.fromJson(colorMap)).toList();
//     return colors;
//   }
//
//   Future<void> saveColorsToDatabase(List<ColorDesignModel> colors) async {
//     await _database.transaction((txn) async {
//       for (final color in colors) {
//         await txn.insert('colors', color.toJson());
//       }
//     });
//   }
//
//   @override
//   Future<void> close() async {
//     await _database.close();
//     super.close();
//   }
// }
