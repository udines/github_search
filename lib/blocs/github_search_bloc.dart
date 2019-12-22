import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:githubsearch/bloc/github_search_event.dart';
import 'package:githubsearch/bloc/github_search_state.dart';
import 'package:githubsearch/models/search_result.dart';
import 'package:githubsearch/models/search_result_error.dart';
import 'package:githubsearch/services/github_repository.dart';
import 'package:rxdart/rxdart.dart';

class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  GithubSearchBloc({@required this.githubRepository});

  final GithubRepository githubRepository;

  @override
  Stream<GithubSearchState> transformEvents(
    Stream<GithubSearchEvent> events, 
    Stream<GithubSearchState> Function(GithubSearchEvent event) next
  ) {
    return super.transformEvents(
      (events as Observable<GithubSearchEvent>).debounceTime(
        const Duration(milliseconds: 500)
      ),
      next
    );
  }

  @override
  void onTransition(Transition<GithubSearchEvent, GithubSearchState> transition) {
    print(transition);
  }

  @override
  Stream<GithubSearchState> mapEventToState(GithubSearchEvent event) async* {
    if (event is TextChanged) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          final SearchResult results = await githubRepository.search(searchTerm);
          yield SearchStateSuccess(results.items);
        } catch(error) {
          yield error is SearchResultError
            ? SearchStateError(error.message, error.details)
            : const SearchStateError('Something went wrong', '');
        }
      }
    }
  }

  @override
  GithubSearchState get initialState => SearchStateEmpty();
}