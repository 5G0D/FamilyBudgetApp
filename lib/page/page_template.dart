import 'package:family_budget/Page/home_page.dart';
import 'package:family_budget/Theme/custom_theme.dart';
import 'package:family_budget/Widget/date_picker.dart';
import 'package:family_budget/controller/page_controller.dart' as pc;
import 'package:flutter/material.dart';

import 'drawer_page.dart';

class PageTemplate extends StatefulWidget {
  const PageTemplate(
      {Key? key,
      this.child,
      this.datePickerEnable = true,
      required this.refreshFunc})
      : super(key: key);

  final Widget? child;
  final Function() refreshFunc;
  final bool datePickerEnable;

  @override
  State<PageTemplate> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          preferredSize:
              widget.datePickerEnable ? const Size.fromHeight(50) : Size.zero,
          child: widget.datePickerEnable
              ? DatePicker(widget.refreshFunc)
              : const SizedBox.shrink(),
        ),
        backgroundColor: CustomTheme.appBarColor,
        actions: [
          /*IconButton(
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
          )*/
        ],
      ),
      drawer: Drawer(
        child: const DrawerPage(),
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: BottomNavigationBar(
          currentIndex: pc.PageController.currentBarIndex,
          onTap: (int index) => {
            pc.PageController.currentBarIndex = index,
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, _, __) =>
                    pc.PageController
                        .pageId[pc.PageController.currentBarIndex] ??
                    const HomePage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            )
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              tooltip: '',
              icon: Icon(
                Icons.donut_large,
              ),
              label: 'Категории',
            ),
            BottomNavigationBarItem(
              tooltip: '',
              icon: Icon(
                Icons.bar_chart,
              ),
              label: 'Графики',
            ),
            BottomNavigationBarItem(
              tooltip: '',
              icon: Icon(
                Icons.chat,
              ),
              label: 'Чат',
            ),
          ],
          selectedItemColor: Colors.white,
        ),
      ),
      body: widget.child,
    );
  }
}
