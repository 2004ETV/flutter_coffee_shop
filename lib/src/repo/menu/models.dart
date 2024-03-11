class CategoryModel {
  const CategoryModel({
    required this.category,
    required this.items,
  });

  final String category;
  final List<CategoryItemModel> items;
}

class CategoryItemModel {
  const CategoryItemModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
  });

  final String id;
  final String? image;
  final String name;
  final double price;
}
