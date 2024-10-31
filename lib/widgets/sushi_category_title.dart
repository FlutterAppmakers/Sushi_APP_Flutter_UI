import 'package:flutter/material.dart';

const headerExtent = 80.0;
typedef OnHeaderChange = void Function(bool isVisible);
class SushiCategoryTitle extends SliverPersistentHeaderDelegate {
  final String title;
  final OnHeaderChange onHeaderChange;

  SushiCategoryTitle({
    required this.title,
    required this.onHeaderChange,
  }
  );

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    if(shrinkOffset > 0) {
      onHeaderChange(true);
    } else {
      onHeaderChange(false);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
          )
          ,),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => headerExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => headerExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }

}


