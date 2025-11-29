import 'package:flutter/material.dart';

import '../../data/models/posts_Feed_Response.dart';

Widget buildPostItemEdite(
  PostModel model,
  context,
  VoidCallback funcationDelete,
  VoidCallback funcationEdite,
) => Card(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  elevation: 5.0,
  margin: EdgeInsets.symmetric(horizontal: 8.0),
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage('${model.media}'),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${model.title}', style: TextStyle(height: 1.4)),
                      SizedBox(width: 5.0),
                      Icon(Icons.check_circle, color: Colors.blue, size: 16.0),
                    ],
                  ),
                  Text(
                    '${model.createdAt}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 15.0),
            IconButton(
              icon: Icon(Icons.more_horiz, size: 16.0),
              onPressed: () {},
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Color.fromARGB(255, 179, 177, 177),
          ),
        ),
        Text(
          '${model.content}',
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.black, fontSize: 14, height: 1.4),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Icon(Icons.edit, size: 16.0, color: Colors.red),
                ),
                onTap: () {
                  funcationEdite();
                },
              ),
              SizedBox(width: 5.0),
              Spacer(),
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.delete, size: 16.0, color: Colors.red),
                      ],
                    ),
                  ),
                  onTap: () {
                    funcationDelete();
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Color.fromARGB(255, 179, 177, 177),
          ),
        ),
        Row(
          children: [
            Expanded(child: Text('... كتابة تعليق')),
            Row(
              children: [
                Icon(Icons.heart_broken, size: 16.0, color: Colors.red),
                SizedBox(width: 5.0),
                Text('اعجاب'),
              ],
            ),
          ],
        ),
      ],
    ),
  ),
);
