import 'package:dart_mappable/dart_mappable.dart';

part 'user_model.mapper.dart';

@MappableClass(generateMethods: GenerateMethods.decode)
class UserModel with UserModelMappable {

  UserModel({
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
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? maidenName;
  final int? age;
  final String? gender;
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
  final HairModel? hair;
  final String? ip;
  final AddressModel? address;
  final String? macAddress;
  final String? university;
  final BankModel? bank;
  final CompanyModel? company;
  final String? ein;
  final String? ssn;
  final String? userAgent;
  final CryptoModel? crypto;
  final String? role;
}

@MappableClass(generateMethods: GenerateMethods.decode)
class AddressModel with AddressModelMappable {

  AddressModel({
    this.address,
    this.city,
    this.state,
    this.stateCode,
    this.postalCode,
    this.coordinates,
    this.country,
  });
  final String? address;
  final String? city;
  final String? state;
  final String? stateCode;
  final String? postalCode;
  final CoordinatesModel? coordinates;
  final String? country;
}

@MappableClass(generateMethods: GenerateMethods.decode)
class CoordinatesModel with CoordinatesModelMappable {

  CoordinatesModel({this.lat, this.lng});
  final double? lat;
  final double? lng;
}

@MappableClass(generateMethods: GenerateMethods.decode)
class BankModel with BankModelMappable {

  BankModel({
    this.cardExpire,
    this.cardNumber,
    this.cardType,
    this.currency,
    this.iban,
  });
  final String? cardExpire;
  final String? cardNumber;
  final String? cardType;
  final String? currency;
  final String? iban;
}

@MappableClass(generateMethods: GenerateMethods.decode)
class CompanyModel with CompanyModelMappable {

  CompanyModel({this.department, this.name, this.title, this.address});
  final String? department;
  final String? name;
  final String? title;
  final AddressModel? address;
}

@MappableClass(generateMethods: GenerateMethods.decode)
class CryptoModel with CryptoModelMappable {

  CryptoModel({this.coin, this.wallet, this.network});
  final String? coin;
  final String? wallet;
  final String? network;
}

@MappableClass(generateMethods: GenerateMethods.decode)
class HairModel with HairModelMappable {

  HairModel({this.color, this.type});
  final String? color;
  final String? type;
}

@MappableClass(generateMethods: GenerateMethods.decode)
class UsersResponseModel with UsersResponseModelMappable {

  UsersResponseModel({this.users, this.total, this.skip, this.limit});
  final List<UserModel>? users;
  final int? total;
  final int? skip;
  final int? limit;

  static const fromJson = UsersResponseModelMapper.fromJson;
}
