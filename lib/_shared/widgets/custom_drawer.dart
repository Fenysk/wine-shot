import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleStyle;

  const CustomDrawer({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
    this.padding,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            content,
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            ),
          ],
        ),
      ),
    );
  }
}
