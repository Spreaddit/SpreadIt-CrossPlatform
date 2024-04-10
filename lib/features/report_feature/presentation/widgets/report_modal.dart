import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/report_feature/data/api_report.dart';
import 'package:spreadit_crossplatform/features/report_feature/data/violation_and_sub_violations.dart';
import 'package:spreadit_crossplatform/features/report_feature/presentation/widgets/main_report_option.dart';
import 'package:spreadit_crossplatform/features/report_feature/presentation/widgets/main_report_section.dart';
import 'package:spreadit_crossplatform/features/report_feature/presentation/widgets/modal_bottom_bar.dart';
import 'package:spreadit_crossplatform/features/report_feature/presentation/widgets/sub_report_section.dart';

class ReportModal {
  ReportModal(this.buildContext, this.communityName, this.postId,
      this.commentId, this.isReportingPost) {
    mainViolations.addAll([
      "Breaks r/$communityName rules",
      "Harassment",
      "Threatening Violence",
      "Hate",
      "Minor abuse or sexualization",
      "Sharing personal information",
      "Non-consensual intimate media",
      "Prohibited transaction",
      "Impersonation",
      "Copyright Violation",
      "Trademark Violation",
      "Self-harm or suicide",
      "Spam"
    ]);

    extraText.addAll([
      'Posts, comments, or behavior that breaks r/$communityName rules',
      'Harassing, bullying, intimidationg, or abusing an individual or group of people with the result of discouraging them from participating.',
      'Encouraging, glorifying or inciting violence or physical harm againts individuals or groups of people, places, or animals.',
      'Promoting hate or inciting violence based on identity or vulnerability.',
      'Sharing or soliciting content involving abuse, neglect, or sexualization of minors or any predatory or inappropriate behavior towards minors.',
      'Sharing or threatening to share private, personal, or confidential information about someone.',
      'Sharing, threatening to share, or soliciting intimate or sexually-explicit content of someone without their consent (including fake or "lookalike" pornography).',
      'Soliciting or facilitating transactions or gifts of illegal or prohibited goods and services.',
      'Impersonating an individual or entity in a misleading or deceptive way. This includes deepfakes, manipulated content, or false attributions.',
      'Content posted to Reddit that infringes a copyright you own or control. (Note: Only the copyright owner or an authorized representative can submit a report.)',
      'Content posted to Reddit that infringes a trademark you own or control. (Note: Only the trademark owner or an authorized representative can submit a report.)',
      'Behavior or comments that make you think someone may be considering suicide or seriously hurting themselves.',
      'Repeated, unwanted, or unsolicited manual or automated actions that negatively affect redditors, communities, and the Reddit platform.',
    ]);

    hasSubReasons = List.generate(
      mainViolations.length,
      (int index) => (index == 3 || index == 7 || index == 11) ? false : true,
      growable: false,
    );

    showMainPage(buildContext);
  }

  BuildContext buildContext;
  String communityName;
  String postId;
  String commentId;
  bool isReportingPost;
  var selectedIndex = -1;
  var selectedSubIndex = -1;
  final List<String> mainViolations = [];
  final List<String> extraText = [];
  List<MainReportOption> mainReportOptions = [];
  List<bool> hasSubReasons = [];

  void generateMainReports(StateSetter setModalState) {
    mainReportOptions = List.generate(
      mainViolations.length,
      (int index) => MainReportOption(
        communityName: communityName,
        optionText: mainViolations[index],
        index: index,
        onSelect: () {
          setModalState(() {
            selectedIndex = index;
          });
        },
        selectedContainerIndex: selectedIndex,
        optionHasImage: (index == 0) ? true : false,
      ),
      growable: false,
    );
  }

  void showMainPage(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            generateMainReports(setModalState);
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppBar(
                      title: Text("Submit a Report"),
                    ),
                    MainReportSection(mainReportOptions: mainReportOptions),
                    ModalBottomBar(
                      extraTextTitle: (selectedIndex != -1)
                          ? mainViolations[selectedIndex]
                          : '',
                      extraText:
                          (selectedIndex != -1) ? extraText[selectedIndex] : '',
                      buttonText:
                          (selectedIndex == -1 || hasSubReasons[selectedIndex])
                              ? 'Next'
                              : 'Submit Report',
                      onPressed: (selectedIndex == -1)
                          ? null
                          : () {
                              if (hasSubReasons[selectedIndex]) {
                                showSecondPage(context);
                              } else {
                                report(context);
                              }
                            },
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void showSecondPage(BuildContext context) {
    selectedSubIndex = -1;
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppBar(
                      title: Text("Submit a Report"),
                    ),
                    SubReportSection(
                      communityName: communityName,
                      selectedIndex: selectedIndex,
                      onIndexChange: (int newSubVal) {
                        setModalState(() {
                          selectedSubIndex = newSubVal;
                        });
                      },
                    ),
                    ModalBottomBar(
                      buttonText: "Submit Report",
                      onPressed: () {
                        report(context);
                      },
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  void showDonePage(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.blueAccent,
                        size: 45,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Thanks for your report",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                        softWrap: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Thanks again for your report and for looking out for yourself and your fellow redditors.\nYour reporting helps make Reddit a better, safer and more welcoming place for everyone; and it means a lot to us.",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        softWrap: true,
                      ),
                    ),
                    Spacer(),
                    ModalBottomBar(
                      buttonText: "Done",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  void report(BuildContext context) async {
    int response;
    var postRequestInfo = {
      "reason": mainViolations[selectedIndex],
      "sureason": (hasSubReasons[selectedIndex] && selectedSubIndex != -1)
          ? violationsList[selectedIndex]["subViolations"][selectedSubIndex]
          : ""
    };
    if (isReportingPost) {
      response =
          await reportPostRequest(postId, postRequestInfo: postRequestInfo);
    } else {
      response = await reportCommentRequest(postId, commentId,
          postRequestInfo: postRequestInfo);
    }
    bool reportSuccessful = (response == 200);
    if (reportSuccessful) {
      Navigator.pop(context);
      if (hasSubReasons[selectedIndex]) {
        Navigator.pop(context);
      }
      showDonePage(context);
    } else {
      CustomSnackbar(content: "Failed to report").show(context);
    }
  }
}
