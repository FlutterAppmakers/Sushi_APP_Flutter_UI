import 'package:flutter/material.dart';
import 'package:sliver_sync_tabs/models/models.dart';
import 'package:sliver_sync_tabs/widgets/get_box_offset.dart';

import '../controller/controller.dart';

class SushiListHeader extends StatelessWidget {
  const SushiListHeader({super.key, required this.bloc});
  final SliverScrollController bloc;

  @override
  Widget build(BuildContext context) {
    final itemsOffset = bloc.listOffsetItemHeader;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) => true,
        child: SingleChildScrollView(
            controller: bloc.scrollControllerItemHeader,
            padding:  EdgeInsets.only(right:
                size.width - (itemsOffset[itemsOffset.length -1] - itemsOffset[itemsOffset.length -2])
            ),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: ValueListenableBuilder(
              valueListenable: bloc.headerNotifier,
              builder: (context, MyHeader? header, _) {
                return Row(
                  children: List.generate(
                      bloc.sushiCategory.length,
                          (index) {
                        return GetBoxOffset(
                          offset: (Offset boxOffset) {
                               return itemsOffset[index] = boxOffset.dx;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 8.0,
                              right: 8.0,
                              bottom: 16.0,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: (index == header!.index) ? Colors.white : Colors.black,
                                  borderRadius: BorderRadius.circular(16.0)
                            ),
                            alignment: Alignment.center,
                              child: Text(
                                bloc.sushiCategory[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: (index == header.index) ? Colors.black : Colors.white
                                ),
                              ),
                            ),
                        );
                          }
                  ),
                );
              }
            ),
          ),
      ),
    );
  }
}
