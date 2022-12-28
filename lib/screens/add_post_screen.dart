import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    /*  return Center(
      child: IconButton(
        icon: const Icon(Icons.upload),
        onPressed: () {

        },
      ),
    );*/

    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          title: const Text('Post to'),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Post',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/110793510?s=400&u=f5747c7e44ce456de2a7fa241c702cbbb1630703&v=4'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: const TextField(
                          decoration: InputDecoration(
                              hintText: 'Wirte a caption ...',
                              border: InputBorder.none),
                          maxLines: 8,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(
                            'https://avatars.githubusercontent.com/u/110793510?s=400&u=f5747c7e44ce456de2a7fa241c702cbbb1630703&v=4'),
                        fit: BoxFit.fill,
                      )),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
