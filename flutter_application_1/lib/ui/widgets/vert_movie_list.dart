import 'package:flutter/material.dart';
import 'package:movie_data/movie_data.dart';
import 'package:flutter_application_1/ui/movie_viewmodel.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'movie_row.dart';

class VerticalMovieList extends StatelessWidget {
  final List<MovieResults> movies;
  final MovieViewModel movieViewModel;
  final OnMovieTap onMovieTap;
  const VerticalMovieList({
    super.key,
    required this.movies,
    required this.movieViewModel,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: movies.length,
        (BuildContext context, int index) {
          return MovieRow(
            movie: movies[index],
            movieViewModel: movieViewModel,
            onMovieTap: (movie) {
              onMovieTap(movie.id);
            },
          );
        },
      ),
    );
  }
}