import 'package:concise_note_pad/core/l10n/app_localizations.dart';
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
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return Scaffold(
      appBar: AppBar(title: Text(loc.aboutPageTitle)),
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
              Text(loc.more, style: Theme.of(context).textTheme.bodyLarge),
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: Text(loc.moreLicenseInfo),
                onTap: () => showLicensePage(context: context),
                trailing: const Icon(Icons.arrow_right),
              ),
              ListTile(
                leading: const Icon(Icons.warehouse),
                title: Text(loc.goToGithubRepo),
                subtitle: Text(loc.githubRepoUrl),
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
    final loc = AppLocalizations.of(context)!; // 获取本地化
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
              Text(loc.appName, style: Theme.of(context).textTheme.titleLarge),
              Text(
                loc.versionWithParam(packageInfo.version),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                loc.softwareLicense,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(loc.copyright, style: Theme.of(context).textTheme.bodyLarge),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // 显示等待加载指示器
        } else {
          return Text(loc.failedToGetAppInfo);
        }
      },
    );
  }

  // 跳转到网页
  Future<void> _launchUrl() async {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    final Uri uri = Uri.parse(loc.githubRepoUrl);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          ToastUtils.showStandardToast(
            context,
            title: loc.jumpFailed,
            msg: loc.jumpToUriFailed(uri.toString()),
            type: ToastificationType.error,
          );
        }
      }
    } catch (e) {
      // 跳转错误
      if (mounted) {
        ToastUtils.showStandardToast(
          context,
          title: loc.jumpFailed,
          msg: loc.jumpToUriError(uri.toString(), e.toString()),
          type: ToastificationType.error,
        );
      }
    }
  }
}
