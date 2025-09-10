## Architecture Overview

- **State Management:** Provider is used for app-wide state, with a ChangeNotifier for business data and UI states.
- **Networking:** Dio is included for future extensibility, but local JSON is loaded via rootBundle for demo. Networking logic is isolated in the provider.
- **Domain Model:** Messy keys from the source JSON are normalized and validated in the Business model factory constructor.
- **UI:** BusinessCard is a reusable, generic widget. It can be composed for other models (e.g., ServiceCard) via the GenericCard<T> pattern.
- **Persistence:** shared_preferences caches the business list after first load, enabling offline access. Provider checks cache before loading assets.
- **Error/Loading/Empty States:** All major UI states are handled with clear feedback and retry options.

## Key Trade-offs

- **Dio for local data:** Used for consistency with requirements, but not strictly necessary for asset loading. Would be more useful for remote APIs.
- **shared_preferences for caching:** Simple and cross-platform, but not ideal for large or complex data. For more robust offline support, consider Hive or SQLite.
- **UI Composition:** GenericCard enables flexible reuse, but more advanced composition (e.g., via interfaces or mixins) could improve scalability.

## Improvements with More Time

- Add unit and widget tests for provider, model validation, and UI states.
- Use a more robust local database (Hive/SQLite) for persistence.
- Add pagination, search, and filtering to the business list.
- Improve error handling with more granular messages and logging.
- Refactor networking to support remote APIs and async updates.
- Enhance UI with animations, theming, and accessibility features.
