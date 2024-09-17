import 'package:equatable/equatable.dart'; // Importing Equatable for efficient comparison of model instances.

/// Model class for a favorite item.
class FavouriteItemModel extends Equatable {
  const FavouriteItemModel({
    required this.id,      // Unique identifier for the item.
    required this.value,   // The display value or name of the item.
    this.isDeleting = false, // Boolean to track if the item is in a deleting state.
    this.isFavourite = false, // Boolean to indicate if the item is marked as favorite.
  });

  final String id;          // Item's unique ID.
  final String value;       // Item's value (name or label).
  final bool isDeleting;    // Flag indicating whether the item is being deleted.
  final bool isFavourite;   // Flag indicating whether the item is marked as a favorite.

  /// Creates a copy of the current item with updated values. If a value isn't provided,
  /// it keeps the current value of that property.
  FavouriteItemModel copyWith({
    String? id,
    String? value,
    bool? isDeleting,
    bool? isFavourite,
  }) {
    return FavouriteItemModel(
      id: id ?? this.id,  // Use new id if provided, otherwise keep the existing id.
      value: value ?? this.value, // Use new value if provided, otherwise keep the existing value.
      isDeleting: isDeleting ?? this.isDeleting, // Use new isDeleting status if provided.
      isFavourite: isFavourite ?? this.isFavourite, // Use new isFavourite status if provided.
    );
  }

  @override
  // List of properties that Equatable will use to compare instances.
  List<Object> get props => [id, value, isDeleting, isFavourite];
}
