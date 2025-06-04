import 'package:flutter/material.dart';

import '../_shared/shared_module.dart';
import '../modules/auth/auth_module.dart';
import '../modules/template/template_module.dart';
import 'constants.dart';
import 'di.dart';
import 'layout/adaptive_layout/adaptive_destination.dart';

class AppModules {
  /// Initializes modules before the Flutter app runs (before `runApp()`).
  static Future<void> initBeforeRunApp() async {
    await registerAuthModule();
    await registerSharedModule();
    await registerTemplateModule();
  }

  /// Initializes modules after the Flutter app has started (after `runApp()`), when BuildContext is available.
  static void initAfterRunApp(BuildContext context) {
    var navTabs = di<List<AdaptiveDestination>>(instanceName: Constants.navTabsDiKey);
    //* Reset Nav tabs to avoid duplication
    navTabs.clear();

    registerAuthModuleWithContext(context);
    registerSharedModuleWithContext(context);

    navTabs.sort();
  }
}
