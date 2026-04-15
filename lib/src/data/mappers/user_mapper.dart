import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';

abstract final class UserMapper {
  static UsersResponseEntity toResponseEntity(UsersResponseModel model) {
    return UsersResponseEntity(
      users: model.users?.map(toEntity).toList(),
      total: model.total,
      skip: model.skip,
      limit: model.limit,
    );
  }

  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      firstName: model.firstName,
      lastName: model.lastName,
      maidenName: model.maidenName,
      age: model.age,
      gender: _parseGender(model.gender),
      email: model.email,
      phone: model.phone,
      username: model.username,
      password: model.password,
      birthDate: model.birthDate,
      image: model.image,
      bloodGroup: model.bloodGroup,
      height: model.height,
      weight: model.weight,
      eyeColor: model.eyeColor,
      hair: model.hair != null
          ? HairEntity(color: model.hair!.color, type: model.hair!.type)
          : null,
      ip: model.ip,
      address: model.address != null ? _toAddressEntity(model.address!) : null,
      macAddress: model.macAddress,
      university: model.university,
      bank: model.bank != null ? _toBankEntity(model.bank!) : null,
      company: model.company != null ? _toCompanyEntity(model.company!) : null,
      ein: model.ein,
      ssn: model.ssn,
      userAgent: model.userAgent,
      crypto: model.crypto != null ? _toCryptoEntity(model.crypto!) : null,
      role: _parseRole(model.role),
    );
  }

  static AddressEntity _toAddressEntity(AddressModel model) {
    return AddressEntity(
      address: model.address,
      city: model.city,
      state: model.state,
      stateCode: model.stateCode,
      postalCode: model.postalCode,
      coordinates: model.coordinates != null
          ? CoordinatesEntity(
              lat: model.coordinates!.lat,
              lng: model.coordinates!.lng,
            )
          : null,
      country: model.country,
    );
  }

  static BankEntity _toBankEntity(BankModel model) {
    return BankEntity(
      cardExpire: model.cardExpire,
      cardNumber: model.cardNumber,
      cardType: model.cardType,
      currency: model.currency,
      iban: model.iban,
    );
  }

  static CompanyEntity _toCompanyEntity(CompanyModel model) {
    return CompanyEntity(
      department: model.department,
      name: model.name,
      title: model.title,
      address: model.address != null ? _toAddressEntity(model.address!) : null,
    );
  }

  static CryptoEntity _toCryptoEntity(CryptoModel model) {
    return CryptoEntity(
      coin: model.coin,
      wallet: model.wallet,
      network: model.network,
    );
  }

  static Gender? _parseGender(String? value) {
    if (value == null) return null;
    for (final g in Gender.values) {
      if (g.name == value.toLowerCase()) return g;
    }
    return null;
  }

  static Role? _parseRole(String? value) {
    if (value == null) return null;
    for (final r in Role.values) {
      if (r.name == value.toLowerCase()) return r;
    }
    return null;
  }
}
