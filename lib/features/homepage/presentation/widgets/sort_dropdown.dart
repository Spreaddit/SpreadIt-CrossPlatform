import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';

class SortTypeDropdown extends StatefulWidget {
  final void Function(PostCategories) onCategoryChanged;

  SortTypeDropdown({required this.onCategoryChanged});

  @override
  State<SortTypeDropdown> createState() => _SortTypeDropdownState();
}

class _SortTypeDropdownState extends State<SortTypeDropdown> {
  PostCategories selectedCategory = PostCategories.best;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<PostCategories>(
      value: selectedCategory,
      onChanged: (PostCategories? newValue) {
        setState(() {
          selectedCategory = newValue ?? PostCategories.best;
          widget.onCategoryChanged(selectedCategory);
        });
      },
      items: PostCategories.values
          .map<DropdownMenuItem<PostCategories>>((PostCategories category) {
        return DropdownMenuItem<PostCategories>(
          value: category,
          child: Text(category.toString().substring(
              category.toString().indexOf('.') + 1,
              category.toString().indexOf('.') + 5)),
        );
      }).toList(),
    );
  }
}
