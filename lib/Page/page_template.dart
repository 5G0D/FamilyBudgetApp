import 'package:family_budget/Icon/custom_icons_icons.dart';
import 'package:family_budget/Page/home_page.dart';
import 'package:family_budget/page_controller.dart' as pc;
import 'package:family_budget/Theme/custom_theme.dart';
import 'package:family_budget/Widget/date_picker.dart';
import 'package:family_budget/date_picker_controller.dart';
import 'package:flutter/material.dart';

import 'drawer_page.dart';

class PageTemplate extends StatefulWidget {
  final Widget? child;

  const PageTemplate({Key? key, this.child}) : super(key: key);

  @override
  State<PageTemplate> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Семейный бюджет'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () => setState(() {
                Scaffold.of(context).openDrawer();
              }),
              padding: const EdgeInsets.all(10),
              splashRadius: 25,
            );
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: DatePicker(_refresh),
        ),
        backgroundColor: CustomTheme.appBarColor,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_rounded,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () => setState(() {
              print('edit');
            }),
            padding: const EdgeInsets.all(10),
            splashRadius: 25,
          )
        ],
      ),
      drawer: Drawer(
        child: DrawerPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pc.PageController.currentBarIndex,
        onTap: (int index) => {
          pc.PageController.currentBarIndex = index,
          setState(() => Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, _, __) =>
                      pc.PageController
                          .pageId[pc.PageController.currentBarIndex] ??
                      HomePage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              ))
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            tooltip: '',
            icon: Icon(
              CustomIcons.donut_large,
            ),
            label: 'Категории',
          ),
          BottomNavigationBarItem(
            tooltip: '',
            icon: Icon(
              CustomIcons.chat,
            ),
            label: 'Чат',
          ),
        ],
        selectedItemColor: Colors.white,
      ),
      body: widget.child,
    );
  }
}