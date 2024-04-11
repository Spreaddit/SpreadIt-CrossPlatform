import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_btn_bottom_sheet.dart';
import 'package:spreadit_crossplatform/features/community/data/api_community_info.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';

class CommunityPostFeed extends StatefulWidget {
  CommunityPostFeed({Key? key, required this.communityName}) : super(key: key);

  final String communityName;

  @override
  State<CommunityPostFeed> createState() => _CommunityPostFeedState();
}

class _CommunityPostFeedState extends State<CommunityPostFeed> {
  late Map<String, dynamic> data;
  String communityBannerLink = "";
  List<PostCategories> mainPostCategories = [
    PostCategories.hot,
    PostCategories.newest,
    PostCategories.top
  ];
  List<PostCategories> topPostCategories = [
    PostCategories.top,
    PostCategories.top,
    PostCategories.top,
    PostCategories.top,
    PostCategories.top,
    PostCategories.top
  ];
  List<IconData> outlinedIconDatas = [
    Icons.local_fire_department,
    Icons.grade_outlined,
    Icons.trending_up_outlined,
  ];
  List<IconData> filledIconDatas = [
    Icons.local_fire_department,
    Icons.grade_outlined,
    Icons.trending_up_outlined,
    Icons.trending_up_outlined,
    Icons.trending_up_outlined,
    Icons.trending_up_outlined,
    Icons.trending_up_outlined,
    Icons.trending_up_outlined
  ];
  List<String> mainSortTexts = [
    "HOT POSTS",
    "NEW POSTS",
    "TOP POSTS",
  ];

  List<String> topPostsTexts = [
    "TOP POSTS NOW",
    "TOP POSTS TODAY",
    "TOP POSTS THIS WEEK",
    "TOP POSTS THIS MONTH",
    "TOP POSTS THIS YEAR",
    "TOP POSTS ALL TIME"
  ];

  PostCategories currMainPostCategory = PostCategories.hot;
  PostCategories currTopPostCategory = PostCategories.top;
  IconData selectedIconData = Icons.local_fire_department_outlined;
  String selectedMainText = "HOT POSTS";
  String selectedTopPostText = "";
  int mainSelectedIndex = 0;
  int topPostSelectedIndex = -1;
  bool enteredTopSort = false;
  bool confirmSelectedTopSort = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    data = await getCommunityInfo(widget.communityName);
    setState(() {
      communityBannerLink = data["communityBanner"];
    });
  }

  void setPostSort(int selectedIndex, bool isTopPost) {
    if (!isTopPost) {
      setState(() {
        selectedMainText = mainSortTexts[selectedIndex];
        selectedIconData = outlinedIconDatas[selectedIndex];
        currMainPostCategory = mainPostCategories[selectedIndex];
        selectedTopPostText = "";
        topPostSelectedIndex = -1;
      });
    } else {
      setState(() {
        mainSelectedIndex = 2;
        selectedMainText = mainSortTexts[mainSortTexts.length - 1];
        selectedTopPostText = topPostsTexts[selectedIndex];
        selectedIconData = outlinedIconDatas[outlinedIconDatas.length - 1];
        currTopPostCategory = topPostCategories[selectedIndex];
      });
    }
  }

  void selectPostSortModal() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "SORT POSTS BY",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: mainSortTexts.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool fillIcon = (mainSelectedIndex == index);
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          (fillIcon)
                              ? filledIconDatas[index]
                              : outlinedIconDatas[index],
                          color: (fillIcon) ? Colors.black : Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: RadioListTile(
                            dense: true,
                            toggleable: true,
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Text(
                              mainSortTexts[index],
                              style: TextStyle(
                                  color: (mainSelectedIndex == index)
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            value: index,
                            groupValue: mainSelectedIndex,
                            onChanged: (int? value) {
                              var mainPrevIndex = mainSelectedIndex;
                              if ((value != 2 && value != null) ||
                                  (value == null && mainPrevIndex != 2)) {
                                setModalState(() {
                                  mainSelectedIndex = value ?? mainPrevIndex;
                                });
                                setPostSort(mainSelectedIndex, false);
                                Navigator.pop(context);
                              } else {
                                Navigator.pop(context);
                                selectTopPostSortModal(mainPrevIndex);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          );
        });
      },
    );
  }

  void selectTopPostSortModal(int mainPrevIndex) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState2) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "TOP POSTS FROM",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: topPostsTexts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text(
                        topPostsTexts[index],
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      value: index,
                      groupValue: topPostSelectedIndex,
                      onChanged: (int? value) {
                        setModalState2(() {
                          topPostSelectedIndex = value!;
                        });
                        setPostSort(topPostSelectedIndex, true);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BottomModalBtn(
            iconData: selectedIconData,
            mainText: (mainSelectedIndex < mainSortTexts.length - 1)
                ? selectedMainText
                : selectedTopPostText,
            onPressed: () => selectPostSortModal(),
            selection: selectedMainText),
        PostFeed(
            postCategory: (mainSelectedIndex < mainSortTexts.length - 1)
                ? currMainPostCategory
                : currTopPostCategory),
      ],
    );
  }
}
