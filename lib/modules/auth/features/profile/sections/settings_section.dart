import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_shared/bloc/theme_mode_cubit.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SizedBox(
        width: 700,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _SettingsCard(child: ThemeModeSettingButton()),
              const SizedBox(height: 20),
              const _SettingsCard(child: LanguageSettingTile()),
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeModeSettingButton extends StatelessWidget {
  const ThemeModeSettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        final cubit = BlocProvider.of<ThemeModeCubit>(context);
        isDark ? cubit.lightMode() : cubit.darkMode();
      },
      child: ListTile(
        leading: Icon(
          isDark ? Icons.light_mode : Icons.dark_mode,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          isDark ? context.tr('settingsPage.lightMode') : context.tr('settingsPage.darkMode'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Switch(
          value: isDark,
          onChanged: (val) {
            final cubit = context.read<ThemeModeCubit>();
            val ? cubit.darkMode() : cubit.lightMode();
          },
        ),
      ),
    );
  }
}

class LanguageSettingTile extends StatelessWidget {
  const LanguageSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    return ListTile(
      leading: const Icon(Icons.language, color: Colors.teal),
      title: Text(
        context.tr('settingsPage.language'),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: DropdownButton<Locale>(
        value: currentLocale,
        underline: const SizedBox(),
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            context.setLocale(newLocale);
          }
        },
        items: const [
          DropdownMenuItem(value: Locale('en'), child: Text('English 🇺🇸')),
          DropdownMenuItem(value: Locale('ar'), child: Text('العربية 🇸🇦')),
          DropdownMenuItem(value: Locale('zh'), child: Text('中文 🇨🇳')),
          DropdownMenuItem(value: Locale('es'), child: Text('Español 🇪🇸')),
          DropdownMenuItem(value: Locale('fr'), child: Text('Français 🇫🇷')),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;

  const _SettingsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: child,
      ),
    );
  }
}
