import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class CustomTabHelper{
  static void launchURL(BuildContext context, String url) async {
    try {
      await launch(
        '$url',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: const CustomTabsAnimation(
            startEnter: 'android:anim/slide_in_right',
            startExit: 'android:anim/slide_out_left',
            endEnter: 'android:anim/slide_in_left',
            endExit: 'android:anim/slide_out_right',
          ),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}