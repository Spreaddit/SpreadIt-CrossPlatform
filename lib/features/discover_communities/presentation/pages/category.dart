import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  CategoryPage({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: ListView(
        children: [
          CategoryItem(
            title: 'Technology',
            icon: Icons.computer,
          ),
          CategoryItem(
            title: 'Sports',
            icon: Icons.sports_soccer,
          ),
          CategoryItem(
            title: 'Movies',
            icon: Icons.movie,
          ),
          // Add more CategoryItems as needed
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryItem({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // Handle category item tap
        // You can navigate to a specific subreddit page or perform any other action here
      },
    );
  }
}
