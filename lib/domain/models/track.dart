/// Represents the technical signal path and quality of an audio track.
class AudioFormat {
  final String codec; // FLAC, ALAC, AAC, MP3, DSD, WAV
  final int? bitDepth; // 16, 24, 32
  final int? sampleRate; // e.g. 44100, 96000, 192000
  final int? bitRate; // in kbps
  final bool isHiRes;
  final bool isLossless;

  const AudioFormat({
    required this.codec,
    this.bitDepth,
    this.sampleRate,
    this.bitRate,
    this.isHiRes = false,
    this.isLossless = true,
  });

  String get displayQuality {
    if (bitDepth != null && sampleRate != null) {
      final khz = (sampleRate! / 1000).toStringAsFixed(sampleRate! % 1000 == 0 ? 0 : 1);
      return '$bitDepth-bit / ${khz}kHz $codec';
    }
    if (bitRate != null) {
      return '${bitRate}kbps $codec';
    }
    return codec.toUpperCase();
  }

  Map<String, dynamic> toJson() => {
    'codec': codec,
    'bitDepth': bitDepth,
    'sampleRate': sampleRate,
    'bitRate': bitRate,
    'isHiRes': isHiRes,
    'isLossless': isLossless,
  };

  factory AudioFormat.fromJson(Map<String, dynamic> json) => AudioFormat(
    codec: json['codec'] as String? ?? 'UNKNOWN',
    bitDepth: json['bitDepth'] as int?,
    sampleRate: json['sampleRate'] as int?,
    bitRate: json['bitRate'] as int?,
    isHiRes: json['isHiRes'] as bool? ?? false,
    isLossless: json['isLossless'] as bool? ?? false,
  );
}

/// Represents a single audio track in the unified Timbre ecosystem.
class Track {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String? albumArtist;
  final Duration duration;
  final String streamUri;
  final String? artworkUri;
  final int? trackNumber;
  final int? discNumber;
  final int? year;
  final AudioFormat format;
  final String providerId; // 'local', 'subsonic', 'music_assistant'
  final Map<String, dynamic> customMetadata;

  const Track({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    this.albumArtist,
    required this.duration,
    required this.streamUri,
    this.artworkUri,
    this.trackNumber,
    this.discNumber,
    this.year,
    required this.format,
    required this.providerId,
    this.customMetadata = const {},
  });

  Track copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? albumArtist,
    Duration? duration,
    String? streamUri,
    String? artworkUri,
    int? trackNumber,
    int? discNumber,
    int? year,
    AudioFormat? format,
    String? providerId,
    Map<String, dynamic>? customMetadata,
  }) {
    return Track(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      albumArtist: albumArtist ?? this.albumArtist,
      duration: duration ?? this.duration,
      streamUri: streamUri ?? this.streamUri,
      artworkUri: artworkUri ?? this.artworkUri,
      trackNumber: trackNumber ?? this.trackNumber,
      discNumber: discNumber ?? this.discNumber,
      year: year ?? this.year,
      format: format ?? this.format,
      providerId: providerId ?? this.providerId,
      customMetadata: customMetadata ?? this.customMetadata,
    );
  }
}
