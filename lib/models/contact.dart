import 'package:meta/meta.dart';
import 'package:isar/isar.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'contact.g.dart';

@immutable
@CopyWith()
@Collection()
class Contact {
  const Contact({
    this.firstName = "",
    this.lastName = "",
    this.phoneNo = "",
    this.gender = Gender.none,
    this.address,
    this.isStared,
  }) : id = Isar.autoIncrement;

  final Id id;

  final String firstName;

  final String lastName;

  final String phoneNo;

  @Enumerated(EnumType.name)
  final Gender gender;

  final Address? address;

  final bool? isStared;
}

@embedded
class Address {
  Address({this.countryName = "unknown", this.zipcode = "0000000"});

  final String? countryName;

  final String? zipcode;
}

enum Gender { male, female, other, declineToState, none }
