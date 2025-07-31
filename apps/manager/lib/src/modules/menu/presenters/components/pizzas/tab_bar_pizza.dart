import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/tab_pizza_border_pasta.dart';
import 'package:manager/src/modules/menu/presenters/components/pizzas/tab_pizza_sizes.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TabBarPizza extends StatefulWidget {
  final Function(bool isValid) isValid;
  final CategoryModel category;
  const TabBarPizza({required this.isValid, required this.category, super.key});

  @override
  State<TabBarPizza> createState() => _TabBarPizzaState();
}

class _TabBarPizzaState extends State<TabBarPizza> with TickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      widget.isValid(tabController.index == tabController.length - 1);
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: !context.isDarkTheme ? context.color.primaryBG : null,
            appBar: AppBar(
              backgroundColor: !context.isDarkTheme ? context.color.onPrimaryBG : null,
              automaticallyImplyLeading: false,
              toolbarHeight: 0,
              bottom: TabBar(
                controller: tabController,
                onTap: (value) {
                  tabController.animateTo(value);
                },
                tabs: [Tab(text: context.i18n.tamanhos), Tab(text: context.i18n.bordasEMassas), Tab(text: context.i18n.extras)],
              ),
            ),
            body: TabBarView(controller: tabController, children: [TabPizzaSizes(category: widget.category), TabPizzaBorderPasta(category: widget.category), const Text("3")]),
            floatingActionButton: ListenableBuilder(
              listenable: tabController,
              builder: (context, _) {
                if (tabController.index == tabController.length - 1) {
                  return const SizedBox.shrink();
                }
                return FloatingActionButton(child: const Icon(PaipIcons.arrowRight, color: Colors.white), onPressed: () => tabController.index++);
              },
            ),
          );
        },
      ),
    );
  }
}
