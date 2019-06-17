import 'package:flutter/material.dart';
import 'package:common_github_search/common_github_search.dart';

import 'GHSearchApp.dart';

void main() {
  final GithubRepository _githubRepository = GithubRepository(
    GithubCache(),
    GithubClient(),
  );

  runApp(GHSearchApp(githubRepository: _githubRepository));
}
