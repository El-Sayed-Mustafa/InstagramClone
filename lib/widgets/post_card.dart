import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final snap;

  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(snap['profImage']);

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(snap['porfImage'] == null
                      ? snap['profImage']
                      : snap['profImage']),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap['username'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/icons8-instagram-verification-badge.svg',
                        height: 16,
                      ),
                    ],
                  ),
                )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: ListView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: [
                                    'Delete',
                                  ]
                                      .map((e) => InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                              child: Text(e),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ));
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          SizedBox(
            child: Image.network(
              snap['postUrl'],
              fit: BoxFit.fill,
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 29,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mode_comment_outlined,
                    size: 27,
                  )),
              Transform.rotate(
                  angle: -45 * pi / 180,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, left: 5),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.send,
                          size: 25,
                        )),
                  )),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_outline_outlined,
                    size: 32,
                  )),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                  child: Text(
                    '90,985,256 likes',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: primaryColor),
                          children: [
                        TextSpan(
                            text: snap['username'],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: '  ',
                        ),
                        TextSpan(
                          text: snap['description'],
                        ),
                      ])),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: const Text(
                      'View all 2,021,200 comments',
                      style: TextStyle(fontSize: 15, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd().format(snap['datePublished'].toDate()),
                    style: TextStyle(fontSize: 12, color: secondaryColor),
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
