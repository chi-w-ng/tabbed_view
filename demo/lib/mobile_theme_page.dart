import 'package:demo/example_page.dart';
import 'package:flutter/material.dart';
import 'package:tabbed_view/tabbed_view.dart';

class MobileThemePage extends StatefulWidget {
  @override
  MobileThemePageState createState() => MobileThemePageState();
}

class MobileThemePageState extends ExamplePageState {
  @override
  Widget buildContent() {
    List<TabData> tabs = [];
    for (var i = 1; i < 7; i++) {
      tabs.add(
          TabData(text: 'Tab $i', content: Center(child: Text('Content $i'))));
    }
    TabbedWiewController controller = TabbedWiewController(tabs);
    TabbedWiew tabbedView =
        TabbedWiew(controller: controller, theme: TabbedViewTheme.mobile());
    return tabbedView;
  }
}
