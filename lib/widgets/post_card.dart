import 'package:flutter/material.dart';
import 'package:instagram_clone/methods/likes_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:instagram_clone/screens/comments_screen.dart';


class PostCard extends StatefulWidget {
  final snap;

  const PostCard({Key? key, required this.snap }) : super(key: key);


  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  bool _isLiked= false;
  bool containsLikes= false;


  // int noOfLikes=0;
  //
  // void showLikedColor() async {
  //   print("INIT CALLED");
  //   int likes= await LikesMethods().numberOfLikes(widget.snap['likes']);
  //
  //   if(likes >0){
  //     setState(() {
  //       containsLikes= true;
  //     });
  //   }
  //   print("LETS CHECK");
  //   print(containsLikes);
  //   // print(_isLiked);
  // }
void postLiked() async {
   await LikesMethods().likePost(widget.snap['postId'], widget.snap['uid'], widget.snap['likes']);
      setState(() {
        _isLiked= !_isLiked;

      });

      print(_isLiked);
  }
// @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // showLikedColor();
  // }

  @override
  Widget build(BuildContext context)  {
    // showLikedColor();
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10,
      ),
      child: Column(
        children: [
          //top part
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16,
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
                  padding: const EdgeInsets.only(
                    left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(widget.snap['username'], style: const TextStyle(
                          fontWeight: FontWeight.bold,
                         ),
                        ),
                    ],
                  ),
                ),
                ),
                IconButton(onPressed: () {
                  showDialog( context: context, builder: (context) {
                      return Dialog(
                        child: ListView(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                              'Report User',
                            ].map(
                                  (e) => InkWell(
                                  child: Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16),
                                    child: Text(e),
                                  ),
                                  onTap: () {
                                    // deletePost(
                                    //   widget.snap['postId']
                                    //       .toString(),
                                    // );
                                    // // remove the dialog box
                                    // Navigator.of(context).pop();
                                  }),
                            ).toList()),
                      );
                    },
                  );
                },
                    icon: Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          //2nd row
          //IMAGE SECTION
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2),
            height: MediaQuery.of(context).size.height*0.4,
            width: double.infinity,
            child: Image.network(widget.snap['postUrl'],
                fit: BoxFit.cover
            ),
          ),

          //LIKE COMMENT SEC
          Row(
            children: [
              Expanded(
                child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 4)),
                      IconButton(onPressed: postLiked, icon: Icon(Icons.favorite,  color: _isLiked ? Colors.redAccent : Colors.white,)),
                      IconButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentScreen(),)), icon: Icon(Icons.comment_outlined)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.send))
                    ],
                   ),
              ),
              Expanded(
                child: Align( alignment: Alignment.bottomRight,
                    child:  IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border)),
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
                  '${widget.snap['likes'].length} likes', style: Theme.of(context).textTheme.bodyText2,
                ),
                //2nd col
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: primaryColor),
                      children: <TextSpan>[
                        TextSpan(text: widget.snap['username'], style: TextStyle(fontWeight: FontWeight.bold,)),
                        TextSpan(text: ' ${widget.snap['caption']}',),

                      ],
                    ),
                  ),

                ),
                //3rd col
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text("View all 250 comments", style: TextStyle(color: secondaryColor),
                      ),
                    ),
                  ),
                ),

                //4th col
                Container(
                  child:  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                        DateFormat.yMMMd().format(widget.snap['datePublished'].toDate()),
                    style: TextStyle(color: secondaryColor, fontSize: 12),
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
