part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class CustomListNamesLoadedState extends FavoritesState {
  final List<String> customListNames;

  CustomListNamesLoadedState(this.customListNames);
}

class CustomListNamesLoadingState extends FavoritesState {}

class CustomListNamesErrorState extends FavoritesState {
  final String message;

  CustomListNamesErrorState(this.message);
}

class CustomListEmptyState extends FavoritesState {}
