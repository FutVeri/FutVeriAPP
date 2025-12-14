# Football Super App ⚽

A professional Flutter application combining **FotMob-style live match tracking** with a **football simulation game**, built with Clean Architecture, offline-first approach, and event sourcing.

## 🎯 Features

### ✅ Implemented (Live Matches Demo)
- **Live Matches Feed**: Real-time match tracking with scores, minute updates, and status badges
- **Match Detail View**: Comprehensive match information with tabbed interface
  - **Events Timeline**: Goal, cards, substitutions with player details
  - **Statistics**: Visual comparison of possession, shots, xG, corners, fouls
  - **AI Analysis Tab**: Placeholder for future AI-powered insights
- **Offline-First Architecture**: Data caching for seamless offline experience
- **Clean Architecture**: Separation of concerns with domain, data, and presentation layers
- **Event Sourcing**: All important actions logged for audit and sync

### 🚧 Coming Soon
- **Simulation Game**: Squad building, tactics, match simulation with deterministic engine
- **AI Match Analyst**: Automated match summaries and tactical insights
- **Fixtures & Leagues**: League standings, fixture calendars
- **Teams & Players**: Detailed profiles with statistics and form graphs
- **Scouting System**: Player discovery with advanced filters
- **Notifications**: Real-time alerts for goals, cards, match events
- **Admin Panel**: Debug tools, data source switching, feature flags

## 🏗️ Architecture

### Clean Architecture Layers

```
lib/
├── core/                    # Shared infrastructure
│   ├── error/              # Result<T>, Failure classes
│   ├── logging/            # Structured logging
│   ├── navigation/         # go_router configuration
│   └── theme/              # FotMob-inspired design
├── features/               # Feature modules
│   └── live_matches/       # ✅ Complete demo feature
│       ├── domain/         # Business logic
│       │   ├── entities/   # Pure Dart models
│       │   ├── repositories/  # Interfaces
│       │   └── usecases/   # Business operations
│       ├── data/           # Data layer
│       │   ├── models/     # DTOs with JSON mapping
│       │   ├── datasources/  # Remote/Local data
│       │   └── repositories/  # Implementations
│       └── presentation/   # UI layer
│           ├── viewmodels/ # Riverpod state management
│           ├── screens/    # Page widgets
│           └── widgets/    # Reusable components
└── shared/                 # Cross-feature code
    └── data/
        └── event_store/    # Event sourcing foundation
```

### Technology Stack

| Category | Technology | Justification |
|----------|-----------|---------------|
| **State Management** | Riverpod 2 | Type-safe, compile-time DI, excellent testing support |
| **Navigation** | go_router | Declarative routing, deep linking support |
| **Local Database** | Isar | 🚀 **Fastest** NoSQL for Flutter, perfect for offline-first |
| **Networking** | Dio | Interceptors, error handling, request cancellation |
| **Error Handling** | Dartz | Functional programming with `Result<T>` monad |
| **Logging** | Logger | Structured logging with pretty printing |

### Why Isar over Drift?

✅ **Performance**: 10x faster for large datasets (critical for match events)  
✅ **Offline-First**: Native complex queries without SQL  
✅ **Type-Safe**: Full type safety with code generation  
✅ **Event Sourcing**: Optimized for append-only event logs  
✅ **Zero Config**: Works seamlessly with Riverpod  

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `>=3.10.0`
- Dart SDK: `>=3.10.0`

### Installation

```bash
# Clone the repository
cd /Users/emremert/Documents/GitHub/FutVeriAPP/futveri

# Install dependencies
flutter pub get

# Generate code (Isar schemas)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Project Structure Commands

```bash
# Generate code (after modifying Isar entities)
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on changes)
dart run build_runner watch

# Clean build
flutter clean && flutter pub get && dart run build_runner build --delete-conflicting-outputs
```

## 📱 Demo Features

### Live Matches Screen
- Pull-to-refresh for latest data
- Live status badges (LIVE, HT, FT)
- Team logos and scores
- Match minute indicator
- Bottom navigation to other features

### Match Detail Screen
- **Events Tab**: Timeline of goals, cards, substitutions
- **Stats Tab**: Visual comparison bars for:
  - Possession percentage
  - Shots and shots on target
  - Expected Goals (xG)
  - Corners and fouls
- **AI Tab**: Coming soon placeholder

### Mock Data
The app includes realistic mock data:
- **Premier League**: Man City vs Liverpool
- **La Liga**: Barcelona vs Real Madrid
- **Bundesliga**: Bayern Munich vs Borussia Dortmund
- **Süper Lig**: Galatasaray vs Fenerbahçe 🇹🇷

## 🎨 Design Philosophy

### FotMob-Inspired UI
- **Dark Mode First**: Sleek dark theme as default
- **Clean Cards**: Minimal elevation, rounded corners
- **Live Indicators**: Green badges for live matches
- **Visual Stats**: Progress bars for easy comparison
- **Responsive**: Optimized for all screen sizes

### Color Palette
```dart
Primary Green:    #00D9A3  // Live indicators, CTAs
Dark Background:  #0D1117  // Main background
Dark Surface:     #161B22  // Cards, elevated surfaces
Dark Card:        #21262D  // Nested cards
Accent Red:       #FF4757  // Errors, red cards
Accent Yellow:    #FFA502  // Warnings, yellow cards
```

## 🧪 Testing Strategy

### Unit Tests
```bash
# Run all unit tests
flutter test

# Run specific feature tests
flutter test test/features/live_matches/
```

### Test Coverage
- ✅ Domain entities (Equatable equality)
- ✅ Use cases (business logic)
- ✅ Repository implementations (error handling)
- 🚧 ViewModels (state management)
- 🚧 Widget tests (UI components)

## 📊 Event Sourcing

All important actions are logged as events:

```dart
// Example events
MatchSynced          // Live data fetched
GoalEventReceived    // Goal scored
UserFavoritedTeam    // User action
SimMatchPlayed       // Simulation completed
AiInsightGenerated   // AI analysis created
```

Events are stored in Isar with:
- Type, timestamp, actor
- JSON payload
- Correlation ID for tracking
- Sync status for remote backup

## 🔮 Roadmap

### Phase 1: Core Features (Current)
- [x] Live Matches with mock data
- [x] Match detail with events and stats
- [x] Clean Architecture foundation
- [x] Event sourcing setup
- [ ] Isar caching layer

### Phase 2: Simulation Engine
- [ ] Squad builder UI
- [ ] Deterministic match simulation
- [ ] Player attributes and form
- [ ] xG calculation engine
- [ ] Comprehensive unit tests

### Phase 3: AI Integration
- [ ] AI analysis repository
- [ ] Match insight generation
- [ ] Input sanitization
- [ ] Output caching and versioning

### Phase 4: Additional Features
- [ ] Fixtures and leagues
- [ ] Team and player profiles
- [ ] Scouting system
- [ ] Push notifications
- [ ] Admin/debug panel

## 🤝 Contributing

This is a professional demonstration project. Key principles:

1. **SOLID Principles**: Single responsibility, dependency inversion
2. **Clean Architecture**: Clear separation of layers
3. **Offline-First**: Cache everything, sync when online
4. **Type Safety**: Leverage Dart's type system
5. **Error Handling**: Use `Result<T>` for all operations
6. **Logging**: Structured logs for debugging

## 📄 License

This project is for educational and demonstration purposes.

---

**Built with ❤️ using Flutter and Clean Architecture**

For questions or feedback, check the implementation plan in `.gemini/antigravity/brain/*/implementation_plan.md`
