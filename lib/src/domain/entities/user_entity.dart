enum Gender { female, male, other }

enum Role { admin, moderator, user }

class UserEntity {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? maidenName;
  final int? age;
  final Gender? gender;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;
  final String? birthDate;
  final String? image;
  final String? bloodGroup;
  final double? height;
  final double? weight;
  final String? eyeColor;
  final HairEntity? hair;
  final String? ip;
  final AddressEntity? address;
  final String? macAddress;
  final String? university;
  final BankEntity? bank;
  final CompanyEntity? company;
  final String? ein;
  final String? ssn;
  final String? userAgent;
  final CryptoEntity? crypto;
  final Role? role;

  UserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.hair,
    this.ip,
    this.address,
    this.macAddress,
    this.university,
    this.bank,
    this.company,
    this.ein,
    this.ssn,
    this.userAgent,
    this.crypto,
    this.role,
  });
}

class AddressEntity {
  final String? address;
  final String? city;
  final String? state;
  final String? stateCode;
  final String? postalCode;
  final CoordinatesEntity? coordinates;
  final String? country;

  AddressEntity({
    this.address,
    this.city,
    this.state,
    this.stateCode,
    this.postalCode,
    this.coordinates,
    this.country,
  });
}

class CoordinatesEntity {
  final double? lat;
  final double? lng;

  CoordinatesEntity({this.lat, this.lng});
}

class BankEntity {
  final String? cardExpire;
  final String? cardNumber;
  final String? cardType;
  final String? currency;
  final String? iban;

  BankEntity({
    this.cardExpire,
    this.cardNumber,
    this.cardType,
    this.currency,
    this.iban,
  });
}

class CompanyEntity {
  final String? department;
  final String? name;
  final String? title;
  final AddressEntity? address;

  CompanyEntity({this.department, this.name, this.title, this.address});
}

class CryptoEntity {
  final String? coin;
  final String? wallet;
  final String? network;

  CryptoEntity({this.coin, this.wallet, this.network});
}

class HairEntity {
  final String? color;
  final String? type;

  HairEntity({this.color, this.type});
}

class UsersResponseEntity {
  final List<UserEntity>? users;
  final int? total;
  final int? skip;
  final int? limit;

  UsersResponseEntity({this.users, this.total, this.skip, this.limit});
}
