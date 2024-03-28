import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coffee_shop/src/api/products/data/products_repository.dart';
import 'package:flutter_coffee_shop/src/api/products/domain/models/category_domain.dart';
import 'package:flutter_coffee_shop/src/api/products/domain/models/product_domain.dart';
import 'package:flutter_coffee_shop/src/common/extensions/context_extensions.dart';
import 'package:flutter_coffee_shop/src/common/extensions/widget_extensions.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/cart_item.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/category_tab.dart';
import 'package:flutter_coffee_shop/src/screens/menu/widgets/menu_item.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'menu_screen.g.dart';

@riverpod
Future<List<ProductDomain>> products(ProductsRef ref) async {
  final repository = ref.watch(productsRepositoryProvider);

  final products = await repository.getProducts();

  return products;
}

@riverpod
Future<List<CategoryDomain>> categories(CategoriesRef ref) async {
  final repository = ref.watch(productsRepositoryProvider);

  final categories = await repository.getCategories();

  return categories;
}

class MenuScreen extends StatefulHookConsumerWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  late final String _currentLanguage;
  late final List<ProductDomain> _selectedItems;
  late final ItemPositionsListener _itemPositionsListener;
  late final ItemScrollController _itemScrollController;

  @override
  void initState() {
    _currentLanguage = Intl.getCurrentLocale();
    _selectedItems = [];
    _itemPositionsListener = ItemPositionsListener.create();
    _itemScrollController = ItemScrollController();
    super.initState();
  }

  void onIncrement(ProductDomain model) {
    final models = _selectedItems.where((element) => element == element);

    setState(() {
      if (models.length == 10) {
        return;
      }
      _selectedItems.add(model);
    });
  }

  void onDecrement(ProductDomain model) {
    setState(() {
      _selectedItems.remove(model);
    });
  }

  void addItem(ProductDomain model) {
    setState(() {
      _selectedItems.add(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsData = ref.watch(productsProvider);
    final categoriesData = ref.watch(categoriesProvider);
    final selectedCategory = useState(0);

    final itemPositionsListenable = _itemPositionsListener.itemPositions;

    itemPositionsListenable.addListener(() {
      selectedCategory.value = itemPositionsListenable.value.first.index;
    });

    if (productsData is AsyncLoading || categoriesData is AsyncLoading) {
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
    }

    if (productsData is AsyncError || categoriesData is AsyncError) {
      return Material(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: context.height,
            child: SafeArea(
              child: Center(
                child: Text(
                  context.tr.unexpectedErrorMessage,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.refresh(categoriesProvider.future),
      child: Scaffold(
        floatingActionButton: _selectedItems.isEmpty
            ? null
            : FloatingActionButton.extended(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  showDragHandle: true,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setBottomSheetState) {
                        return DraggableScrollableSheet(
                          expand: false,
                          initialChildSize: 1,
                          builder: (context, scrollController) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Ваш заказ',
                                      style: context.textExt.robotoBold24,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedItems.clear();
                                        });
                                        setBottomSheetState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                      ),
                                      color: context.colorsExt.primaryColor
                                          .withOpacity(.4),
                                    ),
                                  ],
                                ).paddingOnly(
                                  left: 20,
                                  right: 4,
                                ),
                                const Gap(10),
                                const Divider().paddingOnly(
                                  left: 24,
                                  right: 22,
                                ),
                                const Gap(10),
                                Expanded(
                                  child: ListView.separated(
                                    controller: scrollController,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    itemBuilder: (context, index) {
                                      return CartItem(
                                        model: _selectedItems[index],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Gap(10);
                                    },
                                    itemCount: _selectedItems.length,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                label: Text(
                  context.tr.amountWithSymbol(
                    _selectedItems
                        .reduce(
                          (value, element) {
                            return ProductDomain(
                              id: value.id,
                              name: value.name,
                              description: value.description,
                              category: value.category,
                              imageUrl: value.imageUrl,
                              prices: [
                                ProductPriceDomain(
                                  price: "${double.parse(
                                        _currentLanguage == 'ru_RU'
                                            ? value.prices[0].price
                                            : value.prices[1].price,
                                      ) + double.parse(
                                        _currentLanguage == 'ru_RU'
                                            ? element.prices[0].price
                                            : element.prices[1].price,
                                      )}",
                                  currency: value.prices[0].currency,
                                ),
                                ProductPriceDomain(
                                  price: (
                                    double.parse(
                                          _currentLanguage == 'ru_RU'
                                              ? value.prices[0].price
                                              : value.prices[1].price,
                                        ) +
                                        double.parse(
                                          _currentLanguage == 'ru_RU'
                                              ? element.prices[0].price
                                              : element.prices[1].price,
                                        ),
                                  ).toString(),
                                  currency: value.prices[1].currency,
                                ),
                              ],
                            );
                          },
                        )
                        .prices[_currentLanguage == 'ru_RU' ? 0 : 1]
                        .price,
                  ),
                ),
              ),
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
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return CategoryTab(
                    tabIndex: index,
                    selectedTabIndex: selectedCategory.value,
                    category: categoriesData.value![index].slug,
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
                itemCount: categoriesData.value!.length,
              ),
            ),
          ),
        ),
        body: ScrollablePositionedList.separated(
          itemCount: categoriesData.value!.length,
          itemPositionsListener: _itemPositionsListener,
          itemScrollController: _itemScrollController,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, categoryIndex) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoriesData.value![categoryIndex].slug,
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
                  itemCount: productsData.value!.where(
                    (element) {
                      return element.category.slug ==
                          categoriesData.value![categoryIndex].slug;
                    },
                  ).length,
                  itemBuilder: (context, index) {
                    final models = productsData.value!.where((element) {
                      return element.category.slug ==
                          categoriesData.value![categoryIndex].slug;
                    }).toList();

                    final model = models[index];

                    return MenuItem(
                      model: model,
                      onTap: () {},
                      //TODO: Add functionality
                      onDecrement: onDecrement,
                      onIncrement: onIncrement,
                      onPressed: addItem,
                      count: _selectedItems
                          .where((element) => element == model)
                          .length,
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
      ),
    );
  }
}
