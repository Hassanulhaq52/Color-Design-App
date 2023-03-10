part of 'saved_color_bloc.dart';

abstract class SavedColorEvent {}

class OnLoadAtStart extends SavedColorEvent {}

class OnColorDeleted extends SavedColorEvent {}
