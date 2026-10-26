import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_data/movie_data.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

Widget addVerticalSpace(double amount) {
  return SizedBox(height: amount);
}

Widget addHorizontalSpace(double amount) {
  return SizedBox(width: amount);
}

enum Sorting {
  aToz(name: 'A-Z'),
  zToa(name: 'Z-A'),
  rating(name: 'Rating'),
  year(name: 'Year');

  const Sorting({required this.name});
  final String name;
}

String youtubeUrlFromId(String videoId) {
  return 'https://www.youtube.com/watch?v=$videoId';
}

typedef OnMovieTap = void Function(int movieId);

typedef OnMovieVideoTap = void Function(MovieVideo video);

typedef OnFavoriteResultsTap = void Function(DBFavorite favorite);

typedef OnMovieResultsTap = void Function(MovieResults movie);

const Widget emptyWidget = SizedBox.shrink();

enum ImageSize { small, large }

String imageUrl(String baseUrl, String size, String file) =>
    '$baseUrl$size$file';

String? getSizedImageUrl(
    ImageSize size, MovieConfiguration configuration, String? file) {
  if (file == null) {
    return null;
  }
  switch (size) {
    case ImageSize.small:
      return imageUrl(
          configuration.images.secureBaseUrl, configuration.images.posterSizes[1], file);
    case ImageSize.large:
      return imageUrl(
          configuration.images.secureBaseUrl, configuration.images.posterSizes[5], file);
  }
}

String? getMovieDetailsImagePath(
    MovieDetails details, MovieConfiguration configuration) {
  return getSizedImageUrl(
      ImageSize.large, configuration, details.backdropPath);
}

final yearFormat = DateFormat('yyyy');

String youtubeImageFromId(String videoId) {
  return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
}

bool isWeb() {
  return kIsWeb;
}

bool isDesktop() {
  if (kIsWeb) {
    return false;
  }
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

bool isMobile() {
  if (kIsWeb) {
    return false;
  }
  return Platform.isIOS || Platform.isAndroid;
}

bool isMac() {
  if (kIsWeb) {
    return false;
  }
  return Platform.isMacOS;
}

bool isWindows() {
  if (kIsWeb) {
    return false;
  }
  return Platform.isWindows;
}