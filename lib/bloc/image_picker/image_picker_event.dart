import 'package:equatable/equatable.dart';  // Importing Equatable for event equality comparison

// Abstract base class for all ImagePickerEvents, extending Equatable to enable equality checks
abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();  // Constructor for the event, which can be extended by specific event types

  @override
  // The props list is used by Equatable to determine if two instances of the event are equal
  List<Object> get props => [];
}

// Event class to handle capturing an image from the camera
class CameraCapture extends ImagePickerEvent {}

// Event class to handle selecting an image from the gallery
class GalleryImageCapture extends ImagePickerEvent {}
