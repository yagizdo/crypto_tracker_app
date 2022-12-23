part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class GetFavoritesEvent extends FavoritesEvent {}

class GetCustomListNamesEvent extends FavoritesEvent {}

class AddCustomListEvent extends FavoritesEvent {
  final String listName;
  AddCustomListEvent(this.listName);
}

class DeleteCustomListEvent extends FavoritesEvent {
  final String listName;
  DeleteCustomListEvent(this.listName);
}

class AddItemToCustomListEvent extends FavoritesEvent {
  final String itemName;
  final String listName;
  AddItemToCustomListEvent(this.itemName, this.listName);
}

class DeleteItemFromCustomListEvent extends FavoritesEvent {
  final String itemName;
  final String listName;
  DeleteItemFromCustomListEvent(this.itemName, this.listName);
}

class GetCustomListEvent extends FavoritesEvent {
  final String listName;
  GetCustomListEvent(this.listName);
}