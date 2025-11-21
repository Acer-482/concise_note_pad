import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('关于')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 40,
            children: [
              _buildAboutContext(),
              ElevatedButton(
                onPressed: () => showLicensePage(context: context),
                child: Text('许可证信息'),
              ),
            ],
          ),
        ),
      ),
    ); // 骨架
  }

  Widget _buildAboutContext() {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(), // 获取平台信息
      builder: (context, snapshot) {
        // 获取到数据 构建页面
        if (snapshot.connectionState == ConnectionState.done) {
          PackageInfo packageInfo = snapshot.data!;
          return Column(
            spacing: 10,
            children: [
              CircleAvatar(radius: 32,child: Icon(Icons.apps, size: 24,),),
              Text('简记', style: Theme.of(context).textTheme.displayLarge),
              Text(
                '© 2024 Acer',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Version ${packageInfo.version} (${packageInfo.buildNumber})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          // 正在获取 显示等待加载指示器
          return const CircularProgressIndicator();
        } else {
          return const Text('获取应用信息失败');
        }
      },
    );
  }
}
