part of 'emortion_cubit.dart';

abstract class EmortionState {}

class EmortionInitial extends EmortionState {}

class LoadingEmortionState extends EmortionState {}

class ErrorEmortionState extends EmortionState {
  final String message;
  ErrorEmortionState(this.message);
}

class ResponseEmortionState extends EmortionState {
  final List<Emortion> emortion;
  ResponseEmortionState(this.emortion);
}
