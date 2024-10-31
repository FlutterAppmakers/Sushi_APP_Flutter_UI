import 'package:flutter/material.dart';
import 'package:sliver_sync_tabs/controller/controller.dart';
import 'package:sliver_sync_tabs/widgets/sushi_list_header.dart';
import 'package:sliver_sync_tabs/widgets/widgets.dart';


class HomeSliverWithSyncTabs extends StatefulWidget {
  const HomeSliverWithSyncTabs({super.key});

  @override
  State<HomeSliverWithSyncTabs> createState() => _HomeSliverWithSyncTabsState();
}

class _HomeSliverWithSyncTabsState extends State<HomeSliverWithSyncTabs> {
  final bloc = SliverScrollController();

  @override
  void initState() {
    // TODO: implement initState
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Scrollbar(
            controller: bloc.scrollControllerGlobal,
            radius: const Radius.circular(16.0),
            notificationPredicate: (scroll) {
              bloc.valueScroll.value = scroll.metrics.extentInside;
              return true;
            },
            child: ValueListenableBuilder(
                valueListenable: bloc.globalOffsetValue,
                builder: (_, currentValueScroll, __) {
                  return CustomScrollView(
                    controller: bloc.scrollControllerGlobal,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SushiHeader(valueScroll: currentValueScroll, bloc: bloc,),
                      SliverPersistentHeader(
                          pinned: true,
                          delegate: _SushiHeaderSliver(bloc: bloc)),
                      for(var i = 0; i < bloc.sushiCategory.length; i++) ...[
                        SliverPersistentHeader(delegate:
                        SushiCategoryTitle(
                          title: bloc.sushiCategory[i].name,
                          onHeaderChange: (isVisible) =>
                              bloc.refreshHeader(i,
                                isVisible,
                                lastIndex: i > 0 ? i - 1 : null,
                              ),
                        ),
                        ),
                        SushiProducts(products: bloc.sushiCategory[i].products),
                      ]
                    ],
                  );
                }
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.dispose();
    super.dispose();
  }
}
class SushiHeader extends StatelessWidget {
  const SushiHeader({
    super.key,
    required this.valueScroll,
    required this.bloc,
  });

  final double valueScroll;
  final SliverScrollController bloc;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -AppBar().preferredSize.height
    - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
        return SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          stretch: true,
          pinned: valueScroll < 90.0 ? true: false,

          expandedHeight: 250,
          flexibleSpace:   FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            stretchModes: const [StretchMode.zoomBackground],
            background: Stack(
              fit: StackFit.expand,
              children: [
                const SushiBackground(),
                Positioned(
                  top: height - bloc.valueScroll.value ,
                  right: 20,
                  child:
                    const Icon(Icons.favorite, size: 30),

                ),
                 Positioned(
                  top: height - bloc.valueScroll.value,
                  left: 20,
                  child:
                 const Icon(Icons.arrow_back, size: 30),

                ),
              ],
            ),
          ),
        );
  }
}

const _maxHeaderExtent = 110.0;
class _SushiHeaderSliver extends SliverPersistentHeaderDelegate {
  final SliverScrollController bloc;
  _SushiHeaderSliver({required this.bloc});


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    final percent = shrinkOffset / _maxHeaderExtent;
    if(percent > 0.1) {
      bloc.visibleHeader.value = true;
    } else {
      bloc.visibleHeader.value = false;
    }
    return Stack(
      children: [
        Positioned(
          bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: _maxHeaderExtent,
              color: Colors.black,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                        children: [
                          AnimatedOpacity(
                            opacity: percent > 0.1 ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: const Icon(Icons.arrow_back)),
                          const SizedBox(width: 10.0,),
                          AnimatedSlide(
                            duration: const Duration(milliseconds: 300),
                            offset: Offset((percent < 0.1 ? -0.18 : 0.1 ), 0.0),
                            curve: Curves.easeIn,
                            child: const Text('Category Of Sushi',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ),
                        ],
                      ),

                  ),
                  const SizedBox(height: 6.0,),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                        child: percent > 0.1 ? SushiListHeader(bloc: bloc) :  const SushiHeaderData()
                             ),
                  ),

                ],
              ),

        )),
        if (percent > 0.1)
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: (percent > 0.1) ? Container(
                  height: 0.5,
                  color: Colors.white10,
                ) : null,
              ),
          ),

      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _maxHeaderExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => _maxHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }

}


