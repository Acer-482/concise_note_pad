import 'package:concise_note_pad/page_utils.dart';
import 'package:concise_note_pad/task_pages/task_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_icons_animated/flutter_animated_icons.dart';
// import 'package:lottie/lottie.dart';

/// 页面类
/// 用于构建导航和页面
class _Page {
  _Page({
    required this.icon,
    this.activeIcon,
    required this.label,
    required this.body,
  });

  Icon icon;
  Icon? activeIcon;
  String label;
  Widget body;
}

/// 主页面
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<_Page> pageList = [
    _Page(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: '主页面',
      body: Container(
        color: Colors.white,
        // child: Lottie.asset(Icons8.book)
      ),
    ),
    _Page(
      icon: Icon(Icons.format_list_bulleted),
      label: '任务',
      body: const TaskPage(),
    ),
  ]; // 页面列表
  int pageIndex = 0; // 页面索引
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageUtils.buildDefaultAppbar(
        context,
        const Text('简记', textAlign: TextAlign.center),
      ),
      body: PageView(
        controller: controller,
        children: pageList.map((page) => page.body).toList(),
        onPageChanged: (value) {
          setState(() {
            pageIndex = value;
          });
        }, // 页面浏览器
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        items: pageList
            .map(
              (page) => BottomNavigationBarItem(
                icon: page.icon,
                activeIcon: page.activeIcon == null
                    ? page.icon
                    : page.activeIcon!,
                label: page.label,
              ),
            )
            .toList(),
        onTap: (value) {
          setState(() {
            pageIndex = value;
            controller.animateToPage(
              pageIndex,
              duration: Duration(milliseconds: 400),
              curve: Curves.fastEaseInToSlowEaseOut,
            );
          });
        },
      ), // 底部导航栏
    );
  }
}
