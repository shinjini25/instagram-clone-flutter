import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/methods/storage_methods.dart';
import 'package:uuid/uuid.dart';

class LikesMethods {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('ig-posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('ig-posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<int> numberOfLikes(List likes) async {
    int noOflikes = 0;
    try {
      noOflikes = likes.length;
    } catch (err) {
      noOflikes = 0;
    }
    return noOflikes;
  }

}

