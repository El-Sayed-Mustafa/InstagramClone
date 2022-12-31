import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/components/widgets.dart';
import 'package:instagram/screens/profile_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../utils/gloabl_variabels.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SizedBox(
          height: 40,
          child: Form(
            child: TextFormField(
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
              },
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.black,
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.search_outlined,
                      size: 25, color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
            ),
          ),
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => navigateTo(
                            context,
                            ProfileScreen(
                                uid: (snapshot.data! as dynamic).docs[index]
                                    ['uid'])),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['photoURL'],
                            ),
                            radius: 16,
                          ),
                          title: Text(
                            (snapshot.data! as dynamic).docs[index]['username'],
                          ),
                        ),
                      );
                    });
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('datePublished')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) => Image.network(
                    (snapshot.data! as dynamic).docs[index]['postUrl'],
                    fit: BoxFit.cover,
                  ),
                  staggeredTileBuilder: (index) => MediaQuery.of(context)
                              .size
                              .width >
                          webScreenSize
                      ? StaggeredTile.count(
                          (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
                      : StaggeredTile.count(
                          (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                );
              },
            ),
    );
  }
}
