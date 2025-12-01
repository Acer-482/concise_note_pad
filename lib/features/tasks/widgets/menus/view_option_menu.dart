import 'package:concise_note_pad/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ViewOptionMenu extends StatefulWidget {
  const ViewOptionMenu({super.key});

  @override
  State<StatefulWidget> createState() => _ViewOptionMenuState();
}

class _ViewOptionMenuState extends State<ViewOptionMenu> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 获取本地化
    return Text(loc.stillInDevelopment);
  }
}
