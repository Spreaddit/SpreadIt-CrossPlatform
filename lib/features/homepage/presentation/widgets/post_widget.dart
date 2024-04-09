import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/interaction_button.dart';
import 'package:video_player/video_player.dart';

//TODO: create options tab for PostWidget(shows join community options when pressed)

// class PostOptions extends StatefulWidget {
// bool isJoinCommunityVisible;
// }

/// This widget is responsible for displaying post header:
/// (e.g., user info and date of posting)
class _PostHeader extends HookWidget {
  //Add Community and add username in postcard
  final String username;
  final String userId;
  final DateTime date;
  final String profilePic;
  final String community;
  //TODO:final PostOptions options;

  _PostHeader({
    required this.username,
    required this.userId,
    required this.date,
    required this.profilePic,
    required this.community,
    //TODO:required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final sec30PassedToggler =
        useState(false); //used for changing time without constant re-render
    final dateFormatted = useState(dateToDuration(date));

    useEffect(() {
      dateFormatted.value = dateToDuration(date);
      print(dateFormatted.value);
      return;
    }, [sec30PassedToggler.value]);

    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 30), (timer) {
        sec30PassedToggler.value = !sec30PassedToggler.value;
      });

      return timer.cancel;
    }, []);

    return Material(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ListTile(
          contentPadding: EdgeInsets.only(top: 20),
          title: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(dateFormatted.value),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(profilePic),
          ),
          trailing: Icon(Icons.more_horiz),
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4', //TODO:change parse link
      ),
    );

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Complete the code in the next step.
    return Container();
  }
}

class _PostContent extends StatelessWidget {
  final String postType;
  final String? content;
  final List<Attachment>? attachments;
  final String? link;
  //TODO: Handle poll display

  _PostContent({
    required this.postType,
    this.content,
    this.attachments,
    this.link,
  });

  @override
  Widget build(BuildContext context) {
    if (postType == "post") {
      return Text(
        content != null && content!.isNotEmpty
            ? content![content!.length - 1]
            : "",
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      );
    } else if (postType == "attachment") {
      if (attachments!.isNotEmpty) {
        if (attachments![0].type == "image") {
          return CarouselSlider(
            options: CarouselOptions(height: 400.0),
            items: attachments!.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Image(image: NetworkImage(i.link)),
                  );
                },
              );
            }).toList(),
          );
        } else {
          //HANDLE VIDEOS
        }
      }
    } else if (postType == "link") {
      return AnyLinkPreview(
        link: link ?? "",
        displayDirection: UIDirection.uiDirectionHorizontal,
        bodyMaxLines: 5,
        bodyTextOverflow: TextOverflow.ellipsis,
        titleStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      );
    } else {
      //TODO:HANDLE POLL CREATION
    }
  }
}

/// This widget is responsible for displaying post body:
/// headline, description (optional) and an image (optional)
class _PostBody extends StatelessWidget {
  final String title;
  final String postType;
  final String? content;
  final List<Attachment>? attachments;
  final String? link;
  //TODO: Handle poll display

  _PostBody({
    required this.title,
    required this.postType,
    this.content,
    this.attachments,
    this.link,
    //TODO: Handle poll display
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: ListTile(
        dense: true,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        subtitle: _PostContent(
            postType: postType,
            content: content,
            attachments: attachments,
            link: link),
      ),
    );
  }
}

/// This widget is responsible for displaying post interactions bottom bar
/// count of shares, upvotes and comments is displayed here.
class _PostInteractions extends HookWidget {
  final int votesCount;
  final int sharesCount;
  final int commentsCount;

  _PostInteractions({
    required this.votesCount,
    required this.sharesCount,
    required this.commentsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            VoteButton(
              initialVotesCount: votesCount,
            ),
            CommentButton(
              initialCommensCount: commentsCount,
            ),
            ShareButton(
              initialSharesCount: sharesCount,
            ),
          ],
        ),
      ),
    );
  }
}

/// This widget takes an instance of [Post] as a paremeter
/// and returns a postcard with its relevant info
class PostWidget extends StatelessWidget {
  final Post post;
  final bool isFullView;

  PostWidget({
    required this.post,
    this.isFullView = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PostHeader(
          username: post.username,
          userId: post.userId,
          date: post.date,
          profilePic: post.profilePic,
          community: post.community,
        ),
        _PostBody(
          title: post.title,
          content: post.content != null && post.content!.isNotEmpty
              ? post.content![post.content!.length - 1]
              : "",
          attachments: post.attachments,
          link: post.link,
          postType: post.type,
          //TODO: handle poll details
        ),
        _PostInteractions(
          votesCount: post.votesUpCount - post.votesDownCount,
          sharesCount: post.sharesCount,
          commentsCount: post.commentsCount,
        )
      ],
    );
  }
}
