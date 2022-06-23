import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/methods/likes_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:instagram_clone/screens/comments_screen.dart';
import 'package:provider/provider.dart';
import '../models/user.dart' as model;
import '../methods/comment_methods.dart';
import '../methods/post_methods.dart';
import '../providers/user_provider.dart';
import '../utils/global_variables.dart';
import '../utils/snackbar.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLiked = false;
  int commentLen = 0;
  bool containsLikes = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }

  void getComments() async {
    //get comment length
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('ig-posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .get();

      commentLen = querySnapshot.docs.length;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    if (mounted) {
      setState(() {});
    }
  }

  void postLiked() async {
    await LikesMethods().likePost(
        widget.snap['postId'], widget.snap['uid'], widget.snap['likes']);
    setState(() {
      _isLiked = !_isLiked;
    });

    print(_isLiked);
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    // showLikedColor();
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color:
                width > webScreenSize ? secondaryColor : mobileBackgroundColor,
          ),
          borderRadius: width > webScreenSize
              ? BorderRadius.all(Radius.circular(8))
              : BorderRadius.all(Radius.circular(0))),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          //top part
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),

            //HEADER SECTION
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.snap['profImage']),
                ),
                //username
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.snap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.snap['uid'].toString() == user.uid
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shrinkWrap: true,
                                    children: [
                                      'Delete',
                                    ]
                                        .map(
                                          (e) => InkWell(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Text(e),
                                            ),
                                            onTap: () {
                                              PostMethods().deletePost(
                                                  widget.snap['postId']);
                                              Navigator.of(context).pop();
                                            },
                                            // // remove the dialog box
                                            // Navigator.of(context).pop();
                                          ),
                                        )
                                        .toList()),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.more_vert),
                      )
                    : Container(),
              ],
            ),
          ),
          //2nd row
          //IMAGE SECTION
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2),
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Image.network(widget.snap['postUrl'], fit: BoxFit.cover),
          ),

          //LIKE COMMENT SEC
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 4)),
                    IconButton(
                        onPressed: postLiked,
                        icon: Icon(
                          Icons.favorite,
                          color: _isLiked ? Colors.redAccent : Colors.white,
                        )),
                    IconButton(
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CommentScreen(
                                snap: widget.snap,
                              ),
                            )),
                        icon: Icon(Icons.comment_outlined)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.send))
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.bookmark_border)),
                ),
              )
            ],
          ),

          //CAPTION AND NUMBER OF LIKES
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1st col
                Text(
                  '${widget.snap['likes'].length} likes',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                //2nd col
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: primaryColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.snap['username'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                          text: ' ${widget.snap['caption']}',
                        ),
                      ],
                    ),
                  ),
                ),
                //3rd col
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'View all ${commentLen} comments',
                        style: const TextStyle(color: secondaryColor),
                      ),
                    ),
                  ),
                ),

                //4th col
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      style:
                          const TextStyle(color: secondaryColor, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
