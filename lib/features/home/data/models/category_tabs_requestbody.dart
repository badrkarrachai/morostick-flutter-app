class CategoryTabsRequestBody {
  final String categoryKey;

  CategoryTabsRequestBody({
    required this.categoryKey,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryKey': categoryKey,
    };
  }
}
