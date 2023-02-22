part of 'color_design_bloc.dart';

abstract class ColorDesignEvent {}

class OnChangeRedColorValue extends ColorDesignEvent {
  OnChangeRedColorValue({required this.redColorValue});

  final double redColorValue;
}

class OnChangeGreenColorValue extends ColorDesignEvent {
  OnChangeGreenColorValue({required this.greenColorValue});

  final double greenColorValue;
}

class OnChangeBlueColorValue extends ColorDesignEvent {
  OnChangeBlueColorValue({required this.blueColorValue});

  final double blueColorValue;
}

class OnChangeOpacityValue extends ColorDesignEvent {
  OnChangeOpacityValue({required this.opacityValue});

  final double opacityValue;
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

class OnLoadAtStart extends ColorDesignEvent {
  //
  // OnLoadAtStart({required this.onLoadColors});
  // final List<dynamic> onLoadColors;

}

class OnLoadColors extends ColorDesignEvent {



}
