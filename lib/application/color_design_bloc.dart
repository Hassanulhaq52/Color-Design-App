import 'package:bloc/bloc.dart';

part 'color_design_event.dart';
part 'color_design_state.dart';

class ColorDesignBloc extends Bloc<ColorDesignEvent, ColorDesignState> {
  ColorDesignBloc() : super(ColorDesignState.initial()) {
    on<OnChangeValueSlider1>((event, emit) {
      emit(state.copyWith(slider1Value: event.slider1Value));
    });
    on<OnChangeValueSlider2>((event, emit) {
      emit(state.copyWith(slider2Value: event.slider2Value));
    });
    on<OnChangeValueSlider3>((event, emit) {
      emit(state.copyWith(slider3Value: event.slider3Value));
    });
    on<OnChangeValueSlider4>((event, emit) {
      emit(state.copyWith(slider4Value: event.slider4Value));
    });
    on<OnAddColorName>((event, emit) {
      emit(state.copyWith(colorName: event.colorName));
    });
    on<OnAddNotes>((event, emit) {
      emit(state.copyWith(colorName: event.colorNotes));
    });
  }
}
