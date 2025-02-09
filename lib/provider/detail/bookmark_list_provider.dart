import 'package:flutter/material.dart';
import 'package:restaurant_app_api/data/helper/database_helper.dart';
import 'package:restaurant_app_api/data/model/restaurant_detail_model.dart';
import 'package:restaurant_app_api/data/model/bookmark_model.dart';

class BookmarkListProvider extends ChangeNotifier {
  List<BookmarkModel> _bookmarkList = [];

  List<BookmarkModel> get bookmarkList => _bookmarkList;

  BookmarkListProvider() {
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    _bookmarkList = await DatabaseHelper.instance.getBookmarks();
    notifyListeners();
  }

  Future<void> addBookmark(RestaurantDetailModel restaurant) async {
    final bookmark = BookmarkModel(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      pictureId: restaurant.pictureId,
      city: restaurant.city,
      rating: restaurant.rating,
    );
    await DatabaseHelper.instance.insertBookmark(bookmark);
    _bookmarkList.add(bookmark);
    notifyListeners();
  }

  Future<void> removeBookmark(RestaurantDetailModel restaurant) async {
    await DatabaseHelper.instance.removeBookmark(restaurant.id);
    _bookmarkList.removeWhere((bookmark) => bookmark.id == restaurant.id);
    notifyListeners();
  }

  bool checkItemBookmark(RestaurantDetailModel restaurant) {
    return _bookmarkList.any((bookmark) => bookmark.id == restaurant.id);
  }
}
