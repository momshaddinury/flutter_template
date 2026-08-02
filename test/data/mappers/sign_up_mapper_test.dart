import 'package:flutter_template/src/data/mappers/sign_up_mapper.dart';
import 'package:flutter_template/src/data/models/sign_up_model.dart';
import 'package:flutter_template/src/domain/entities/sign_up_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mapper = SignUpMapper();

  group('SignUpMapper', () {
    test('maps the request entity onto the snake_case wire model', () {
      final entity = SignUpRequestEntity(
        firstName: 'A',
        lastName: 'B',
        email: 'a@x',
        password: 'pw',
      );

      final model = mapper.toRequestModel(entity);

      expect(model.toJson(), {
        'first_name': 'A',
        'last_name': 'B',
        'email': 'a@x',
        'password': 'pw',
      });
    });

    test('maps the response model onto the entity', () {
      final model = SignUpResponseModel.fromJson({'access_token': 'a.tok'});

      expect(mapper.toEntity(model).accessToken, 'a.tok');
    });
  });
}
