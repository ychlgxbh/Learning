import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:journey_page/journeyBlock.dart';
import 'package:journey_page/userData.dart';
import 'package:journey_page/userInfo.dart';

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
  Future response;
  var parsedData;
  var dotList;

  final _pagingController = PagingController<int, List<Dot>>(
    firstPageKey: 0,
  );

  Future<String> loadAsset() async {
    print('in loadasset');
    return await rootBundle.loadString('lib/asset/jsons/journeyMap.json');
  }

  getDotList() async {
    await response.then((value) {
      print(value.length);
      print(value);
      parsedData = userInfoFromJson(value);
      dotList = parsedData.dots.sublist(0, 24);
      if (dotList == null) {
        print('is null');
      }
      print('here');
      print(dotList.length.toString());
    });
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _fetchPage(pageKey);
      });
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      print('b4 load');
      response = loadAsset();
      print('after load');
      await getDotList();
      print(response.then((value) => null));
      List<List<Dot>> newItems = [];
      newItems.add(dotList);
      final isLastPage = _pageCount == widget._totalPages - 1;
      if (isLastPage) {
        print('reach last page');
        _pagingController.appendLastPage(newItems);
      } else {
        print('${_pageCount + 1}th page fetched');
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
        print('appended');
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
    // if(dotList == null){
    //   print('is null');
    // }
    return PagedListView(
      padding: EdgeInsets.zero,
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) =>
            new JourneyBlock(widget._bodyWidth, widget._bodyHeight, dotList),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
