import 'package:flutter/material.dart';

/// [PostContent] : class of the content textfield 

class PostContent extends StatefulWidget {

  final GlobalKey<FormState> formKey;
  final Function(String) onChanged;
  final String hintText;
  final String? initialBody;

  const PostContent({
    required this.formKey,
    required this.onChanged,
    required this.hintText,
    this.initialBody,
  });

  @override
  State<PostContent> createState() => _PostcontentState();
}

class _PostcontentState extends State<PostContent> {

  late TextEditingController _controller;
  
   @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text:widget.initialBody);
    _controller.addListener(() {
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
    return Container(
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
    );
  }
}

