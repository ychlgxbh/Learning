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
  bool _hasReachedCurrentLock = false;
  bool _moreCheck = true;
  int _changeOpacityPosition = 0;
  List<List<Dot>> availableDotList = [];
  List<String> _bodyTextList = [];
  List<List<String>> partitionedBodyText = [];

  final _pagingController = PagingController<int, List<Dot>>(
    firstPageKey: 0,
    invisibleItemsThreshold: 1,
  );

  void getDotList() {
    int index = 0;
    while (true) {
      if (index + 12 < widget.allDots.length) {
        // print(availableDotList.length.toString());
        availableDotList.add(widget.allDots.sublist(index, index + 12));
        //  print(availableDotList.length.toString());
      } else {
        availableDotList
            .add(widget.allDots.sublist(index, widget.allDots.length));
        break;
      }
      index += 12;
    }
    //print('total dotList:');
   // print(availableDotList.length.toString());
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.allDots.length; i++) {
      widget.allDots[i].sequenceNum = i;
      widget.allDots[i].isDummy = false;
      if (widget.allDots[i].body != null) {
        _bodyTextList.add(widget.allDots[i].body);
      }
      if (widget.allDots[i].status == Status.CURRENT_LOCK) {
        _hasReachedCurrentLock = true;
      }
      if (_hasReachedCurrentLock &&
          widget.allDots[i].dotType != Type.DAILY &&
          _moreCheck) {
        _changeOpacityPosition = i;
        _moreCheck = false;
      }
    }
    // add dummy dots to make allDots.length % 12 == 0
    int _originalLength = widget.allDots.length;
    int count = 0;
   // print('total dots without dummy: $_originalLength');
    if (widget.allDots.length % 12 != 0) {
      for (int i = 0; i < 12 - _originalLength % 12; i++,count++) {
        widget.allDots.add(
          new Dot(status: Status.FAIL, sequenceNum: _originalLength + i, dotType: Type.DAILY, isDummy: true,),
        );
      }
     // print('total dots with dummy: ${widget.allDots.length}');
    //  print('$count new dots added');
    }
    for (var i = 0; i < _bodyTextList.length; i += 2) {
      var end = (i + 2 < _bodyTextList.length ? i + 2 : _bodyTextList.length);
      partitionedBodyText.add(
        _bodyTextList.sublist(i, end),
      );
    }
    getDotList();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
      // SchedulerBinding.instance.addPostFrameCallback((_) {
      //   _fetchPage(pageKey);
      // });
    });
  }

  List<List<Dot>> toBePassed = [];
  Future<void> _fetchPage(int pageKey) async {
  //  print('fetching');
    try {
      List<List<Dot>> newItems = [];
      if (_pageCount < availableDotList.length) {
        newItems.add(availableDotList[_pageCount]);
        toBePassed = newItems;
      }
    //  print('newItems now have ${newItems.length} items');
      final isLastPage = _pageCount == availableDotList.length - 1;
      if (isLastPage) {
    //    print('reach last page');
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _pagingController.appendLastPage(newItems);
        });
      } else {
       // print('${_pageCount + 1}th page fetched');
        final nextPageKey = pageKey + 1;

        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _pagingController.appendPage(newItems, nextPageKey);
        });
     //   print('appended');
        _pageCount++;
    //   print('current pageCount: $_pageCount');
      }
    } catch (error) {
      print('Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror');
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (availableDotList.length != 0) {
     // print('build page items');
      // if(dotList == null){
      //   print('is null');
      // }
      return PagedListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) => JourneyBlock(
            widget._bodyWidth,
            widget._bodyHeight,
            item,
            index,
            _changeOpacityPosition,
            index > partitionedBodyText.length
                ? null
                : partitionedBodyText[index],
          ),
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
