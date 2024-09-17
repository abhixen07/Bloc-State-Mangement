import 'package:bloc/bloc.dart';
import 'package:bloc_state/bloc/favourite_app/favourite_app_event.dart';  // Importing events for Bloc.
import 'package:bloc_state/bloc/favourite_app/favourite_app_state.dart';  // Importing states for Bloc.
import 'package:bloc_state/model/favourite_model/favourite_item_model.dart';  // Importing the favourite item model.
import 'package:bloc_state/repository/favourite_repository.dart';  // Importing the repository for fetching items.

/// Bloc class to handle all favourite-related logic and state.
class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {

  // List of all favourite items.
  List<FavouriteItemModel> favouriteList = [];

  // Temporary list to manage selected items (e.g., for deletion).
  List<FavouriteItemModel> tempFavouriteList = [];

  // Repository to fetch and manage favourite items.
  FavouriteRepository favouriteRepository;

  /// Constructor to initialize the Bloc and define event handlers.
  FavouriteBloc(this.favouriteRepository) : super(const FavouriteState()) {
    on<FetchFavouriteList>(fetchFavouriteList);  // Handle fetching the list of favourite items.
    on<FavouriteItem>(_addFavourite);  // Handle adding or toggling a favourite item.
    on<DeleteItem>(deleteItem);  // Handle deleting selected items.
    on<SelectItem>(selectedItem);  // Handle selecting an item.
    on<UnSelectItem>(unSelectItem);  // Handle unselecting an item.
  }

  /// Handles the selection of an item.
  /// Adds the selected item to the temporary list and updates the state.
  void selectedItem(SelectItem events, Emitter<FavouriteState> emit) async {
    tempFavouriteList.add(events.item);
    emit(state.copyWith(tempFavouriteList: List.from(tempFavouriteList)));  // Emit new state with updated temp list.
  }

  /// Handles unselecting an item.
  /// Removes the item from the temporary list and updates the state.
  void unSelectItem(UnSelectItem events, Emitter<FavouriteState> emit) async {
    tempFavouriteList.remove(events.item);
    emit(state.copyWith(tempFavouriteList: List.from(tempFavouriteList)));  // Emit new state with updated temp list.
  }

  /// Fetches the list of favourite items from the repository.
  /// Emits either a success or failure state depending on the outcome.
  void fetchFavouriteList(FetchFavouriteList events, Emitter<FavouriteState> emit) async {
    print('Fetching favourite list...');
    try {
      favouriteList = await favouriteRepository.fetchItems();  // Fetch items from repository.
      print('Fetched list: ${favouriteList.length} items');
      emit(state.copyWith(
        favouriteList: List.from(favouriteList),
        listStatus: ListStatus.success,  // Update state to success after fetching.
      ));
      print('ListStatus: Success');
    } catch (error) {
      print('Error fetching list: $error');
      emit(state.copyWith(listStatus: ListStatus.failure));  // Update state to failure on error.
    }
  }

  /// Handles toggling a favourite item.
  /// Finds the item in the list, updates its state (favourite/unfavourite), and emits a new state.
  void _addFavourite(FavouriteItem events, Emitter<FavouriteState> emit) async {
    final personIndex = favouriteList.indexWhere((person) => person.id == events.item.id);

    if (events.item.isFavourite) {
      if (tempFavouriteList.contains(favouriteList[personIndex])) {
        tempFavouriteList.remove(favouriteList[personIndex]);
        tempFavouriteList.add(events.item);
      }
    } else {
      if (tempFavouriteList.contains(favouriteList[personIndex])) {
        tempFavouriteList.remove(favouriteList[personIndex]);
        tempFavouriteList.add(events.item);
      }
    }

    // Update the item in the favourite list and emit a new state.
    favouriteList[personIndex] = events.item;
    emit(state.copyWith(
      favouriteList: List.from(favouriteList),
      tempFavouriteList: List.from(tempFavouriteList),
    ));
  }

  /// Handles deleting selected items.
  /// Removes the items from the favourite list and clears the temporary list.
  void deleteItem(DeleteItem events, Emitter<FavouriteState> emit) async {
    for (int i = 0; i < tempFavouriteList.length; i++) {
      favouriteList.remove(tempFavouriteList[i]);
    }

    tempFavouriteList.clear();  // Clear the temporary list after deletion.

    // Emit a new state with updated favourite and temp lists.
    emit(
      state.copyWith(
        favouriteList: List.from(favouriteList),
        tempFavouriteList: List.from(tempFavouriteList),
      ),
    );
  }
}
