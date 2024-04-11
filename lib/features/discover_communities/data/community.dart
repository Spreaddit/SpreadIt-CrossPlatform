import 'package:equatable/equatable.dart';

class Community extends Equatable {
  final String name;
  final String description;
  final String image;
  final int membersCount;
  final String? backgroundImage;     

  Community({
    required this.name,
    this.description='', 
    required this.image,
    required this.membersCount,
    this.backgroundImage,   
  });

  Community.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        image = json['image'],
        membersCount = json['memberscount'],
        backgroundImage= json['communityBanner']; 

  @override
  List<Object?> get props => [
        name,
        description,
        image,
        membersCount,
      ];
}