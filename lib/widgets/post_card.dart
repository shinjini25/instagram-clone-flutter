import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';


class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10,
      ),
      child: Column(
        children: [
          //top part
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16,
            ).copyWith(right: 0),

            //HEADER SECTION
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80'),
                ),
                //username
                Expanded(
                  child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                        Text('username', style: TextStyle(
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
            child: Image.network('https://images.unsplash.com/photo-1569498286839-55f1a0766292?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                fit: BoxFit.cover
            ),
          ),

          //LIKE COMMENT SEC
          Row(
            children: [
              Expanded(
                child: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.comment_outlined)),
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
                  '1,234 likes', style: Theme.of(context).textTheme.bodyText2,
                ),
                //2nd col
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: primaryColor),
                      children: <TextSpan>[
                        TextSpan(text: 'username', style: TextStyle(fontWeight: FontWeight.bold,)),
                        TextSpan(text: '  hey this is a comment!',),

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
                  child: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text("1 day ago", style: TextStyle(color: secondaryColor, fontSize: 12),
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
