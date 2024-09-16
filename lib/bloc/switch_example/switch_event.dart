import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
abstract class SwitchEvents  extends Equatable{
  const SwitchEvents();

  @override
  List<Object?> get props => [ ];


}

class EnableDisableNotification extends SwitchEvents{}


class SliderEvent extends SwitchEvents{
  double slider;
  SliderEvent({required this.slider});
  @override
  List<Object> get props => [slider];
}