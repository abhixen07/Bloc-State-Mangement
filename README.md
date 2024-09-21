## BLoC State Management

This project utilizes the **BLoC (Business Logic Component)** state management pattern to handle the application's logic and state. BLoC separates the business logic from the UI, making the app more scalable and easier to test.

### Key Benefits of BLoC:
- **Separation of Concerns**: Keeps the UI code clean and focuses on the business logic separately, improving maintainability.
- **Reactive Programming**: It uses streams and events to update the UI reactively when the data or state changes.
- **Testability**: Business logic is isolated in the BLoC layer, making it easier to write unit tests.
  
### How it Works:
1. **Events**: Users interact with the UI, and these interactions (e.g., button presses) trigger events.
2. **BLoC**: The BLoC listens for these events and handles the business logic.
3. **State**: The BLoC then outputs new states based on the logic, and the UI reacts to these changes by rebuilding.

This project uses the `flutter_bloc` package to implement BLoC, making it easier to structure and manage the app's state.
