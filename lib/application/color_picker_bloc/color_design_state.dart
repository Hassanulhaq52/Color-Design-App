part of 'color_design_bloc.dart';

class ColorDesignState {
  ColorDesignState({
    required this.redColorValue,
    required this.greenColorValue,
    required this.blueColorValue,
    required this.opacityValue,
    required this.colorName,
    required this.colorNotes,
  });

  final double redColorValue;
  final double greenColorValue;
  final double blueColorValue;
  final double opacityValue;
  final String colorName;
  final String colorNotes;

  factory ColorDesignState.initial() {
    return ColorDesignState(
      redColorValue: 100.0,
      greenColorValue: 100.0,
      blueColorValue: 100.0,
      opacityValue: 0.2,
      colorName: '',
      colorNotes: '',
    );
  }

  ColorDesignState copyWith({
    double? redColorValue,
    double? greenColorValue,
    double? blueColorValue,
    double? opacityValue,
    String? colorName,
    String? colorNotes,
  }) {
    return ColorDesignState(
      redColorValue: redColorValue ?? this.redColorValue,
      greenColorValue: greenColorValue ?? this.greenColorValue,
      blueColorValue: blueColorValue ?? this.blueColorValue,
      opacityValue: opacityValue ?? this.opacityValue,
      colorName: colorName ?? this.colorName,
      colorNotes: colorNotes ?? this.colorNotes,
    );
  }
}
