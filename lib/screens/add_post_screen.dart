import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/select_img.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../models/user.dart' as model;
import '../models/user.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}


class _AddPostScreenState extends State<AddPostScreen> {

  Uint8List? _file;
  final TextEditingController _captionController = TextEditingController();

  _selectUpload(BuildContext context) async {
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(
        title: const Text("Create a Post"),
        children: [
          //camera
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Take a photo"),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera,);
              setState(() {
                _file= file;
              });
            },
          ),
          //gallery
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Choose from gallery"),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery,);
              setState(() {
                _file= file;
              });
            },
          ),

          //cancel
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Cancel"),
            onPressed: ()  {
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

    return _file == null? Center(
      child: IconButton(
        icon: Icon(Icons.upload),
        onPressed: () => _selectUpload(context),
      )
    ): Scaffold(
      appBar: AppBar(
            backgroundColor: mobileBackgroundColor,
            leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {},),
              title: Text("Post to"),
            actions: [
              TextButton(onPressed: () {}, child: const Text("Post", style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),))
           ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: TextField(
                  controller: _captionController,
                  decoration: InputDecoration(
                    hintText: 'Write a caption..',
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              Container(
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
                    )
                  ),
              ),
              const Divider(),
            ],
          ),

        ]
      ),


      );
  }
}
