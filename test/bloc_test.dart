import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:githubsearch/bloc/github_search_event.dart';
import 'package:githubsearch/bloc/github_search_state.dart';
import 'package:githubsearch/blocs/github_search_bloc.dart';
import 'package:githubsearch/services/github_repository.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements GithubRepository {}

void main() {
  group('github search bloc', () {
    GithubSearchBloc githubSearchBloc;
    MockRepository githubRepository;

    setUp(() {
      githubRepository = MockRepository();
      githubSearchBloc = GithubSearchBloc(githubRepository: githubRepository);
    });

    tearDown(() {
      githubSearchBloc?.close();
    });

    test('initial state is correct', () {
      expect(githubSearchBloc.initialState, SearchStateEmpty());
    });

    test('close does not emit new state', () {
      expectLater(
        githubSearchBloc,
        emitsInOrder([SearchStateEmpty(), emitsDone])
      );
      githubSearchBloc.close();
    });

    blocTest(
      'emit [SearchStateEmpty()] when nothing is added',
      build: () => githubSearchBloc,
      expect: [SearchStateEmpty()] 
    );

    blocTest(
      'emit [SearchStateEmpty(), SearchStateLoading()] when TextChanged() is added',
      build: () => githubSearchBloc,
      act: (bloc) => bloc.add(TextChanged('flutter')),
      expect: [SearchStateLoading()]
    );
  });

}