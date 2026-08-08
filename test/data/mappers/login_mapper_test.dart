import 'package:flutter_template/src/data/mappers/login_mapper.dart';
import 'package:flutter_template/src/data/models/login_model.dart';
import 'package:flutter_template/src/domain/entities/login_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mapper = LoginMapper();

  group('LoginMapper', () {
    test('maps every user field of the response model onto the entity', () {
      final model = LoginResponseModel(
        id: 1,
        username: 'alice',
        email: 'a@x',
        firstName: 'A',
        lastName: 'B',
        gender: 'female',
        image: 'https://x/y.png',
        accessToken: 'a.tok',
        refreshToken: 'r.tok',
      );

      final entity = mapper.toEntity(model);

      expect(entity.id, 1);
      expect(entity.username, 'alice');
      expect(entity.email, 'a@x');
      expect(entity.firstName, 'A');
      expect(entity.lastName, 'B');
      expect(entity.gender, 'female');
      expect(entity.image, 'https://x/y.png');
    });

    test('maps the request entity onto the wire model', () {
      final entity = LoginRequestEntity(
        username: 'alice',
        password: 'pw',
        shouldRemember: true,
      );

      final model = mapper.toRequestModel(entity);

      expect(model.toJson(), {'username': 'alice', 'password': 'pw'});
    });
  });
}
