import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_communities/presentation/widgets/unmute_mute_community.dart';

class CommunityTile extends StatefulWidget {
  final Community community;
  final bool isMuted;

  const CommunityTile({
    required this.community,
    required this.isMuted,
  });

  @override
  _CommunityTileState createState() => _CommunityTileState();
}

class _CommunityTileState extends State<CommunityTile> {
  late bool _isMuted;
  late String type;

  @override
  void initState() {
    super.initState();
    _isMuted = widget.isMuted;
    _isMuted ? type = "unmute" : type = "mute";
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.community.image!),
        backgroundColor: Colors.grey,
        radius: 15.0,
        child: Icon(Icons.group),
      ),
      title: Text(widget.community.name),
      trailing: ElevatedButton(
        onPressed: () {
          setState(() {
            _isMuted ? type = "unmute" : type = "mute";
            _isMuted = !_isMuted;
          });
          mutecommunity(context, widget.community.name, type);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            _isMuted ? Colors.white : Colors.blue[900]!,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            _isMuted ? Colors.blue[900]! : Colors.white,
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(fontSize: 12),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.all(8),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: Colors.blue[900]!),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Text(_isMuted ? 'Unmute' : 'Mute'),
      ),
    );
  }
}
