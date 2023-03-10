part of 'saved_color_bloc.dart';

class SavedColorState {
  SavedColorState({
    required this.colorDesignModel,
  });

  List<ColorDesignModel> colorDesignModel;

  factory SavedColorState.initial() {
    return SavedColorState(
      colorDesignModel: [],
    );
  }

  SavedColorState copyWith(
    List<ColorDesignModel>? colorDesignModel,
  ) {
    return SavedColorState(
      colorDesignModel: colorDesignModel ?? this.colorDesignModel,
    );
  }
  List<ColorDesignModel> getColorsList() {
    return colorDesignModel;
  }
}



// class SavedColorState {
//   final List<ColorDesignModel> colorsList;
//
//   SavedColorState({required this.colorsList});
//
//   SavedColorState.initial() : colorsList = [];
//
//   SavedColorState copyWith({List<ColorDesignModel>? colorsList}) {
//     return SavedColorState(
//       colorsList: colorsList ?? this.colorsList,
//     );
//   }
//
//   List<ColorDesignModel> getColorsList() {
//     return colorsList;
//   }
// }
