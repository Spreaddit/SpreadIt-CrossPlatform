import 'package:equatable/equatable.dart';

class Community extends Equatable {
  final String name;
  final String description;
  final String image;
  final int membersCount;

  Community({
    required this.name,
    required this.description,
    required this.image,
    required this.membersCount,
  });

  Community.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        image = json['image'],
        membersCount = json['memberscount'];

  @override
  List<Object?> get props => [
        name,
        description,
        image,
        membersCount,
      ];
}
