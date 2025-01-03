import 'package:flutter/material.dart';

class GetBoxOffset extends StatefulWidget {
  const GetBoxOffset({super.key, required this.child, required this.offset});
  final Widget child;
  final Function(Offset offset) offset;

  @override
  State<GetBoxOffset> createState() => _GetBoxOffsetState();
}

class _GetBoxOffsetState extends State<GetBoxOffset> {
  GlobalKey widgetKey = GlobalKey();
  late Offset offset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = widgetKey.currentContext?.findRenderObject() as RenderBox;
      offset = box.localToGlobal(Offset.zero);
      widget.offset(offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      key: widgetKey,
      child: widget.child,
    );
  }
}
