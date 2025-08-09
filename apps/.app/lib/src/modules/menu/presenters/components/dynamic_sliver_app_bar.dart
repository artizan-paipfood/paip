import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DynamicSliverAppBar extends StatefulWidget {
  final Widget child;
  final double maxHeight;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final Widget? leading;

  const DynamicSliverAppBar({
    super.key,
    required this.child,
    this.maxHeight = 0.0,
    this.automaticallyImplyLeading = false,
    this.title,
    this.leading,
  });

  @override
  State<DynamicSliverAppBar> createState() => _DynamicSliverAppBarState();
}

class _DynamicSliverAppBarState extends State<DynamicSliverAppBar> {
  final GlobalKey _childKey = GlobalKey();
  bool isHeightCalculated = false;
  double? height;
  late final paddingTop = MediaQuery.paddingOf(context).top;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!isHeightCalculated) {
        isHeightCalculated = true;
        setState(() {
          height = (_childKey.currentContext!.findRenderObject() as RenderBox).size.height;
        });
      }
    });

    return SliverAppBar(
      pinned: true,
      floating: true,
      forceElevated: true,
      automaticallyImplyLeading: false,
      leading: widget.leading,
      title: widget.title,
      expandedHeight: isHeightCalculated ? (height ?? 0) - (kIsWeb ? 0 : paddingTop) : widget.maxHeight,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: SingleChildScrollView(
          child: Container(
            key: _childKey,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
