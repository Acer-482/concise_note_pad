import 'package:concise_note_pad/core/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

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
            spacing: 20,
            children: [
              _buildAboutContext(),
              Divider(),
              Text('更多', style: Theme.of(context).textTheme.bodyLarge),
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: Text('更多许可证信息'),
                onTap: () => showLicensePage(context: context),
                trailing: const Icon(Icons.arrow_right),
              ),
              ListTile(
                leading: const Icon(Icons.warehouse),
                title: Text('跳转到github仓库'),
                subtitle: Text('https://github.com/Acer-482/concise_note_pad'),
                onTap: () => _launchUrl(),
                trailing: const Icon(Icons.launch),
              ),
            ],
          ),
        ),
      ),
    ); // 骨架
  }

  // 构建关于内容
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
              CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage('assets/icon.png'),
              ),
              Text(
                '简记',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '版本 ${packageInfo.version}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '本软件采用 GPL-3.0 许可证',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '版权所有 © 2025 Acer',
                style: Theme.of(context).textTheme.bodyLarge,
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

  // 跳转到网页
  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse('https://github.com/Acer-482/concise_note_pad');
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          ToastUtils.showStandardToast(
            context,
            title: '跳转失败',
            msg: '跳转到"$uri"失败',
            type: ToastificationType.error,
          );
        }
      }
    } catch (e) {
      // 跳转错误
      if (mounted) {
        ToastUtils.showStandardToast(
          context,
          title: '跳转失败',
          msg: '跳转到"$uri"时发生错误：$e',
          type: ToastificationType.error,
        );
      }
    }
  }
}
