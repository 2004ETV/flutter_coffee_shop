import 'package:flutter_coffee_shop/src/repo/menu/mock.dart';
import 'package:flutter_coffee_shop/src/repo/menu/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository.g.dart';

@riverpod
MenuRepository menuRepositoryMock(MenuRepositoryMockRef ref) {
  return MenuRepositoryMock();
}

abstract class MenuRepository {
  const MenuRepository._();

  Future<List<CategoryModel>> getCategories();
}
