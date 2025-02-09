import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/data/model/restaurant_detail_model.dart';
import 'package:restaurant_app_api/provider/detail/bookmark_icon_provider.dart';
import 'package:restaurant_app_api/provider/detail/bookmark_list_provider.dart';

class BookmarkIconWidget extends StatefulWidget {
  final RestaurantDetailModel restaurant;
  const BookmarkIconWidget({required this.restaurant, super.key});

  @override
  State<BookmarkIconWidget> createState() => _BookmarkIconWidgetState();
}

class _BookmarkIconWidgetState extends State<BookmarkIconWidget> {
  @override
  void initState() {
    final bookmarkListProvider = context.read<BookmarkListProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(() {
      final restaurantInList =
          bookmarkListProvider.checkItemBookmark(widget.restaurant);
      bookmarkIconProvider.isBookmarked = restaurantInList;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final bookmarkListProvider = context.read<BookmarkListProvider>();
        final bookmarkIconProvider = context.read<BookmarkIconProvider>();
        final isBookmarked = bookmarkIconProvider.isBookmarked;

        if (!isBookmarked) {
          bookmarkListProvider.addBookmark(widget.restaurant);
        } else {
          bookmarkListProvider.removeBookmark(widget.restaurant);
        }
        bookmarkIconProvider.isBookmarked = !isBookmarked;
      },
      icon: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}
