import 'package:bloc_state/model/favourite_model/favourite_item_model.dart';
import 'package:equatable/equatable.dart';

/// Base class for all Favourite Events.
/// Extends [Equatable] to allow for comparison of different events.
abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch the list of favourite items.
/// This event is triggered when the app needs to load the list from the repository.
class FetchFavouriteList extends FavouriteEvent {}

/// Event to toggle or update a favourite item.
/// [item] is the specific item that is being toggled (favourited or unfavourited).
class FavouriteItem extends FavouriteEvent {
  final FavouriteItemModel item;

  /// Constructor that accepts the [FavouriteItemModel] object.
  FavouriteItem({required this.item});

  @override
  List<Object?> get props => [item];  // Ensure comparison is based on the item.
}

/// Event to select an item, usually for deletion or marking it for further actions.
/// [item] is the selected favourite item.
class SelectItem extends FavouriteEvent {
  final FavouriteItemModel item;

  /// Constructor that accepts the [FavouriteItemModel] object.
  SelectItem({required this.item});

  @override
  List<Object?> get props => [item];  // Ensure comparison is based on the item.
}

/// Event to unselect an item, i.e., remove it from the selected items.
/// [item] is the unselected favourite item.
class UnSelectItem extends FavouriteEvent {
  final FavouriteItemModel item;

  /// Constructor that accepts the [FavouriteItemModel] object.
  UnSelectItem({required this.item});

  @override
  List<Object?> get props => [item];  // Ensure comparison is based on the item.
}

/// Event to delete selected favourite items.
/// This event is triggered when the user wants to delete items from the list.
class DeleteItem extends FavouriteEvent {}
