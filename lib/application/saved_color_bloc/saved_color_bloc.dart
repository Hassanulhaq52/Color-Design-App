//
import 'package:bloc/bloc.dart';
import 'package:color_design_app/application/color_picker_bloc/color_design_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/color_design_model.dart';
import 'package:path/path.dart';

part 'saved_color_event.dart';

//
part 'saved_color_state.dart';

// class SavedColorBloc extends Bloc<SavedColorEvent, SavedColorState> {
//   SavedColorBloc() : super(SavedColorState.initial()) {
//     on<OnLoadAtStart>((event, emit) async {
//       final colorsList = await loadColorsFromSharedPreferences();
//       emit(state.copyWith(colorsList));
//     });
//
//
//
//     add(OnLoadAtStart());
//   }
//
//   // Future<List<ColorDesignModel>> loadColorsFromSharedPreferences() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   final colorsJson = prefs.getString('colors');
//   //   if (colorsJson != null) {
//   //     final colorsMapList =
//   //         (jsonDecode(colorsJson) as List<dynamic>).map((colorMap) => ColorDesignModel.fromJson(colorMap)).toList();
//   //     return colorsMapList;
//   //   } else {
//   //     return [];
//   //   }
//   // }
//
//   Future<Database> _initDatabase() async {
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, 'color_design_app.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//         CREATE TABLE colors(
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           colorName TEXT,
//           colorNotes TEXT,
//           red REAL,
//           green REAL,
//           blue REAL,
//           opacity REAL
//         )
//         ''');
//       },
//     );
//   }
//
//
//   Future<List<ColorDesignModel>> loadColorsFromSharedPreferences() async {
//     final db = await _initDatabase();
//     final result = await db.query('colors');
//     return List.generate(result.length, (index) => ColorDesignModel.fromJson(result[index]));
//   }
//
// }

class SavedColorBloc extends Bloc<SavedColorEvent, SavedColorState> {
  SavedColorBloc() : super(SavedColorState.initial()) {
    on<OnLoadAtStart>((event, emit) async {
      final colorsList = await loadColorsFromSqfLite();
      emit(state.copyWith(colorsList));
    });

    // on<OnColorDeleted>((event, emit) {
    //   final updatedColorsList = state.colorsList.where((color) => color.id != event.colorId).toList();
    //   emit(state.copyWith(colorsList: updatedColorsList));
    // });

    // on<OnColorDeleted>((event, emit) async {
    //   print('Removing color at index ${event.index}');
    //   final db = await _initDatabase();
    //   await db.delete(
    //     'colors',
    //     where: 'id = ?',
    //     whereArgs: [event.index],
    //   );
    //
    //   final colorsList = await loadColorsFromSharedPreferences();
    //   emit(state.copyWith(colorsList));
    //   add(OnColorDeleted(index: event.));
    //
    //
    // });
    //
    //
    // on<OnColorDeleted>((event, emit) {
    //   final updatedColorsList = state.colorDesignModel.where((color) => color != color).toList();
    //   emit(state.copyWith(updatedColorsList));
    // });

    add(OnLoadAtStart());
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

  Future<List<ColorDesignModel>> loadColorsFromSqfLite() async {
    final db = await _initDatabase();
    final result = await db.query('colors');
    return List.generate(result.length, (index) => ColorDesignModel.fromJson(result[index]));
  }
}

// class SavedColorBloc extends Bloc<SavedColorEvent, SavedColorState> {
//   SavedColorBloc() : super(SavedColorState.initial()) {
//     on<OnLoadAtStart>((event, emit) async {
//       final colorsList = await loadColorsFromSharedPreferences();
//       emit(state.copyWith(colorsList));
//     });
//
//     // Listen for the OnColorRemoved event and remove the color from the list of colors
//     // Then, emit a new state with the updated list of colors
//     on<OnColorDeleted>((event, emit) {
//       final updatedColorsList = state.colorDesignModel.where((color)  != event.index).toList();
//       emit(state.copyWith(updatedColorsList));
//       _updateColorsInDatabase(updatedColorsList); // Update the list of colors in the database
//     });
//
//     add(OnLoadAtStart());
//   }
//
//   Future<Database> _initDatabase() async {
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, 'color_design_app.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//         CREATE TABLE colors(
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           colorName TEXT,
//           colorNotes TEXT,
//           red REAL,
//           green REAL,
//           blue REAL,
//           opacity REAL
//         )
//         ''');
//       },
//     );
//   }
//
//   Future<List<ColorDesignModel>> loadColorsFromSharedPreferences() async {
//     final db = await _initDatabase();
//     final result = await db.query('colors');
//     return List.generate(result.length, (index) => ColorDesignModel.fromJson(result[index]));
//   }
//
//   // Update the list of colors in the database
//   Future<void> _updateColorsInDatabase(List<ColorDesignModel> colorsList) async {
//     final db = await _initDatabase();
//
//     // Delete all colors from the table
//     await db.delete('colors');
//
//     // Insert the updated list of colors into the table
//     for (final color in colorsList) {
//       await db.insert('colors', color.toJson());
//     }
//   }
// }
