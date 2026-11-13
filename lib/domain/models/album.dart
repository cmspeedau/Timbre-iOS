import 'package:flutter/foundation.dart';

@immutable
class Album {
  final String id;
  final String title;
  final String artistId;
  final String artistName;
  final int? year;
  final String? coverArtUri;
  final int trackCount;
  final Duration? totalDuration;
  final String? genre;
  final String sourceId;

  const Album({
    required this.id,
    required this.title,
    required this.artistId,
    required this.artistName,
    this.year,
    this.coverArtUri,
    this.trackCount = 0,
    this.totalDuration,
    this.genre,
    required this.sourceId,
  });

  Album copyWith({
    String? id,
    String? title,
    String? artistId,
    String? artistName,
    int? year,
    String? coverArtUri,
    int? trackCount,
    Duration? totalDuration,
    String? genre,
    String? sourceId,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      artistId: artistId ?? this.artistId,
      artistName: artistName ?? this.artistName,
      year: year ?? this.year,
      coverArtUri: coverArtUri ?? this.coverArtUri,
      trackCount: trackCount ?? this.trackCount,
      totalDuration: totalDuration ?? this.totalDuration,
      genre: genre ?? this.genre,
      sourceId: sourceId ?? this.sourceId,
    );
  }
}

@immutable
class Artist {
  final String id;
  final String name;
  final String? avatarUri;
  final int albumCount;
  final String? bio;
  final String sourceId;

  const Artist({
    required this.id,
    required this.name,
    this.avatarUri,
    this.albumCount = 0,
    this.bio,
    required this.sourceId,
  });

  Artist copyWith({
    String? id,
    String? name,
    String? avatarUri,
    int? albumCount,
    String? bio,
    String? sourceId,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUri: avatarUri ?? this.avatarUri,
      albumCount: albumCount ?? this.albumCount,
      bio: bio ?? this.bio,
      sourceId: sourceId ?? this.sourceId,
    );
  }
}
