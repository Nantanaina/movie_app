// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieResultsImpl _$$MovieResultsImplFromJson(Map<String, dynamic> json) =>
    _$MovieResultsImpl(
      backdropPath: json['backdrop_path'] as String?,
      id: (json['id'] as num).toInt(),
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String?,
      mediaType: json['media_type'] as String?,
      adult: json['adult'] as bool,
      title: json['title'] as String,
      originalLanguage: json['original_language'] as String,
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      popularity: (json['popularity'] as num).toDouble(),
      releaseDate: _parseDate(json['release_date'] as String?),
      video: json['video'] as bool,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
    );

Map<String, dynamic> _$$MovieResultsImplToJson(_$MovieResultsImpl instance) =>
    <String, dynamic>{
      if (instance.backdropPath case final value?) 'backdrop_path': value,
      'id': instance.id,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      if (instance.posterPath case final value?) 'poster_path': value,
      if (instance.mediaType case final value?) 'media_type': value,
      'adult': instance.adult,
      'title': instance.title,
      'original_language': instance.originalLanguage,
      'genre_ids': instance.genreIds,
      'popularity': instance.popularity,
      if (instance.releaseDate?.toIso8601String() case final value?)
        'release_date': value,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };
