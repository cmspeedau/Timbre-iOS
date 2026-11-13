import '../models/album.dart';
import '../models/artist.dart';
import '../models/track.dart';

/// Contract for all audio backend integrations (Music Assistant, Subsonic, Local Files, etc.).
///
/// Keeps the domain and presentation layers completely decoupled from network or storage specifics,
/// eliminating spaghetti code and making testing and swapping backends seamless.
abstract class AudioSourceProvider {
  /// Unique identifier for the provider (e.g. 'music_assistant', 'subsonic', 'local_files')
  String get id;

  /// User-visible name
  String get displayName;

  /// Whether this backend supports multi-room grouping / zone control
  bool get supportsMultiRoom;

  /// Fetch paginated albums
  Future<List<Album>> fetchAlbums({int page = 0, int limit = 50});

  /// Fetch all artists
  Future<List<Artist>> fetchArtists();

  /// Fetch tracks belonging to an album
  Future<List<Track>> fetchAlbumTracks(String albumId);

  /// Resolves the playable stream URI for [track] (e.g., file:// or authenticated https:// stream)
  Future<Uri> getPlaybackUri(Track track);

  /// Search across artist, album, and track metadata
  Future<List<Track>> search(String query);
}
