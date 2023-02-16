part of 'color_design_bloc.dart';

abstract class ColorDesignEvent {}

class OnChangeValueSlider1 extends ColorDesignEvent {
  OnChangeValueSlider1({this.slider1Value});

  final double? slider1Value;
}

class OnChangeValueSlider2 extends ColorDesignEvent {
  OnChangeValueSlider2({this.slider2Value});

  final double? slider2Value;
}

class OnChangeValueSlider3 extends ColorDesignEvent {
  OnChangeValueSlider3({this.slider3Value});

  final double? slider3Value;
}

class OnChangeValueSlider4 extends ColorDesignEvent {
  OnChangeValueSlider4({this.slider4Value});

  final double? slider4Value;
}

class OnAddColorName extends ColorDesignEvent {
  OnAddColorName({required this.colorName});

  final String colorName;
}

class OnAddNotes extends ColorDesignEvent {
  OnAddNotes({required this.colorNotes});

  final String colorNotes;
}

class OnPressedSave extends ColorDesignEvent {}
