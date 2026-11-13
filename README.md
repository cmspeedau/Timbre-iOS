# Timbre iOS (Flutter)

A modern, high-fidelity music player client built in Flutter for iOS. Timbre combines Roon-grade metadata and playback features with the flexibility of open protocols and serverless local file playback — **100% free and open-source forever**, with zero paywalls, subscriptions, or ads.

## Core Philosophy: 100% Free & Open-Source (No Paywalls)

Many popular iOS audio players lock fundamental audiophile features (background audio, lock-screen controls, EQ/DSP, and lossless streaming) behind monthly subscriptions or paywalls. 

**Timbre takes the opposite stance:**
- **Zero Paywalls:** All features — including bit-perfect background audio, multi-room casting, and DSP — are free for everyone.
- **No Ads or Telemetry:** Pure, direct connection to your own media sources and local files.
- **Open Standards:** Built on open protocols (Subsonic/OpenSubsonic API, Music Assistant WebSockets, local document storage).

---

## Key Features

- **Multi-Source Architecture:**
  - **Music Assistant:** Real-time multi-room playback, queue management, and synchronization via WebSockets.
  - **Subsonic / Navidrome / LMS:** High-performance REST streaming and caching.
  - **Serverless / Local Files:** Direct playback from iOS Files app, iCloud Drive, or local storage.
- **Audiophile Audio Pipeline:**
  - Bit-perfect lossless playback (FLAC, ALAC, WAV, AAC) using `just_audio` + native `AVPlayer`.
  - Full system integration via `audio_service`: Lock Screen media controls, Control Center, and Dynamic Island.
  - Unlocked background audio playback (`UIBackgroundModes: audio`) out of the box.
- **Fluid 3D Cover Flow:**
  - 60–120Hz perspective album browsing in landscape mode and on iPadOS powered by Flutter's Impeller Metal rendering engine.
- **Anti-Spaghetti Clean Architecture:**
  - Strict decoupling between UI, state management (Riverpod), audio services, and pluggable source providers.

---

## Architecture Overview

```
                  ┌─────────────────────────────────────┐
                  │      Presentation / UI Layer        │
                  │  (Cover Flow, Player Sheet, Views)  │
                  └──────────────────┬──────────────────┘
                                     │ Watches State / Triggers Events
                  ┌──────────────────▼──────────────────┐
                  │   State Management (Riverpod)       │
                  │ (PlaybackNotifier, LibraryNotifier) │
                  └───────┬──────────────────────┬──────┘
                          │                      │
       Calls Domain APIs  │                      │ Dispatches Commands
                          ▼                      ▼
┌───────────────────────────────────┐  ┌───────────────────────────────────┐
│     Audio Engine / Services       │  │       Domain & Data Layer         │
│ (just_audio + audio_service)      │  │ (Repositories, Models, Cache)     │
│  - Lock screen / Dynamic Island   │  └─────────────────┬─────────────────┘
│  - Gapless Lossless Pipeline      │                    │ Calls Interface
└───────────────────────────────────┘  ┌─────────────────▼─────────────────┐
                                       │    Unified AudioSourceProvider    │
                                       │   (Music Assistant, Subsonic,     │
                                       │    Local Storage, WebDAV/SMB)     │
                                       └───────────────────────────────────┘
```

For complete architectural details, see [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

---

## Project Structure

```text
lib/
├── app.dart                    # MaterialApp, dark theme configuration, router
├── main.dart                   # Application bootstrap and service initialization
├── core/                       # Shared constants, design tokens, error handlers
│   ├── constants/
│   ├── errors/
│   └── theme/
├── domain/                     # Pure Dart entities and abstract provider interfaces
│   ├── models/                 # Track, Album, Artist, AudioFormat, QueueItem
│   └── providers/              # AudioSourceProvider contract
├── data/                       # Concrete provider implementations and offline cache
│   ├── database/               # Local metadata cache (SQLite / Drift)
│   └── providers/              # LocalFilesProvider, SubsonicProvider, MusicAssistantProvider
├── services/                   # Native audio bridge and background handlers
│   └── audio/                  # just_audio & audio_service integration
└── presentation/               # UI components and view controllers
    ├── coverflow/              # 3D Cover Flow Carousel widget
    ├── player/                 # Bottom sheet player, scrubber, volume control
    ├── library/                # Grid and list views for albums/artists
    └── settings/               # Provider setup and configuration
```

---

## Getting Started

### Prerequisites

- macOS with **Xcode 15+** installed
- **Flutter SDK** (3.24 or later)
- CocoaPods (`brew install cocoapods`)
- An iPhone running **iOS 16+** (or iOS Simulator)

### Local Setup & Testing

1. Clone the repository:
   ```bash
   git clone https://github.com/cmspeedau/Timbre-iOS.git
   cd Timbre-iOS
   ```

2. Generate iOS Runner files (if cloning fresh):
   ```bash
   flutter create --platforms=ios .
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   cd ios && pod install && cd ..
   ```

4. Enable Developer Mode on your iPhone:
   - On device: **Settings > Privacy & Security > Developer Mode** (toggle ON and reboot).

5. Run on your physical iPhone or Simulator:
   ```bash
   flutter devices
   flutter run -d <your-device-id>
   ```

---

## Roadmap

See [docs/ROADMAP.md](docs/ROADMAP.md) for milestone tracking and upcoming phases.

---

## License

GPL-3.0 or MIT (Open Source).
