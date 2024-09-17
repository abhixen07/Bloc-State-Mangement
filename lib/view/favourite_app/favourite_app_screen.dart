import 'package:bloc_state/bloc/favourite_app/favourite_app_bloc.dart'; // Importing the FavouriteBloc to manage state.
import 'package:bloc_state/bloc/favourite_app/favourite_app_event.dart'; // Importing events for the FavouriteBloc.
import 'package:bloc_state/bloc/favourite_app/favourite_app_state.dart'; // Importing states for the FavouriteBloc.
import 'package:bloc_state/model/favourite_model/favourite_item_model.dart'; // Importing the FavouriteItemModel to handle favorite item data.
import 'package:bloc_state/view/favourite_app/widget/delete_button_widget.dart'; // Importing DeleteButtonWidget for the delete action.
import 'package:flutter/material.dart'; // Importing material design components.
import 'package:flutter_bloc/flutter_bloc.dart'; // Importing flutter_bloc to use BlocBuilder and context for bloc interactions.

/// FavouriteScreen is a stateful widget that displays the list of favorite items.
/// The items can be selected and marked as favorite or not, and deleted through a DeleteButtonWidget.
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  @override
  void initState() {
    super.initState();
    // Dispatching an event to fetch the favorite list when the screen initializes.
    context.read<FavouriteBloc>().add(FetchFavouriteList());
    print('FetchFavouriteList event dispatched');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite App'), // Title of the screen.
        actions: const [
          // Delete button widget that appears in the app bar for deleting selected items.
          DeleteButtonWidget(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
          // Building the UI based on the current state of FavouriteBloc.
          builder: (BuildContext context, state) {
            switch (state.listStatus) {
              case ListStatus.loading:
              // Display a loading indicator when the list is being fetched.
                return const Center(child: CircularProgressIndicator());
              case ListStatus.failure:
              // Display an error message if fetching the list fails.
                return const Center(child: Text('Something Went Wrong'));
              case ListStatus.success:
              // If the list is fetched successfully, display it in a ListView.
                return ListView.builder(
                  itemCount: state.favouriteList.length, // Number of items in the list.
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        // Leading checkbox to select/unselect an item.
                        leading: Checkbox(
                          value: state.tempFavouriteList.contains(state.favouriteList[index]) ? true : false,
                          onChanged: (bool? value) {
                            FavouriteItemModel item = state.favouriteList[index];
                            // Dispatch event to select/unselect the item.
                            if (value!) {
                              context.read<FavouriteBloc>().add(SelectItem(item: item));
                            } else {
                              context.read<FavouriteBloc>().add(UnSelectItem(item: item));
                            }
                          },
                        ),
                        // Displaying the item value and applying strikethrough and color changes for selected items.
                        title: Text(
                          state.favouriteList[index].value,
                          style: TextStyle(
                            decoration: state.tempFavouriteList.contains(state.favouriteList[index])
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: state.tempFavouriteList.contains(state.favouriteList[index])
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                        // Trailing favorite icon to toggle the favorite status of the item.
                        trailing: IconButton(
                          onPressed: () {
                            FavouriteItemModel item = state.favouriteList[index];
                            // Dispatch event to mark/unmark the item as a favorite.
                            context.read<FavouriteBloc>().add(
                              FavouriteItem(
                                item: FavouriteItemModel(
                                  id: item.id,
                                  isFavourite: item.isFavourite ? false : true,
                                  value: item.value,
                                ),
                              ),
                            );
                          },
                          // Displaying either a filled or outlined heart based on the item's favorite status.
                          icon: Icon(
                            state.favouriteList[index].isFavourite ? Icons.favorite : Icons.favorite_outline,
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
