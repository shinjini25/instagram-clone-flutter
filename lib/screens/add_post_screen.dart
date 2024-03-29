import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/select_img.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/snackbar.dart';
import 'package:provider/provider.dart';
import '../methods/post_methods.dart';
import '../models/user.dart' as model;
import '../models/user.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool _isLoading = false;
  final TextEditingController _captionController = TextEditingController();

  //<!---------   FUNCTION   ---------!>
  void userPost(String uid, String username, String profImg) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String res = await PostMethods()
          .uploadPost(_file!, _captionController.text, uid, username, profImg);
      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, 'Posted!');
        clearPostScreen();
      } else {
        setState(() {
          _isLoading = false;
        });
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'Some error occured. Try again later!');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //clear the post screen after the psot is succesfully done
  void clearPostScreen() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _captionController.dispose();
  }

  _selectUpload(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a Post"),
            children: [
              //camera
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              //gallery
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),

              //cancel
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                //text
                Text("Create a new Post",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                SizedBox(height: 8),
                //uplaod btn
                Center(
                    child: IconButton(
                  icon: const Icon(
                    Icons.upload,
                    size: 50,
                  ),
                  onPressed: () => _selectUpload(context),
                )),
              ]))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearPostScreen,
              ),
              title: const Text("Post to"),
              actions: [
                TextButton(
                    onPressed: () =>
                        userPost(user.uid, user.username, user.photoUrl),
                    child: const Text(
                      "Post",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ))
              ],
            ),
            body: Column(children: [
              _isLoading
                  ? const LinearProgressIndicator()
                  : const Padding(padding: EdgeInsets.only(top: 0)),
              const Divider(),
              // SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      user.photoUrl,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: _captionController,
                      decoration: const InputDecoration(
                        hintText: 'Write a caption..',
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: AspectRatio(
                        aspectRatio: 1.06,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )),
                  ),
                  const Divider(),
                ],
              ),
            ]),
          );
  }
}
