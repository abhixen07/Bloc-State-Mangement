import 'package:image_picker/image_picker.dart'; // Importing ImagePicker package

// A utility class to handle image picking from the camera and gallery
class ImagePickerUtils {

  // Creating an instance of ImagePicker to access the device's camera and gallery
  final ImagePicker _picker = ImagePicker();

  // Method to capture an image using the device's camera
  Future<XFile?> cameraCapture() async {
    // Using ImagePicker to pick an image from the camera
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);

    // Returning the captured image as an XFile object or null if no image is selected
    return file;
  }

  // Method to pick an image from the device's gallery
  Future<XFile?> pickImageFromGallery() async {
    // Using ImagePicker to pick an image from the gallery
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    // Returning the picked image as an XFile object or null if no image is selected
    return file;
  }
}
