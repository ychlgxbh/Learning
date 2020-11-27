import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:journey_page/journeyBlock.dart';
import 'package:journey_page/userData.dart';

class BlockListView extends StatefulWidget {
  final double _bodyWidth;
  final double _bodyHeight;
  final int _totalPages;

  BlockListView(this._bodyWidth, this._bodyHeight, this._totalPages);
  @override
  _BlockListViewState createState() => _BlockListViewState();
}

class _BlockListViewState extends State<BlockListView> {
  static const _pageSize = 1;
  int _pageCount = 0;

  final List<UserData> userDataPart1 = [new UserData(6)];
  final List<UserData> userDataPart2 = [new UserData(12)];
  final _pagingController = PagingController<int, UserData>(
    firstPageKey: 0,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<UserData> newItems = [];
      if (_pageCount == 0) {
        newItems = userDataPart1;
      } else {
        newItems = userDataPart2;
      }

      final isLastPage = _pageCount == widget._totalPages - 1;
      if (isLastPage) {
        print('reach last page');
        _pagingController.appendLastPage(newItems);
      } else {
        print('${_pageCount + 1}th page fetched');
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
        _pageCount++;
      }
    } catch (error) {
      print('Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror');
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        // 2
        () => _pagingController.refresh(),
      ),
      child: PagedListView(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<UserData>(
          itemBuilder: (context, item, index) => new JourneyBlock(
              widget._bodyWidth, widget._bodyHeight, item.numberOfSegment),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
