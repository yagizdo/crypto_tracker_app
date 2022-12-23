part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class CustomListNamesLoadedState extends FavoritesState {
  final List<String> customListNames;

  CustomListNamesLoadedState(this.customListNames);
}

class CustomListNamesLoadingState extends FavoritesState {}

class CustomListNamesEmptyState extends FavoritesState {}

class CustomListNamesErrorState extends FavoritesState {
  final String message;

  CustomListNamesErrorState(this.message);
}

class CustomListLoadingState extends FavoritesState {}

class CustomListLoadedState extends FavoritesState {
  final List<dynamic> customListItems;

  CustomListLoadedState(this.customListItems);
}

class CustomListErrorState extends FavoritesState {
  final String message;

  CustomListErrorState(this.message);
}

class CustomListEmptyState extends FavoritesState {}
