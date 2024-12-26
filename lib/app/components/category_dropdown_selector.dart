import 'package:ecommerce_app/app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryDropdownSelector extends StatefulWidget {
  final List<Category> categories;// Hàm callback khi chọn Category
  final ValueChanged<int?> onCategorySelected;
  final int? selectedCategoryId;

  const CategoryDropdownSelector({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
    this.selectedCategoryId,
  }) : super(key: key);

  @override
  _CategoryDropdownSelectorState createState() =>
      _CategoryDropdownSelectorState();
}

class _CategoryDropdownSelectorState extends State<CategoryDropdownSelector> {
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    // Nếu có selectedCategoryId từ bên ngoài, sử dụng nó làm giá trị mặc định
    selectedCategoryId = widget.selectedCategoryId;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedCategoryId,
      hint: Text("Chọn danh mục"), // Nếu selectedCategoryId là null, sẽ hiển thị 'Chọn danh mục'
      onChanged: (int? newValue) {
        setState(() {
          selectedCategoryId = newValue;
        });
        widget.onCategorySelected(selectedCategoryId);
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