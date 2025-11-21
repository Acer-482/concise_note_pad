import 'package:flutter/material.dart';
// import 'package:flutter_icons_animated/flutter_animated_icons.dart';
// import 'package:flutter_icons_animated/icons8.dart';
// import 'package:lottie/lottie.dart';

/// 主页面
///
/// 用于导航用户、图标动画等
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _controller; // 动画控制器

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    ); // 创建动画控制
    _controller.forward(); // 开始播放
  }

  @override
  Widget build(BuildContext context) {
    return Center();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }
}
