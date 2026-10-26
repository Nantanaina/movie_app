import 'package:dio/dio.dart';

// 1
const String movieAPIUrl = 'https://api.themoviedb.org/3/';
// 2
const trendingUrl = 'trending/movie/week';
const nowPlayingUrl = 'movie/now_playing';
const topRatedUrl = 'movie/top_rated';
const popularUrl = 'movie/popular';
const pageParameterName = 'page';
const movieIdParameterName = 'movie_id';
const apiKeyParameterName = 'api_key';
const movieUrl = 'movie';
const videosParameter = 'videos';
const creditsParameter = 'credits';
const genreUrl = 'genre/movie/list';
const searchMovieUrl = 'search/movie';
const discoverMovieUrl = 'discover/movie';
const configurationUrl = 'configuration';
const queryParameterName = 'query';
const genreParameterName = 'with_genres';

class MovieAPIService {
  late final Dio dio;
  final String apiKey;
  final showDebugInfo = false;

  MovieAPIService(this.apiKey);

  Future init() async {
    configureDio();
  }

  void configureDio() {
    final options = BaseOptions(
      baseUrl: movieAPIUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    dio = Dio(options);
    dio.interceptors.add(
      // 1
      InterceptorsWrapper(
        // 2
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // 3
          final queryParameters = options.queryParameters;
          queryParameters[apiKeyParameterName] = apiKey;
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        // 4
        onError: (DioException error, ErrorInterceptorHandler handler) {
          return handler.next(error);
        },
      ),
    );
    // 5
    if (showDebugInfo) {
      dio.interceptors.add(LogInterceptor(
        responseBody: true, // Whether to log the response body (can be large)
        error: true, // Whether to log errors
        request: true, // Whether to log requests
        requestHeader: true, // Whether to log request headers
        responseHeader: true, // Whether to log response headers
      ));
    }
  }

  Future<Response> getTrending([int page = 1]) async {
    final response =
        await dio.get(trendingUrl, queryParameters: {pageParameterName: page});
    return response;
  }

  Future<Response> getNowPlaying([int page = 1]) async {
    final response = await dio
        .get(nowPlayingUrl, queryParameters: {pageParameterName: page});
    return response;
  }

  Future<Response> getTopRated([int page = 1]) async {
    final response =
        await dio.get(topRatedUrl, queryParameters: {pageParameterName: page});
    return response;
  }

  Future<Response> getPopular([int page = 1]) async {
    final response =
        await dio.get(popularUrl, queryParameters: {pageParameterName: page});
    return response;
  }

  Future<Response> getMovieDetails(int movieId) async {
    return dio.get('$movieUrl/$movieId');
  }

  Future<Response> getMovieVideos(int movieId) async {
    return dio.get('$movieUrl/$movieId/$videosParameter');
  }

  Future<Response> getMovieCredits(int movieId) async {
    return dio.get('$movieUrl/$movieId/$creditsParameter');
  }

  Future<Response> getGenres() async {
    final response = await dio.get(genreUrl);
    return response;
  }

  Future<Response> searchMovies(String query, [int page = 1]) async {
    return dio
        .get(searchMovieUrl, queryParameters: {queryParameterName: query});
  }

  Future<Response> searchMoviesByGenre(String genre, [int page = 1]) async {
    return dio.get(discoverMovieUrl, queryParameters: {
      genreParameterName: genre,
      pageParameterName: page
    });
  }

  Future<Response> getMovieConfiguration() async {
    return dio.get(configurationUrl);
  }
}