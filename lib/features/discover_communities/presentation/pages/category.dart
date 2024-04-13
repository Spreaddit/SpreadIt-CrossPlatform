import 'package:flutter/material.dart';
import '../../data/community.dart';
import '../../data/get_specific_category.dart';
import '../widgets/subreddit_cards.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;

  CategoryPage({required this.categoryName});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<Community>> futureCommunities;

  @override
  void initState() {
    super.initState();
    futureCommunities =
        GetSpecificCommunity().getCommunities(widget.categoryName);
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
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
