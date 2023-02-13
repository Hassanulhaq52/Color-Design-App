part of 'color_design_bloc.dart';

class ColorDesignState {
  ColorDesignState({
    required this.slider1Value,
    required this.slider2Value,
    required this.slider3Value,
    required this.slider4Value,
    required this.colorName,
    required this.colorNotes,
  });

  final double slider1Value;
  final double slider2Value;
  final double slider3Value;
  final double slider4Value;
  final String? colorName;
  final String? colorNotes;

  factory ColorDesignState.initial() {
    return ColorDesignState(
      slider1Value: 0.0,
      slider2Value: 0.0,
      slider3Value: 0.0,
      slider4Value: 0.0,
      colorName: '',
      colorNotes: '',
    );
  }

  ColorDesignState copyWith({
    double? slider1Value,
    double? slider2Value,
    double? slider3Value,
    double? slider4Value,
    String? colorName,
    String? colorNotes,
  }) {
    return ColorDesignState(
      slider1Value: slider1Value ?? this.slider1Value,
      slider2Value: slider2Value ?? this.slider2Value,
      slider3Value: slider3Value ?? this.slider3Value,
      slider4Value: slider4Value ?? this.slider4Value,
      colorName: colorName ?? this.colorName,
      colorNotes: colorNotes ?? this.colorNotes,
    );
  }
}
