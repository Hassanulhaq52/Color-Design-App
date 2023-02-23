part of 'color_design_bloc.dart';

class ColorDesignState {
  ColorDesignState({
    required this.redColorValue,
    required this.greenColorValue,
    required this.blueColorValue,
    required this.opacityValue,
    required this.colorName,
    required this.colorNotes,
    required this.colorDesignModel,
  });

  final double redColorValue;
  final double greenColorValue;
  final double blueColorValue;
  final double opacityValue;
  final String colorName;
  final String colorNotes;
  List<ColorDesignModel> colorDesignModel;

  factory ColorDesignState.initial() {
    return ColorDesignState(
      redColorValue: 100.0,
      greenColorValue: 100.0,
      blueColorValue: 100.0,
      opacityValue: 0.2,
      colorName: '',
      colorNotes: '',
      colorDesignModel: [],
    );
  }

  ColorDesignState copyWith({
    double? redColorValue,
    double? greenColorValue,
    double? blueColorValue,
    double? opacityValue,
    String? colorName,
    String? colorNotes,
    List<ColorDesignModel>? colorDesignModel,
  }) {
    return ColorDesignState(
      redColorValue: redColorValue ?? this.redColorValue,
      greenColorValue: greenColorValue ?? this.greenColorValue,
      blueColorValue: blueColorValue ?? this.blueColorValue,
      opacityValue: opacityValue ?? this.opacityValue,
      colorName: colorName ?? this.colorName,
      colorNotes: colorNotes ?? this.colorNotes,
      colorDesignModel: colorDesignModel ?? this.colorDesignModel,
    );
  }
}
