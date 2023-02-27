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
}
