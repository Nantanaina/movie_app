import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_data/movie_data.dart';
import 'package:flutter_application_1/providers.dart';
import 'package:flutter_application_1/router/app_routes.dart';
import 'package:flutter_application_1/ui/movie_viewmodel.dart';
import 'package:flutter_application_1/ui/theme/theme.dart';
import 'package:flutter_application_1/ui/widgets/movie_widget.dart';
import 'package:flutter_application_1/ui/widgets/not_ready.dart';
import 'home_screen_image.dart';
import 'horiz_movies.dart';
import 'title_row.dart';

@RoutePage(name: 'HomeRoute')
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late MovieViewModel movieViewModel;
  Future<List<MovieResponse?>>? movieFuture;

  @override
  Widget build(BuildContext context) {
    final movieViewModelAsync = ref.watch(movieViewModelProvider);
    return movieViewModelAsync.when(
      error: (e, st) => Text(e.toString()),
      loading: () => const NotReady(),
      data: (viewModel) {
        movieViewModel = viewModel;
        return buildScreen();
      },
    );
  }

  Widget buildScreen() {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: loadData(),
          builder: (context, snapshot) {
            if ((snapshot.connectionState != ConnectionState.active) &&
                (snapshot.connectionState != ConnectionState.done)) {
              return const NotReady();
            }
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    color: screenBackground,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 24),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Now Playing', style: largeTitle),
                          ),
                        ),
                        HomeScreenImage(
                          movieViewModel: movieViewModel,
                          onMovieTap: onMovieTap,
                        ),
                        TitleRow(
                          text: 'Trending',
                          onMoreClicked: () {
                            context.router.push(
                              MovieListingRoute(movieType: MovieType.trending),
                            );
                          },
                        ),
                        HorizontalMovies(
                          movies: movieViewModel.trendingMovies,
                          onMovieTap: onMovieTap,
                          movieType: MovieType.trending,
                        ),
                        TitleRow(
                          text: 'Popular',
                          onMoreClicked: () {
                            context.router.push(
                              MovieListingRoute(movieType: MovieType.popular),
                            );
                          },
                        ),
                        HorizontalMovies(
                          movies: movieViewModel.popularMovies,
                          onMovieTap: onMovieTap,
                          movieType: MovieType.popular,
                        ),
                        TitleRow(
                          text: 'Top rated',
                          onMoreClicked: () {
                            context.router.push(
                              MovieListingRoute(movieType: MovieType.topRated),
                            );
                          },
                        ),
                        HorizontalMovies(
                          movies: movieViewModel.topRatedMovies,
                          onMovieTap: onMovieTap,
                          movieType: MovieType.topRated,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void onMovieTap(int movieId) {
    context.router.push(MovieDetailRoute(movieId: movieId));
  }

  Future loadData() async {
    movieFuture ??= Future.wait([
      movieViewModel.getTrendingMovies(1),
      movieViewModel.getTopRated(1),
      movieViewModel.getPopular(1),
      movieViewModel.getNowPlaying(1),
    ]);
    return movieFuture;
  }
}
