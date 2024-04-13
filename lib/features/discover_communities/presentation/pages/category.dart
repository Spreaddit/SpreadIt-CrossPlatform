import 'package:flutter/material.dart';
import '../../data/community.dart';
import '../../data/get_specific_category.dart';
import '../widgets/subreddit_cards.dart';

/// `CategoryPage` is a StatefulWidget that represents a page for a specific category.
///
/// It takes a `categoryName` as a required parameter, which is used to fetch and display the communities for that category.
///
/// The `CategoryPage` class overrides the `createState` method to create a new instance of `_CategoryPageState`.
class CategoryPage extends StatefulWidget {
  final String categoryName;

  /// Creates a new instance of `CategoryPage`.
  ///
  /// The `categoryName` parameter must not be null.
  CategoryPage({required this.categoryName});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

/// `_CategoryPageState` is a class that contains the state for a `CategoryPage`.
///
/// It has a `futureCommunities` property, which is a `Future` that completes with a list of `Community` objects.
///
/// The `futureCommunities` property is marked as `late`, which means it must be initialized before it's used.
class _CategoryPageState extends State<CategoryPage> {
  late Future<List<Community>> futureCommunities;

  @override
  void initState() {
    try {
      super.initState();
      futureCommunities =
          GetSpecificCommunity().getCommunities(widget.categoryName);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder<List<Community>>(
        future: futureCommunities,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return SubredditCard(
                  index: index + 1,
                  title: snapshot.data![index].name,
                  description: snapshot.data![index].description,
                  numberOfMembers:
                      snapshot.data![index].membersCount.toString(),
                  image: snapshot.data![index].image!,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("WOW! Such empty!");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
