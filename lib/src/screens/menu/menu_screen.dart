import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coffee_shop/src/common/extensions/context_extensions.dart';
import 'package:flutter_coffee_shop/src/repo/menu/models.dart';
import 'package:flutter_coffee_shop/src/repo/menu/repository.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/category_tab.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/menu_item.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'menu_screen.g.dart';

@riverpod
Future<List<CategoryModel>> categories(CategoriesRef ref) async {
  final repository = ref.watch(menuRepositoryMockProvider);

  final categories = await repository.getCategories();

  return categories;
}

class MenuScreen extends StatefulHookConsumerWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  late final Map<String, int> _selectedItems;
  late final ItemPositionsListener _itemPositionsListener;
  late final ItemScrollController _itemScrollController;

  @override
  void initState() {
    _selectedItems = <String, int>{};
    _itemPositionsListener = ItemPositionsListener.create();
    _itemScrollController = ItemScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesData = ref.watch(categoriesProvider);
    final selectedCategory = useState(0);
    final itemPositionsListenable = _itemPositionsListener.itemPositions;

    itemPositionsListenable.addListener(() {
      selectedCategory.value = itemPositionsListenable.value.first.index;
    });

    void onIncrement(String itemKey) {
      setState(() {
        if (_selectedItems[itemKey] == 10) {
          return;
        }
        _selectedItems.update(
          itemKey,
          (value) => value + 1,
        );
      });
    }

    void onDecrement(String itemKey) {
      setState(() {
        _selectedItems.update(
          itemKey,
          (value) => value - 1,
        );
      });
    }

    void addItem(String itemKey) {
      setState(() {
        _selectedItems.update(
          itemKey,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      });
    }

    return RefreshIndicator(
      onRefresh: () => ref.refresh(categoriesProvider.future),
      child: categoriesData.when(
        data: (data) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.transparent,
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: context.colorsExt.backgroundPrimaryColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: SizedBox(
                  height: 40,
                  child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return CategoryTab(
                        tabIndex: index,
                        selectedTabIndex: selectedCategory.value,
                        category: data[index].category,
                        onTap: () {
                          _itemScrollController.scrollTo(
                            index: index,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Gap(8);
                    },
                    itemCount: data.length,
                  ),
                ),
              ),
            ),
            body: ScrollablePositionedList.separated(
              itemCount: data.length,
              itemPositionsListener: _itemPositionsListener,
              itemScrollController: _itemScrollController,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, categoryIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[categoryIndex].category,
                      style: context.textExt.robotoSemiBold32,
                    ),
                    const Gap(16),
                    GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: ((context.width - 24) / 2) / 240,
                      ),
                      itemCount: data[categoryIndex].items.length,
                      itemBuilder: (context, index) {
                        final model = data[categoryIndex].items[index];
                        return MenuItem(
                          model: model,
                          onTap: () {},
                          //TODO: Add functionality
                          onDecrement: onDecrement,
                          onIncrement: onIncrement,
                          onPressed: addItem,
                          count: _selectedItems[model.id],
                        );
                      },
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const Gap(16);
              },
            ),
          );
        },
        error: (error, stackTrace) {
          return Material(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: context.height,
                child: SafeArea(
                  child: Center(
                    child: Text('$error'),
                  ),
                ),
              ),
            ),
          );
        },
        loading: () {
          return Material(
            child: SingleChildScrollView(
              child: SizedBox(
                height: context.height,
                child: const SafeArea(
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
