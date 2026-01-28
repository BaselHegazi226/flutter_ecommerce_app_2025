part of 'update_image_cubit.dart';

@immutable
sealed class UpdateImageState {}

final class UpdateImageInitial extends UpdateImageState {}

final class UpdateImageLoading extends UpdateImageState {}

final class UpdateImageFailure extends UpdateImageState {
  final String errorMessage;

  UpdateImageFailure({required this.errorMessage});
}

final class UpdateImageSuccess extends UpdateImageState {
  final String imageUrl;

  UpdateImageSuccess({required this.imageUrl});
}
