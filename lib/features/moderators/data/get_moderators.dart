import 'package:spreadit_crossplatform/features/moderators/data/moderator_class_model.dart';

Moderator m1 = Moderator(
    username: 'rehab',
    profilepic:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s",
    isFullPermissions: false,
    isAccess: true,
    isPosts: true,
    moderatorSince: DateTime.now());
List<Moderator> fetchModeratorsData(String communityName, int display) {
  return [m1, m1, m1];
}
