import 'package:equatable/equatable.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';

class MutedUser extends Equatable {
  final String userProfilePic;
  final String username;
  final String date;
  final String note;

  MutedUser({
    required this.userProfilePic,
    required this.username,
    required this.date,
    required this.note,
  });

  factory MutedUser.fromJson(Map<String, dynamic> json) {
    return MutedUser(
      userProfilePic: json['userProfilePic'],
      username: json['username'],
      date: dateToDuration( DateTime.parse(json['date'])),
      note: json['note'],
    );
  }

  @override
  List<Object> get props => [userProfilePic, username, date, note];
}

List<MutedUser> mutedUsers = [
  MutedUser(
    userProfilePic:"https://i.redd.it/88qjrepdhng61.jpg",
    username: 'John Doe',
    date: '1h',
    note: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  ),
  MutedUser(
    userProfilePic: 'https://i.redd.it/88qjrepdhng61.jpg',
    username: 'Jane Smith',
    date: '2h',
    note: 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  MutedUser(
    userProfilePic: 'https://i.redd.it/88qjrepdhng61.jpg',
    username: 'Alice Johnson',
    date: '4h',
    note: 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ),
];

