import 'package:flutter_coffee_shop/src/common/assets/assets.dart';
import 'package:flutter_coffee_shop/src/common/utils/mock_utils.dart';
import 'package:flutter_coffee_shop/src/repo/menu/models.dart';
import 'package:flutter_coffee_shop/src/repo/menu/repository.dart';
import 'package:uuid/uuid.dart';

class MenuRepositoryMock implements MenuRepository {
  final categoriesListModel = [
    CategoryModel(
      category: 'Классический',
      items: [
        CategoryItemModel(
          id: const Uuid().v4(),
          image: null,
          name: 'Эспрессо',
          price: 79,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup1,
          name: 'Американо',
          price: 89,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup2,
          name: 'Капучино',
          price: 149,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup1,
          name: 'Латте',
          price: 149,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup3,
          name: 'Флэт Уайт',
          price: 169,
        ),
      ],
    ),
    CategoryModel(
      category: 'Авторский',
      items: [
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup1,
          name: 'Карамельно-арахисовый латте',
          price: 199,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup3,
          name: 'Латте с халвой',
          price: 199,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup2,
          name: 'Латте ореховый',
          price: 199,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup1,
          name: 'Латте пряный с кленом',
          price: 199,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: null,
          name: 'Сырный латте',
          price: 209,
        ),
      ],
    ),
    CategoryModel(
      category: 'Холодный',
      items: [
        CategoryItemModel(
          id: const Uuid().v4(),
          image: null,
          name: 'Айс Латте classic',
          price: 199,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup3,
          name: 'Айс Латте Клубника-Лемонграсс',
          price: 199,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup1,
          name: 'Итальяно',
          price: 199,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup2,
          name: 'Крем-кофе Черника-кокос',
          price: 199,
        ),
      ],
    ),
    CategoryModel(
      category: 'Раф / Моккачино',
      items: [
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup1,
          name: 'Раф классический',
          price: 199,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup3,
          name: 'Раф цитрусовый',
          price: 199,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup1,
          name: 'Раф кокосовый',
          price: 199,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: null,
          name: 'Раф Фисташковый',
          price: 199,
        ),
        CategoryItemModel(
          id: const Uuid().v4(),
          image: Assets.imagesCoffeeCup3,
          name: 'Моккачино классический',
          price: 209,
        ),
      ],
    ),
  ];

  @override
  Future<List<CategoryModel>> getCategories() {
    return safeMock(categoriesListModel);
  }
}
