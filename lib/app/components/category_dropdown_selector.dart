import 'package:ecommerce_app/app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryDropdownSelector extends StatefulWidget {
  final List<Category> categories;// Hàm callback khi chọn Category

  const CategoryDropdownSelector({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  _CategoryDropdownSelectorState createState() =>
      _CategoryDropdownSelectorState();
}

class _CategoryDropdownSelectorState extends State<CategoryDropdownSelector> {
  int? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedCategoryId,
      hint: Text("Chọn danh mục"),
      onChanged: (int? newValue) {
        setState(() {
          selectedCategoryId = newValue;
        });
      },
      items: widget.categories.map<DropdownMenuItem<int>>((Category category) {
        return DropdownMenuItem<int>(
          value: category.id,
          child: Text(category.name),
        );
      }).toList(),
    );
  }
}