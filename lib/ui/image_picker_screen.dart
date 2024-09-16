import 'dart:io';  // Import required for working with files

import 'package:bloc_state/bloc/image_picker/image_picker_bloc.dart';  // Import for the ImagePickerBloc
import 'package:bloc_state/bloc/image_picker/image_picker_event.dart'; // Import for events like CameraCapture
import 'package:bloc_state/bloc/image_picker/image_picker_state.dart'; // Import for ImagePickerStates
import 'package:flutter/material.dart';  // Import Flutter material widgets
import 'package:flutter_bloc/flutter_bloc.dart';  // Import for Bloc integration

// Stateful widget for the image picker screen
class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

// State class for ImagePickerScreen
class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Bloc'),  // Title of the screen
      ),
      body: Center(
        // BlocBuilder listens for state changes in ImagePickerBloc
        child: BlocBuilder<ImagePickerBloc, ImagePickerStates>(
          builder: (context, state) {
            // Check if the state has no file selected yet
            if (state.file == null) {
              return InkWell(
                // When tapped, emit the CameraCapture event to trigger the camera
                onTap: () {
                  context.read<ImagePickerBloc>().add(CameraCapture());
                },
                child: const CircleAvatar(
                  child: Icon(Icons.camera),  // Placeholder icon when no image is selected
                ),
              );
            } else {
              // If an image is selected, display the file
              return Image.file(File(state.file!.path.toString()));
            }
          },
        ),
      ),
    );
  }
}
