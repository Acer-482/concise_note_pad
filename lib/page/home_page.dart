import 'package:flutter/material.dart';

/// 主页面
///
/// 用于导航用户、图标动画等
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      // child: Lottie.asset(Icons8.book)
    );
  }
}
