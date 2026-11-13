# Timbre iOS Architecture & Design

This document details the architectural decisions and layer separation used in Timbre iOS to ensure scalability and prevent spaghetti code across complex audio, streaming, and metadata pipelines.

---

## 1. Architectural Principles

1. **Unidirectional Data Flow:** State flows down from Riverpod providers to widgets. User events flow up as method calls to Notifiers.
2. **Strict Layer Boundary:**
   - **UI** never accesses network APIs, database instances, or player platform channels directly.
   - **Domain** models and interfaces are pure Dart—zero dependencies on Flutter UI or specific third-party client libraries.
   - **Data** repositories and providers implement domain interfaces and handle caching, parsing, and I/O.
   - **Services** encapsulate hardware/platform bridges (`just_audio`, `audio_service`, lock-screen media controls).
3. **Provider Agnostic:** Whether audio comes from Music Assistant (WebSocket), Subsonic (REST), or on-device files (iOS Files/iCloud), all sources implement the exact same `AudioSourceProvider` contract.

---

## 2. Layer Diagram

```
                 ┌─────────────────────────────────────────┐
                 │         Presentation / UI Layer         │
                 │   (Cover Flow, Player Sheet, Views)     │
                 └────────────────────┬────────────────────┘
                                      │ Watches State
                 ┌────────────────────▼────────────────────┐
                 │       Riverpod State Notifiers          │
                 │   (PlaybackNotifier, LibraryNotifier)   │
                 └─────────┬─────────────────────┬─────────┘
                           │                     │
        Dispatches Playback│                     │ Fetches Metadata
                           ▼                     ▼
┌────────────────────────────────────┐ ┌───────────────────────────────────┐
│     Audio Service & Engine         │ │        Data & Cache Layer         │
│   (`just_audio` + `audio_service`) │ │   (Offline SQLite / Metadata)     │
│   - Lock Screen / Dynamic Island   │ └─────────────────┬─────────────────┘
│   - Gapless FLAC/ALAC pipeline     │                   │ Implements
└────────────────────────────────────┘ ┌─────────────────▼─────────────────┐
                                       │    Unified AudioSourceProvider    │
                                       │   - Music Assistant (WebSocket)   │
                                       │   - Subsonic API (REST)           │
                                       │   - Local Files / iCloud (I/O)    │
                                       └───────────────────────────────────┘
```

---

## 3. Core Contract (`AudioSourceProvider`)

Every audio source must implement:

```dart
abstract class AudioSourceProvider {
  String get id;
  String get displayName;
  bool get supportsMultiRoom;

  Future<List<Album>> fetchAlbums({int page = 0, int limit = 50});
  Future<List<Artist>> fetchArtists();
  Future<List<Track>> fetchAlbumTracks(String albumId);
  Future<Uri> getPlaybackUri(Track track);
  Future<List<Track>> search(String query);
}
```

---

## 4. Audio Playback Pipeline & iOS Constraints

- **Background Audio:** Enabled via `UIBackgroundModes: audio` in `Info.plist`.
- **Lock Screen & Control Center:** Managed by `audio_service` with proper track metadata, artwork, scrub capability, and remote command listeners.
- **Audio Output:** Bit-perfect output via iOS AVPlayer engine wrapped by `just_audio`.
