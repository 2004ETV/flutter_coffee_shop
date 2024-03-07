import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coffee_shop/src/common/extensions/context_extensions.dart';
import 'package:flutter_coffee_shop/src/common/extensions/widget_extensions.dart';
import 'package:flutter_coffee_shop/src/repo/menu/models.dart';
import 'package:flutter_coffee_shop/src/repo/menu/repository.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/category_tab.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/menu_item.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  late final GlobalKey _listKey;
  late final List<GlobalKey> _categoryGlobalKeys;
  late final Map<String, int> _selectedItems;

  @override
  void initState() {
    _listKey = GlobalKey();
    _categoryGlobalKeys = <GlobalKey>[];
    _selectedItems = <String, int>{};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesData = ref.watch(categoriesProvider);
    final scrollController = useScrollController();
    final selectedCategory = useState(0);

    useEffect(
      () {
        if (_categoryGlobalKeys.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final category = _categoryGlobalKeys[selectedCategory.value]
                .currentContext
                ?.findRenderObject();
            if (category != null) {
              scrollController.position.ensureVisible(
                category,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          });
        }
        return null;
      },
      [selectedCategory.value],
    );

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
      child: Scaffold(
        body: categoriesData.when(
          data: (data) {
            if (_categoryGlobalKeys.isEmpty) {
              _categoryGlobalKeys.addAll(
                List.generate(
                  data.length,
                  (index) => GlobalKey(debugLabel: index.toString()),
                ),
              );
              scrollController.addListener(() {
                // centerItemIndex = getCenterItemIndex();
              });
            }
            return CustomScrollView(
              key: _listKey,
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    systemNavigationBarColor: Colors.transparent,
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.transparent,
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
                              selectedCategory.value =
                                  data.indexOf(data[index]);
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
                const SliverGap(16),
                SliverList.separated(
                  itemCount: data.length,
                  itemBuilder: (context, categoryIndex) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key: _categoryGlobalKeys[categoryIndex],
                          data[categoryIndex].category,
                          style: context.textExt.robotoSemiBold32,
                        ),
                        const Gap(16),
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: GridView.builder(
                            primary: false,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio:
                                  ((context.width - 24) / 2) / 230,
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
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Gap(16);
                  },
                )
                    .sliverPaddingSymmetric(horizontal: 16)
                    .sliverSafeArea(top: false),
                const SliverGap(16),
              ],
            );
          },
          error: (error, stackTrace) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: context.height,
                child: Center(
                  child: Text('$error'),
                ),
              ),
            );
          },
          loading: () {
            return SingleChildScrollView(
              child: SizedBox(
                height: context.height,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
