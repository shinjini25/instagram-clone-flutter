// <!--- function: uploadPost ---!>
// <!--- @param:   Uint8List file,
//         String caption,
//         String uid,
//         String username,
//         String profImage ---!>
// <!--- role: creates a collection in firestore db "ig-posts" according to post model and
//           contains the access url for the post photo given by firebase storage after the photo is uploaded using uploadImageToStorage fun --!>
// <!--- return type: Future<String> ; returns a result (success/failure)---!>

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/methods/storage_methods.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:uuid/uuid.dart';

class PostMethods {
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;
  //upload post
    Future<String> uploadPost(
        Uint8List file,
        String caption,
        String uid,
        String username,
        String profImage
        ) async {
      String res= "some error occured!";
      try{
          String url= await StorageMethods().uploadImageToStorage('postPhotos', file, true);
          String postId= const Uuid().v1();

          Post post = Post(
          caption: caption,
            uid: uid,
            username: username,
            postId:  postId,
            likes: [],
            datePublished: DateTime.now(),
            postUrl: url,
            profImage: profImage,

          );
          //creating a new collection 'ig-posts' to save the post model
          _firestore.collection('ig-posts').doc(postId).set(post.toJson());
          res= "success";

      } catch(e){
        res= e.toString();
      }
      return res;
    }

}