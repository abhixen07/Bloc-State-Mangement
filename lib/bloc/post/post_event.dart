import 'package:equatable/equatable.dart';

/// Abstract class representing all post-related events
/// Extends Equatable to allow value comparison for event instances
abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event to indicate that posts should be fetched from the API
class PostFetched extends PostEvent {}
