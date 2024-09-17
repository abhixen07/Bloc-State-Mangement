import 'package:bloc_state/model/favourite_model/favourite_item_model.dart'; // Importing the model for favourite items.
import 'package:equatable/equatable.dart'; // Importing Equatable to make state comparison easier.

/// Enum to define the status of the list fetching process.
enum ListStatus { loading, success, failure }

/// FavouriteState manages the state of the favourite list.
/// It uses Equatable to make it easy to compare states for Bloc rebuilds.
class FavouriteState extends Equatable {

  // The list of favourite items.
  final List<FavouriteItemModel> favouriteList;
  // A temporary list to hold selected items for deletion.
  final List<FavouriteItemModel> tempFavouriteList;
  // The status of the list (loading, success, failure).
  final ListStatus listStatus;

  /// Constructor with default values:
  /// - favouriteList defaults to an empty list.
  /// - listStatus defaults to `ListStatus.loading`.
  /// - tempFavouriteList defaults to an empty list.
  const FavouriteState({
    this.favouriteList = const [],
    this.listStatus = ListStatus.loading,
    this.tempFavouriteList = const [],
  });

  /// Method to create a copy of the current state with updated values.
  /// If new values are provided, they are used; otherwise, the current state's values are kept.
  FavouriteState copyWith({
    List<FavouriteItemModel>? favouriteList,
    ListStatus? listStatus,
    List<FavouriteItemModel>? tempFavouriteList,
  }) {
    return FavouriteState(
      favouriteList: favouriteList ?? this.favouriteList,
      listStatus: listStatus ?? this.listStatus,
      tempFavouriteList: tempFavouriteList ?? this.tempFavouriteList,
    );
  }

  @override
  // List of properties used by Equatable for comparison.
  List<Object?> get props => [favouriteList, listStatus, tempFavouriteList];
}
