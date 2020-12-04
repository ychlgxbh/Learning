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
  List<Dot> allDots = [];

  BlockListView(
    this._bodyWidth,
    this._bodyHeight,
    this.allDots,
  );
  @override
  _BlockListViewState createState() => _BlockListViewState();
}

class _BlockListViewState extends State<BlockListView> {
  static const _pageSize = 1;
  int _pageCount = 0;
  Future response;
  var parsedData;
  var dotList;
  var dotList2;
  List<List<Dot>> availableDotList = [];

  final _pagingController = PagingController<int, List<Dot>>(
    firstPageKey: 0,
  );

  // Future<String> loadAsset() async {
  //   print('in loadasset');
  //   return await rootBundle.loadString('lib/asset/jsons/journeyMap.json');
  // }

  void getDotList() {
    int index = 0;
    while (true) {
      if (index + 13 < widget.allDots.length) {
       // print(availableDotList.length.toString());
        availableDotList.add(widget.allDots.sublist(index, index + 13));
      //  print(availableDotList.length.toString());
      } else {
        availableDotList
            .add(widget.allDots.sublist(index, widget.allDots.length - 1));
        break;
      }
      index += 12;
    }
    print('total dotList:');
    print(availableDotList.length.toString());
  }

  @override
  void initState() {
    super.initState();
    getDotList();
    _pagingController.addPageRequestListener((pageKey) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _fetchPage(pageKey);
      });
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<List<Dot>> newItems = [];
      if (_pageCount < availableDotList.length) {
        newItems.add(availableDotList[_pageCount]);
      }
      print('newItems now have ${newItems.length} items');
      final isLastPage = _pageCount == availableDotList.length - 1;
      if (isLastPage) {
        print('reach last page');
        _pagingController.appendLastPage(newItems);
      } else {
        print('${_pageCount + 1}th page fetched');
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
        print('appended');
        _pageCount++;
        print('current pageCount: $_pageCount');
      }
    } catch (error) {
      print('Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror');
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (availableDotList.length != 0) {
      print('build');
      // if(dotList == null){
      //   print('is null');
      // }
      return PagedListView(
        padding: EdgeInsets.zero,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) =>
              new JourneyBlock(widget._bodyWidth, widget._bodyHeight, item),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
