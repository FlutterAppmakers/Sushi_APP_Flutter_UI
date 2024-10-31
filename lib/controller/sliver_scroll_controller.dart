
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import '../data/sushi_data.dart';
import '../models/models.dart';

class SliverScrollController {
  late List<ProductCategory> sushiCategory;
  List<double> listOffsetItemHeader = [];
  // global offset value of scroll
  final globalOffsetValue = ValueNotifier<double>(0);
  final valueScroll = ValueNotifier<double>(0);
  late ScrollController scrollControllerGlobal;
  // header Notifier
  final headerNotifier = ValueNotifier<MyHeader?>(null);
  late ScrollController scrollControllerItemHeader;
  // value that indicates if the header is visible
  final visibleHeader = ValueNotifier(false);
  // value that indicates if we are scrolling down or up in the application
  final scrollingDown = ValueNotifier<bool>(false);



  void init() {
    loadSushiData();
    listOffsetItemHeader = List.generate(sushiCategory.length, (index) => index.toDouble());
    scrollControllerGlobal = ScrollController();
    scrollControllerItemHeader = ScrollController();
    scrollControllerGlobal.addListener(_listenToScrollChange);
    headerNotifier.addListener(_listenToHeaderChange);
    visibleHeader.addListener(_listenVisibleHeader);
  }

  void _listenVisibleHeader() {
    if(visibleHeader.value) {
      headerNotifier.value = const MyHeader(index: 0, visible: false);
    }
  }

  void _listenToScrollChange() {
    globalOffsetValue.value = scrollControllerGlobal.offset;
    if(scrollControllerGlobal.position.userScrollDirection == ScrollDirection.reverse){
      scrollingDown.value = true;
    } else {
      scrollingDown.value = false;
    }
  }

  void _listenToHeaderChange() {
    if(visibleHeader.value) {
      for(var i =0 ; i < sushiCategory.length ; i++){
        animateHeaderScroll(index: i);
      }
    }
  }
  void animateHeaderScroll({required int index}) {
    if(headerNotifier.value?.index == index && headerNotifier.value!.visible){
      scrollControllerItemHeader.animateTo(
          listOffsetItemHeader[headerNotifier.value!.index] - listOffsetItemHeader[0],
          duration: const Duration(milliseconds: 500),
          curve: scrollingDown.value ? Curves.bounceOut : Curves.easeInOut,
      );
    }
  }

  void refreshHeader(
      int index,
      bool visible, {
        int? lastIndex,
      }) {
    final headerValue = headerNotifier.value;
    final headerIndex = headerValue?.index ?? index;
    final headerVisible = headerValue?.visible ?? false;

    if (headerIndex != index || lastIndex != null || headerVisible != visible) {
      Future.microtask(
            () {
          if (!visible && lastIndex != null) {
            headerNotifier.value = MyHeader(
              visible: true,
              index: lastIndex,
            );
          } else {
            headerNotifier.value = MyHeader(
              visible: visible,
              index: index,
            );
          }
        },
      );
    }
  }

  void dispose() {
    scrollControllerGlobal.removeListener(_listenToScrollChange);
    scrollControllerGlobal.dispose();
    scrollControllerItemHeader.dispose();
  }

  void loadSushiData() {
     sushiCategory = [
      ProductCategory(
        name: 'Uramaki',
        products: uramakiProducts,
      ),
      ProductCategory(
        name: 'Sashimi',
        products: sashimiProducts,
      ),
      ProductCategory(
        name: 'Nigiri',
        products: nigiriProducts,
      ),

      ProductCategory(
        name: 'Temakizushi',
        products: temakizushiProducts,
      ),

      ProductCategory(
          name: 'Futomaki',
          products: futomakiproducts
      )

    ];
  }
}