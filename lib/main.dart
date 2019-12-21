import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:githubsearch/blocs/github_search_bloc.dart';
import 'package:githubsearch/screens/search_form.dart';
import 'package:githubsearch/services/github_cache.dart';
import 'package:githubsearch/services/github_client.dart';
import 'package:githubsearch/services/github_repository.dart';

void main() {
  final GithubRepository _githubRepository = GithubRepository(
    GithubClient(),
    GithubCache()
  );

  runApp(App(githubRepository: _githubRepository,));
}

class App extends StatelessWidget {
  final GithubRepository githubRepository;

  const App ({Key key,@required this.githubRepository}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Search',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Github Search'),
        ),
        body: BlocProvider(
          create: (context) => GithubSearchBloc(githubRepository: githubRepository),
          child: SearchForm(),
        ),
      ),
    );
  }
}
