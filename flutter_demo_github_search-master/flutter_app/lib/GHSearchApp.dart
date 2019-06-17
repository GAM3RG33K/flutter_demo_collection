import 'package:flutter/material.dart';
import 'package:common_github_search/common_github_search.dart';
import 'search/search_form.dart';

class GHSearchApp extends StatelessWidget {
  final GithubRepository githubRepository;

  const GHSearchApp({
    Key key,
    @required this.githubRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Search',
      home: Scaffold(
        appBar: AppBar(title: Text('Github Search')),
        body: SearchForm(
          githubRepository: githubRepository,
        ),
      ),
    );
  }
}
