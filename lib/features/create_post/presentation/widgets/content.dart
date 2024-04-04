import 'package:flutter/material.dart';

class PostContent extends StatefulWidget {

  final GlobalKey<FormState> formKey;
  final Function(String) onChanged;
  final String hintText;

  const PostContent({
    required this.formKey,
    required this.onChanged,
    required this.hintText,
  });

  @override
  State<PostContent> createState() => _PostcontentState();
}

class _PostcontentState extends State<PostContent> {

  late TextEditingController _controller;
  
   @override
  void initState() {
    super.initState();
    print('PostContent initState');
    _controller = TextEditingController();
    print(_controller);
    print('controller initialized');
    _controller.addListener(() {
      print('PostContent onChanged listener');
      setState(() {
        widget.onChanged(_controller.text);
      });
    });
  }

 @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:Container(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
          child:SingleChildScrollView(
            child: TextFormField(  
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 20,
                ),
            ),
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 15,
            ),
            controller: _controller,
            ),
          ),
        ),
        );
  }
}

/*
TODOs:
1) ashouf 7war el kalam el underlined da 
2) a7ot el controller wel kalam da
*/