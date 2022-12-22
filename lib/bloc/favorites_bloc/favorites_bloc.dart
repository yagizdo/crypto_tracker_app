import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) {});
    on<GetFavoritesEvent>((event, emit) {});
    on<AddFavoriteEvent>((event, emit) {});
    on<DeleteFavoriteEvent>((event, emit) {});
  }
}
