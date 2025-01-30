import 'package:flutter/material.dart';

class LazyLoadedScreen extends StatefulWidget {
  final Widget Function() builder;
  final bool keepAlive;

  const LazyLoadedScreen({
    super.key,
    required this.builder,
    this.keepAlive = true,
  });

  @override
  State<LazyLoadedScreen> createState() => _LazyLoadedScreenState();
}

class _LazyLoadedScreenState extends State<LazyLoadedScreen>
    with AutomaticKeepAliveClientMixin {
  Widget? _child;

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _child ??= widget.builder();
    return _child!;
  }
}
