import 'package:bloc_state/bloc/counter/counter_bloc.dart';  // Import the Counter Bloc
import 'package:bloc_state/bloc/image_picker/image_picker_bloc.dart';  // Import the Image Picker Bloc
import 'package:bloc_state/bloc/switch_example/switch_bloc.dart';  // Import the Switch Bloc
import 'package:bloc_state/equatable_test_state.dart';  // Import for state equality check (using Equatable)
import 'package:bloc_state/ui/counter_screen.dart';  // Import UI for the counter screen
import 'package:bloc_state/ui/image_picker_screen.dart';  // Import UI for the image picker screen
import 'package:bloc_state/ui/switch_example_screen.dart';  // Import UI for the switch example screen
import 'package:bloc_state/utils/image_picker_utils.dart';  // Import utility class for image picker
import 'package:flutter/material.dart';  // Import Flutter material widgets
import 'package:flutter_bloc/flutter_bloc.dart';  // Import Flutter BLoC package for state management

void main() {
  // The entry point of the application
  runApp(const MyApp());
}

// The root widget of your application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Our widget tree starts with MaterialApp. We access all the Blocs inside it.
    // Here, we're using BlocProviders to provide multiple Blocs to the widget tree.

    // Using MultiBlocProvider for providing multiple BLoC instances to the widget tree.
    return MultiBlocProvider(
      providers: [
        // Providing SwitchBloc to the widget tree
        BlocProvider(
          create: (context) => SwitchBloc(),
        ),
        // Providing CounterBloc to the widget tree
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
        // Providing ImagePickerBloc with ImagePickerUtils to the widget tree
        BlocProvider(
          create: (context) => ImagePickerBloc(ImagePickerUtils()),
        ),
      ],
      // Wrapping the MaterialApp with MultiBlocProvider
      child: MaterialApp(
        // App title
        title: 'Flutter Demo',
        // Theme configuration for the application
        theme: ThemeData(
          // Creating a color scheme using a seed color
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,  // Opting in for Material 3 design
        ),
        // Setting the home screen to the ImagePickerScreen
        home: const ImagePickerScreen(),
      ),
    );
  }
}
