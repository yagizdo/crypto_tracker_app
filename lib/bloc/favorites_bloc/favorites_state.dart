part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesUpdatedState extends FavoritesState {}

class FavoritesLoadingState extends FavoritesState {}

class FavoritesLoadedState extends FavoritesState {
  final List<dynamic> favorites;

  FavoritesLoadedState(this.favorites);
}

class FavoritesEmptyState extends FavoritesState {}

class FavoritesErrorState extends FavoritesState {
  final String message;

  FavoritesErrorState(this.message);
}

class CustomListNamesLoadedState extends FavoritesState {
  final List<String> customListNames;

  CustomListNamesLoadedState(this.customListNames);
}

class CustomListLoadingState extends FavoritesState {}

class CustomListNamesErrorState extends FavoritesState {
  final String message;

  CustomListNamesErrorState(this.message);
}
