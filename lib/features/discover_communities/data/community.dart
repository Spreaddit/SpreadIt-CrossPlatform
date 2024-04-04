import 'package:equatable/equatable.dart';

class Community extends Equatable {
  final String name;
  final String category;
  final String description;
  final String image;
  final List<dynamic> members;
  final int membersCount;
  final List<Rule> rules;
  final DateTime dateCreated;
  final String communityBanner;

  Community({
    required this.name,
    required this.category,
    required this.description,
    required this.image,
    required this.members,
    required this.membersCount,
    required this.rules,
    required this.dateCreated,
    required this.communityBanner,
  });

  Community.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        category = json['category'],
        description = json['description'],
        image = json['image'],
        members = json['members'],
        membersCount = json['memberscount'],
        rules = (json['rules'] as List).map((i) => Rule.fromJson(i)).toList(),
        dateCreated = DateTime.parse(json['dateCreated']),
        communityBanner = json['communityBanner'];

  @override
  List<Object?> get props => [
        name,
        category,
        description,
        image,
        members,
        membersCount,
        rules,
        dateCreated,
        communityBanner
      ];
}

class Rule extends Equatable {
  final String title;
  final String description;
  final String reportReason;

  Rule({
    required this.title,
    required this.description,
    required this.reportReason,
  });
  Rule.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        reportReason = json['reportReason'];

  @override
  List<Object?> get props => [title, description, reportReason];
}
