import 'package:flutter/material.dart';
class CommentCard extends StatefulWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Row(
        children: [
          //profile photo

          CircleAvatar(
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
          radius: 20,
          ),

          //caption and date
          Expanded(
            child: Padding(padding: EdgeInsets.only(left: 15,), child:
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(text: TextSpan(
                    children: [
                       TextSpan(text: 'username', style: TextStyle(fontWeight: FontWeight.bold),),
                      TextSpan(text: '  caption to insert', ),
                      ]
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top:4),
                  child: Text('23/12/2022', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey),),)
                ],
              ),
            ),
          ),

          //like btn
          Container(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.favorite,
            size: 15,

            ),

          )
        ],
      ),
    );
  }
}
