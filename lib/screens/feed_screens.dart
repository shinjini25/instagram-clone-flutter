import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/methods/storage_methods.dart';
// import 'package:instagram_clone/screens/comments_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/utils/select_img.dart';
import 'package:instagram_clone/utils/snackbar.dart';
// import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/widgets/post_card.dart';



class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset('assets/ig_logo.svg', color: primaryColor, height: 30,
        ),
        actions: [
          IconButton(onPressed: () {} , icon: Icon(Icons.messenger_outline,),
          ),

        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ig-posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String , dynamic>>> snapshot ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
            return ListView.builder(itemCount: snapshot.data!.docs.length,  itemBuilder: (context, index) => PostCard(
              //passing one particular doc as 'snap' to the PostCard at a time
                snap: snapshot.data!.docs[index].data()
             ),
            );
            },
      ),
    );
  }
}













//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:instagram_clone/utils/colors.dart';
// import 'package:instagram_clone/utils/global_variables.dart';
// import 'package:instagram_clone/widgets/post_carddd.dart';
//
// class FeedScreen extends StatefulWidget {
//   const FeedScreen({Key? key}) : super(key: key);
//
//   @override
//   State<FeedScreen> createState() => _FeedScreenState();
// }
//
// class _FeedScreenState extends State<FeedScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor:
//       width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
//       appBar: width > webScreenSize
//           ? null
//           : AppBar(
//         backgroundColor: mobileBackgroundColor,
//         centerTitle: false,
//         title: SvgPicture.asset(
//           'assets/ig_logo.svg',
//           color: primaryColor,
//           height: 32,
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.messenger_outline,
//               color: primaryColor,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//         builder: (context,
//             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (ctx, index) => Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: width > webScreenSize ? width * 0.3 : 0,
//                 vertical: width > webScreenSize ? 15 : 0,
//               ),
//               child: PostCard(
//                 snap: snapshot.data!.docs[index].data(),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }