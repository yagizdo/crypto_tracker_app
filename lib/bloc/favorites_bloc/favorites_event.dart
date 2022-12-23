part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {}

class GetFavoritesEvent extends FavoritesEvent {}

class AddFavoriteEvent extends FavoritesEvent {
  final String itemName;
  AddFavoriteEvent(this.itemName);

}

class DeleteFavoriteEvent extends FavoritesEvent {
  final String itemName;

  DeleteFavoriteEvent(this.itemName);
}

class GetCustomListNamesEvent extends FavoritesEvent {}