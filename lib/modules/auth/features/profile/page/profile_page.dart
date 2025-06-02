import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/layout/page_layout.dart';
import '../../../auth_routes.dart';
import '../../../bloc/auth_bloc.dart';
import '../sections/profile_info_section.dart';
import '../sections/settings_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PageLayout(
      title: context.tr('profilePage.title'),
      navTab: AuthNavTab.profile,
      page: Align(
        alignment: Alignment.topCenter,
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final user = state.user;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ProfileInfoSection(user: user, theme: theme),
                  SettingsSection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
