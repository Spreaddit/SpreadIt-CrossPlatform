import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/interaction_button.dart';
import 'package:video_player/video_player.dart';

/*
TODO: create options tab for PostWidget(shows join community options when pressed)

class PostOptions extends StatefulWidget {
bool isJoinCommunityVisible;
}
*/

/// This widget is responsible for displaying post header:
/// (e.g., user info and date of posting)
class _PostHeader extends HookWidget {
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

/// This widget is responsible for displaying post body:
/// headline, description (optional) and an image (optional)
class _PostBody extends StatelessWidget {
  final String title;
  final String postType;
  final String? content;
  final List<Attachment>? attachments;
  final String? link;
  final bool isFullView;
  //TODO: Handle poll display

  _PostBody({
    required this.title,
    required this.postType,
    this.content,
    this.attachments,
    this.link,
    required this.isFullView,
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
          link: link,
          isFullView: isFullView,
        ),
      ),
    );
  }
}

class _PostContent extends StatelessWidget {
  final String postType;
  final String? content;
  final List<Attachment>? attachments;
  final String? link;
  final bool isFullView;
  //TODO: Handle poll display

  _PostContent({
    required this.postType,
    required this.isFullView,
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
        overflow: TextOverflow.ellipsis,
        maxLines: !isFullView ? 5 : null,
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
          return VideoPlayerScreen(videoURL: attachments![0].link);
        }
      } else {
        CustomSnackbar(content: "No Attachments Found").show(context);
        print("Error fetching attachments from back");
        return Text("Unable to load attachments");
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
      return Text("Handle Poll Here");
      //TODO:HANDLE POLL CREATION
    }
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoURL;

  const VideoPlayerScreen({
    Key? key,
    required this.videoURL,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Duration videoLength;
  late Duration videoPosition;
  late double volume = 0.5;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoURL),
    )
      ..addListener(() => setState(() {
            videoPosition = _controller.value.position;
          }))
      ..initialize().then((_) => setState(() {
            videoLength = _controller.value.duration;
          }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attachment Video',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (_controller.value.isInitialized) ...[
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  padding: EdgeInsets.all(10),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(_controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                    ),
                    Text(
                        '${convertToMinutesSeconds(videoPosition)} / ${convertToMinutesSeconds(videoLength)}'),
                    SizedBox(width: 10),
                    Icon(animatedVolumeIcon(volume)),
                    Slider(
                      value: volume,
                      min: 0,
                      max: 1,
                      onChanged: (_volume) => setState(() {
                        volume = _volume;
                        _controller.setVolume(_volume);
                      }),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(
                          Icons.loop,
                          color: _controller.value.isLooping
                              ? const Color.fromARGB(255, 255, 68, 0)
                              : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller
                                .setLooping(!_controller.value.isLooping);
                          });
                        }),
                  ],
                )
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

String convertToMinutesSeconds(Duration duration) {
  final parsedMinutes = duration.inMinutes < 10
      ? '0${duration.inMinutes}'
      : duration.inMinutes.toString();

  final seconds = duration.inSeconds % 60;

  final parsedSeconds =
      seconds < 10 ? '0${seconds % 60}' : (seconds % 60).toString();
  return '$parsedMinutes:$parsedSeconds';
}

IconData animatedVolumeIcon(double volume) {
  if (volume == 0) {
    return Icons.volume_mute;
  } else if (volume < 0.5) {
    return Icons.volume_down;
  } else {
    return Icons.volume_up;
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
          profilePic: post.userProfilePic,
          community: post.community,
        ),
        _PostBody(
          title: post.title,
          content: post.content.isNotEmpty
              ? post.content[post.content.length - 1]
              : "",
          attachments: post.attachments,
          link: post.link,
          postType: post.type,
          isFullView: isFullView,
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
