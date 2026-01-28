import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/use_cases/profile_use_cases.dart';

part 'update_image_state.dart';

class UpdateImageCubit extends Cubit<UpdateImageState> {
  UpdateImageCubit(this.uploadImageToCloudniaryUseCase)
    : super(UpdateImageInitial());
  final UploadImageToCloudniaryUseCase uploadImageToCloudniaryUseCase;

  Future<void> pickUploadImage() async {
    emit(UpdateImageLoading());
    final result = await uploadImageToCloudniaryUseCase.call();
    result.fold(
      (error) {
        emit(UpdateImageFailure(errorMessage: error.errorKey ?? 'unknown'));
      },
      (successImagePath) {
        emit(UpdateImageSuccess(imageUrl: successImagePath));
      },
    );
  }
}
