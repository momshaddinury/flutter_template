import '../../domain/entities/sign_up_entity.dart';
import '../models/sign_up_model.dart';

/// Crosses the model ↔ entity seam for the sign-up flow.
class SignUpMapper {
  const SignUpMapper();

  SignUpResponseEntity toEntity(SignUpResponseModel model) {
    return SignUpResponseEntity(accessToken: model.accessToken);
  }

  SignUpRequestModel toRequestModel(SignUpRequestEntity entity) {
    return SignUpRequestModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
    );
  }
}
