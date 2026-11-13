# Timbre iOS Development Roadmap

This roadmap outlines the planned development sprints for Timbre iOS.

---

## Phase 1: Foundation & Audio Core
- [x] Create repository structure and clean architectural documentation.
- [ ] Initialize Flutter project scaffold with Riverpod state management.
- [ ] Configure iOS `Runner` project:
  - `UIBackgroundModes` with `audio` in `Info.plist`.
  - Audio session category set to `.playback`.
- [ ] Implement `AudioHandler` service bridging `just_audio` and `audio_service`.
- [ ] Verify background audio persistence and Lock Screen / Control Center playback controls on physical iPhone.

---

## Phase 2: Domain Layer & Local Source
- [ ] Define immutable domain models: `Track`, `Album`, `Artist`, `QueueItem`.
- [ ] Implement `AudioSourceProvider` contract.
- [ ] Build `LocalFilesProvider`:
  - Access music files via iOS Files picker (`file_picker`) and iCloud Drive.
  - Parse ID3 / FLAC metadata tags asynchronously using background isolates.
  - Cache metadata in local SQLite (`drift`) database.

---

## Phase 3: Presentation & 3D Cover Flow
- [ ] Build adaptive responsive shell:
  - **Portrait:** Modern high-density album grid + slide-up player sheet.
  - **Landscape / iPad:** Full-screen 3D Cover Flow carousel.
- [ ] Implement 3D Cover Flow:
  - Perspective transformation using `Transform` with `Matrix4`.
  - Impeller-accelerated smooth 60/120Hz scrolling.
  - Dynamic album art reflections and tactile snapping.
- [ ] Build Player Sheet with dynamic blurred background and scrubber.

---

## Phase 4: Server Connectors (Subsonic & Music Assistant)
- [ ] Implement `SubsonicProvider`:
  - REST authentication (salt + token).
  - Stream URL generation with optional transcoding parameters.
- [ ] Implement `MusicAssistantProvider`:
  - WebSocket connection for real-time queue synchronization.
  - Multi-room target selection (HomePods, AirPlay, Chromecast).
- [ ] Build server setup & source-switching onboarding UI.

---

## Phase 5: Hardware Testing & Distribution
- [ ] Set up automated testing and linting via GitHub Actions.
- [ ] Test on physical iPhone using `devicectl` / Xcode.
- [ ] Configure TestFlight distribution workflow with fastlane / GitHub Actions.
