import 'package:bloc_state/bloc/favourite_app/favourite_app_bloc.dart'; // Importing the bloc responsible for handling favorite app logic.
import 'package:bloc_state/bloc/favourite_app/favourite_app_event.dart'; // Importing events for the favorite app bloc.
import 'package:bloc_state/bloc/favourite_app/favourite_app_state.dart'; // Importing states for the favorite app bloc.
import 'package:flutter/material.dart'; // Importing material design for Flutter UI components.
import 'package:flutter_bloc/flutter_bloc.dart'; // Importing flutter_bloc to use BlocBuilder and context for bloc.

/// Stateless widget that represents a delete button.
/// This button is visible when there are items in the temporary favorite list,
/// and it triggers the delete event when pressed.
class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      // Only rebuilds when tempFavouriteList in the state changes.
      buildWhen: (previous, current) => previous.tempFavouriteList != current.tempFavouriteList,
      builder: (context, state) {
        return Visibility(
          // Button visibility is based on whether tempFavouriteList is not empty.
          visible: state.tempFavouriteList.isNotEmpty ? true : false,
          child: IconButton(
            // When pressed, triggers the DeleteItem event to delete items from the tempFavoriteList.
            onPressed: () {
              context.read<FavouriteBloc>().add(DeleteItem());
            },
            icon: const Icon(Icons.delete_outline, color: Colors.red), // Red trash icon to represent delete action.
          ),
        );
      },
    );
  }
}
