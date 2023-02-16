import 'package:bloc/bloc.dart';

import '../model/color_design_model.dart';

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
      emit(state.copyWith(colorNotes: event.colorNotes));
    });
    // on<OnPressedSave>((event, emit) {
    //   state.copyWith(
    //
    //     colorDesignModel: state.colorDesignModel..add(ColorDesignModel(
    //         colorName: state.colorName,
    //         colorNotes: state.colorNotes,
    //         red: state.slider1Value,
    //         green: state.slider2Value,
    //         blue: state.slider3Value,
    //         opacity: state.slider4Value)));
    //
    //
    //   // final List<ColorDesignModel> updatedList = [
    //   //   ...state.colorDesignModel,
    //   // ];
    //   //
    //   // updatedList.add(ColorDesignModel(
    //   //     colorName: state.colorName,
    //   //     colorNotes: state.colorNotes,
    //   //     red: state.slider1Value,
    //   //     green: state.slider2Value,
    //   //     blue: state.slider3Value,
    //   //     opacity: state.slider4Value));
    //   //
    //   // emit(
    //   //   state.copyWith(
    //   //     colorDesignModel: updatedList,
    //   //     colorName: '',
    //   //     colorNotes: '',
    //   //     slider1Value: 0.0,
    //   //     slider2Value: 0.0,
    //   //     slider3Value: 0.0,
    //   //     slider4Value: 0.0,
    //   //   ),
    //   // );
    //
    //
    //
    // });

    on<OnPressedSave>((event, emit) {
      emit(
        state.copyWith(
            colorDesignModel: state.colorDesignModel
              ..add(ColorDesignModel(
                colorName: state.colorName,
                colorNotes: state.colorNotes,
                red: state.slider1Value,
                green: state.slider2Value,
                blue: state.slider3Value,
                opacity: state.slider4Value,
              ))

            // state.colorDesignModel.toList()
            //   ..add(
            //     ColorDesignModel(
            //       colorName: state.colorName,
            //       colorNotes: state.colorNotes,
            //       red: state.slider1Value,
            //       green: state.slider2Value,
            //       blue: state.slider3Value,
            //       opacity: state.slider4Value,
            //     ),
            //   ),
            ),
      );
    });

    // on<OnPressedSave>((event, emit) {
    //   emit(state.copyWith(
    //     colorDesignModel: [
    //       ...state.colorDesignModel,
    //       ColorDesignModel(
    //         colorName: event.colorName,
    //         colorNotes: event.colorNotes,
    //         red: event.slider1Value,
    //         green: event.slider2Value,
    //         blue: event.slider3Value,
    //         opacity: event.slider4Value,
    //       ),
    //     ],
    //   ));
    // });
  }
}
