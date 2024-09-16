import 'package:bloc/bloc.dart';
import 'package:bloc_state/bloc/image_picker/image_picker_event.dart';
import 'package:bloc_state/bloc/image_picker/image_picker_state.dart';
import 'package:bloc_state/utils/image_picker_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

// BLoC class for handling image picking events (either from the camera or gallery).
class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerStates> {

  // Utility class to handle the actual image picking logic.
  final ImagePickerUtils imagePickerUtils;

  // Constructor that initializes the utility class and sets the initial state.
  // It also listens for specific events like CameraCapture and GalleryImageCapture.
  ImagePickerBloc(this.imagePickerUtils) : super(ImagePickerStates()) {

    // Register the event handler for capturing an image from the camera.
    on<CameraCapture>(cameraCapture);

    // Register the event handler for picking an image from the gallery.
    on<GalleryImageCapture>(pickImageFromGallery);
  }

  // Function to handle capturing an image using the camera.
  // It is called when a CameraCapture event is emitted.
  // The image is picked using the ImagePickerUtils, and the new state is emitted with the file.
  Future<void> cameraCapture(CameraCapture event, Emitter<ImagePickerStates> states) async {
    XFile? file = await imagePickerUtils.cameraCapture();  // Use utility to capture image
    emit(state.copyWith(file: file));  // Emit new state with the captured image file
  }

  // Function to handle picking an image from the gallery.
  // It is called when a GalleryImageCapture event is emitted.
  // The image is picked using the ImagePickerUtils, and the new state is emitted with the file.
  Future<void> pickImageFromGallery(GalleryImageCapture event, Emitter<ImagePickerStates> states) async {
    XFile? file = await imagePickerUtils.cameraCapture();  // Use utility to capture image from gallery
    emit(state.copyWith(file: file));  // Emit new state with the selected image file
  }
}
