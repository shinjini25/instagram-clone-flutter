// <!--- function: uploadImageToStorage (acts as helper function)---!>
// <!--- @param: childname, Uint8List file, isPost ---!>
// <!--- role: creates a location in firebase storage and stores the file using putData fun ---!>
// <!--- return type: Future<String> ; returns a downloadable url ---!>

// <!--- directory structure for posts ---  ig-posts/CurrentUser.userUid/Imguid ---!>
// <!-- link between users and their posts -> the storage directory of posts will be according to the user uid  ---!>

import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';


class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    //if its for profile photo, user cna have only 1 pic corresponding to 1 uid therefore no more child is required
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    //if storage is for post directory structure will be different
    //since one user can have multiple posts linked to one uid (user)
    if(isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}