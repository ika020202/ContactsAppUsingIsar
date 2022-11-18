import 'package:isar/isar.dart';

part 'contact.g.dart';

@Collection()
class Contact {
  Contact({
    this.name = "",
    this.phoneNo = "",
    this.gender = Gender.SelectGender,
    this.address,
    this.isStared,
    this.id,
  });

  Id? id;

  final String name;

  final String phoneNo;

  @Enumerated(EnumType.name)
  final Gender gender;

  final Address? address;

  final bool? isStared;

  Contact copyWith({
    Id? id,
    String? name,
    String? phoneNo,
    Gender? gender,
    Address? address,
    bool? isStared,
  }) {
    return Contact(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNo: phoneNo ?? this.phoneNo,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        isStared: isStared ?? this.isStared);
  }
}

@embedded
class Address {
  Address({this.countryName = "", this.zipcode = ""});

  final String? countryName;

  final String? zipcode;
}

enum Gender { Male, Female, Other, DeclineToState, SelectGender }
