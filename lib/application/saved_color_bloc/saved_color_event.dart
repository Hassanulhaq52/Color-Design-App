part of 'saved_color_bloc.dart';

abstract class SavedColorEvent {}

class OnLoadAtStart extends SavedColorEvent {}

class OnColorDeleted extends SavedColorEvent {

  OnColorDeleted({required this.index});

  final int index;

}

// class OnRemoveColor extends SavedColorEvent {
//   OnRemoveColor({required this.index});
//
//   final int index;
// }
