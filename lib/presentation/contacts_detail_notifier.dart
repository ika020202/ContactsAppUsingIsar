import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_contacts_sample/application/contacts_app_service.dart';
import 'package:isar_contacts_sample/models/contact.dart';

final contactDetailProvider =
    StateNotifierProvider<ContactDetailNotifier, Contact>((ref) {
  return ContactDetailNotifier(
    contactsAppService: ref.read(contactsAppService),
  );
});

class ContactDetailNotifier extends StateNotifier<Contact> {
  final ContactsAppService _contactsAppService;

  ContactDetailNotifier({
    required ContactsAppService contactsAppService,
  })  : _contactsAppService = contactsAppService,
        super(Contact());

  void initContact() {
    state = Contact();
  }

  void setContact(Contact contact) {
    state = contact.copyWith();
  }

  void changeName(String name) {
    state = state.copyWith(name: name);
  }

  void changePhoneNo(String phoneNo) {
    state = state.copyWith(phoneNo: phoneNo);
  }

  void changeCountryName(String countryName) {
    state = state.copyWith(
        address: Address(
            countryName: countryName, zipcode: state.address?.zipcode ?? ""));
  }

  void changeZipcode(String zipcode) {
    state = state.copyWith(
        address: Address(
            zipcode: zipcode, countryName: state.address?.countryName ?? ""));
  }

  void changeGenderForm(Gender gender) {
    state = state.copyWith(gender: gender);
  }

  void changeIsStared(bool isStared) {
    state = state.copyWith(isStared: isStared);
    _contactsAppService.saveOrUpdateContact(contact: state);
  }

  void onPressedSaveButton() {
    _contactsAppService.saveOrUpdateContact(contact: state);
  }

  void onPressedDeleteButton() {
    _contactsAppService.deleteContact(contact: state);
  }
}
