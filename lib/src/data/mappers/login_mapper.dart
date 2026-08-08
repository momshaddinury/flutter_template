import '../../domain/entities/login_entity.dart';
import '../models/login_model.dart';

/// Crosses the model ↔ entity seam for the login flow. Formatting
/// (trimming, date parsing) belongs here, so entities receive finished
/// values and models stay wire-shaped.
///
/// The response mapping deliberately drops the tokens: the repository
/// persists them through `TokenManager`, and they never cross into the
/// domain layer.
class LoginMapper {
  const LoginMapper();

  LoginResponseEntity toEntity(LoginResponseModel model) {
    return LoginResponseEntity(
      id: model.id,
      username: model.username,
      email: model.email,
      firstName: model.firstName,
      lastName: model.lastName,
      gender: model.gender,
      image: model.image,
    );
  }
}
