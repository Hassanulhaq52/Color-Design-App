part of 'saved_color_bloc.dart';

abstract class SavedColorEvent {}

class OnSaveColor extends SavedColorEvent {}

class OnPressedSaved extends SavedColorEvent {}

class OnLoadAtStart extends SavedColorEvent {}
