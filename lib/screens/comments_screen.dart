import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../widgets/comment_card.dart';
class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text('Comments'),

      ),
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          padding: EdgeInsets.only(left: 15, right: 12),
          child: Row(
            children:  [
              //photo
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 17,
              ),
              //add comment
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment..',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              //post btn
              InkWell(
                onTap: () {},
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Text("Post", style: TextStyle(color: Colors.blueAccent,
                    ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
