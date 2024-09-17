import 'dart:async';
import 'package:bloc_state/model/favourite_model/favourite_item_model.dart';

/// Repository class responsible for managing favorite items.
class FavouriteRepository {

  /// Simulates fetching favorite items from a data source.
  /// Returns a list of [FavouriteItemModel] after a delay.
  Future<List<FavouriteItemModel>> fetchItems() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    return List.of(_generateItemsList(10));
  }

  /// Generates a list of [FavouriteItemModel] with dummy data.
  List<FavouriteItemModel> _generateItemsList(int length) {
    return List.generate(
      length,
          (index) => FavouriteItemModel(id: '$index', value: 'Item $index'),
    );
  }

  /// Simulates deleting a favorite item by its [id].
  Future<void> deleteItem(String id) async {
    await Future<void>.delayed(const Duration(seconds: 2));
  }
}
