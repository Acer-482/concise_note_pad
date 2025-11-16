import 'package:concise_note_pad/page/home_page.dart';
import 'package:concise_note_pad/util/page_utils.dart';
import 'package:concise_note_pad/page/task_page/task_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_icons_animated/flutter_animated_icons.dart';
// import 'package:lottie/lottie.dart';

/// 导航页面
class _NavigationPage {
  _NavigationPage({
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
///
/// 用于构建页面和导航
///
/// 适配多端
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const double mobileMaxWidth = 600; // 手机模式最大宽度
  static const double tabletMaxWidth = 800; // 平板模式最大宽度
  final List<_NavigationPage> _pageList = [
    _NavigationPage(
      icon: const Icon(Icons.home_outlined),
      activeIcon: const Icon(Icons.home),
      label: '主页面',
      body: const HomePage(),
    ),
    _NavigationPage(
      icon: const Icon(Icons.format_list_bulleted),
      label: '任务',
      body: const TaskPage(),
    ),
  ]; // 页面列表
  int pageIndex = 0; // 页面索引
  PageController controller = PageController(); // 页面控制器

  /// 获取模式
  ///
  /// 值：
  /// - 0 移动模式
  /// - 1 宽屏模式 - 平板
  /// - 2 宽屏模式 - 桌面
  int _getMode() {
    int mode = 0;
    final screenWidth = MediaQuery.of(context).size.width; // 获取屏幕宽度
    if (screenWidth > tabletMaxWidth) {
      mode = 2;
    } else if (screenWidth > mobileMaxWidth) {
      mode = 1;
    }
    return mode;
  }

  // 构建页面浏览器
  Widget _buildBodyPageView(int mode) {
    return PageView(
      scrollDirection: mode == 0 ? Axis.horizontal : Axis.vertical, // 方向
      controller: controller,
      children: _pageList.map((page) => page.body).toList(),
      onPageChanged: (value) {
        setState(() {
          pageIndex = value;
        });
      }, // 页面更改
    ); // 页面浏览器
  }

  // 构建侧面导航轨道（宽屏设备）
  Widget _buildNavigationRail(int mode) {
    return NavigationRail(
      selectedIndex: pageIndex,
      onDestinationSelected: _switchPage,
      labelType: mode == 1
          ? NavigationRailLabelType.selected
          : null, // label显示时机
      extended: mode == 2, // 拓展模式
      destinations: _pageList
          .map(
            (page) => NavigationRailDestination(
              icon: page.icon,
              selectedIcon: page.activeIcon,
              label: Text(
                page.label,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          )
          .toList(), // 导航项列表
    ); // 主体
  }

  // 构建主体
  Widget _buildBody(int mode) {
    switch (mode) {
      case 1: // 宽屏模式 - 平板
      case 2: // 宽屏模式 - 桌面
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(flex: 1, child: _buildNavigationRail(mode)),
            Flexible(flex: mode == 1 ? 8 : 4, child: _buildBodyPageView(mode)),
          ],
        );
      default: // 移动模式 / 其他模式
        return _buildBodyPageView(mode);
    } // 宽屏模式
  }

  // 构建抽屉
  Widget? _buildDrawer(int mode) {
    return Drawer(
      //
    ); // 抽屉
  }

  // 构建底部导航栏
  Widget? _buildBottomNavigationBar(int mode) {
    return mode == 0
        ? BottomNavigationBar(
            currentIndex: pageIndex,
            onTap: _switchPage,
            items: _pageList
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
          )
        : null; // 仅移动模式
  }

  // 切换页面
  void _switchPage(int index) {
    setState(() {
      pageIndex = index;
      controller.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 400),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    int mode = _getMode(); // 根据宽度决定模式
    return Scaffold(
      drawerEdgeDragWidth: 50, // 手势打开滑动触发区域的宽度
      drawerEnableOpenDragGesture: mode == 0, // 启用/禁用手势打开

      appBar: PageUtils.buildDefaultAppbar(
        context,
        const Text('简记', textAlign: TextAlign.center),
      ), // 应用栏
      drawer: mode == 0 ? _buildDrawer(mode) : null, // 左侧抽屉（移动模式）
      endDrawer: mode != 0 ? _buildDrawer(mode) : null, // 右侧抽屉（非移动模式）
      // drawerBarrierDismissible: mode == 0, // 移动模式为模态；否则为非模态
      body: _buildBody(mode),
      bottomNavigationBar: _buildBottomNavigationBar(mode),
    );
  }
}
