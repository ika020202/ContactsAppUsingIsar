import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_contacts_sample/application/contacts_app_service.dart';
import 'package:isar_contacts_sample/models/contact.dart';

final contactDetailProvider =
    StateNotifierProvider.autoDispose<ContactDetailNotifier, Contact>((ref) {
  return ContactDetailNotifier(
    contactsAppService: ref.read(contactsAppService),
  );
});

class ContactDetailNotifier extends StateNotifier<Contact> {
  final ContactsAppService _contactsAppService;

  ContactDetailNotifier({
    required ContactsAppService contactsAppService,
  })  : _contactsAppService = contactsAppService,
        super(const Contact());

  void setContact(Contact contact) {
    state = contact.copyWith();
  }

  void changeFirstName(String firstname) {
    state = state.copyWith(firstName: firstname);
  }

  void changeLastName(String lastname) {
    state = state.copyWith(lastName: lastname);
  }

  void changePhoneNo(String phoneNo) {
    state = state.copyWith(phoneNo: phoneNo);
  }

  void changeCountryName(String countryName) {
    state = state.copyWith(address: Address(countryName: countryName));
  }

  void changeZipcode(String zipcode) {
    state = state.copyWith(address: Address(zipcode: zipcode));
  }

  void changeGenderForm(Gender gender) {
    state = state.copyWith(gender: gender);
  }

  void onPressedSaveButton() {
    _contactsAppService.saveOrUpdateContact(contact: state);
  }
}
