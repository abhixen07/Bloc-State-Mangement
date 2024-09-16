import 'package:equatable/equatable.dart';  // Importing Equatable for state equality comparison
import 'package:image_picker/image_picker.dart';  // Importing ImagePicker to handle image picking

// ImagePickerStates class extends Equatable to enable easy equality checks and immutability
class ImagePickerStates extends Equatable{

  // A nullable XFile object to store the selected image
  final XFile? file;

  // Constructor for ImagePickerStates with the file parameter being optional (null by default)
  const ImagePickerStates({
    this.file
  });

  // The copyWith method creates a new instance of ImagePickerStates with updated values
  // It uses the current state's file if a new one is not provided
  ImagePickerStates copyWith({XFile? file}){
    return ImagePickerStates(
        file: file ?? this.file  // If no new file is passed, it keeps the old one
    );
  }

  @override
  // List of properties used to determine state equality
  // Equatable uses this to optimize rebuilds when the state hasn't actually changed
  List<Object?> get props => [file];
}
