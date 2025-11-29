import 'package:flutter/material.dart';
import 'package:social_app/features/posts/presentation/widget/post_item.dart';

import '../../data/models/posts_Feed_Response.dart';

class SearchPosts extends SearchDelegate<String> {
  List<PostModel> postModel;
  final List<String> history;

  SearchPosts({required this.postModel, required this.history});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isEmpty)
        IconButton(
          icon: const Icon(Icons.mic, color: Colors.black),
          onPressed: () {
            query = 'implement voice input';
          },
        )
      else
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = postModel
        .where(
          (post) => post.content.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "لم يتم العثور على نتائج",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => buildPostItem(results[index], context),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("ابدأ بالبحث عن بوست", style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }

    final suggestions = postModel
        .where((post) => post.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) =>
          buildPostItem(suggestions[index], context),
    );
  }
}
