import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_contacts_sample/application/contacts_app_service.dart';
import 'package:isar_contacts_sample/models/contact.dart';
import 'package:isar_contacts_sample/presentation/contacts_detail_notifier.dart';
import 'package:isar_contacts_sample/screens/contacts_detail_page.dart';

import '../screens/contacts_view_page.dart';

final isSearchProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final contactsListProvider =
    StateNotifierProvider<ContactsListNotifier, List<Contact>>(
  (ref) => ContactsListNotifier(
    contactsAppService: ref.read(contactsAppService),
  )..init(),
);

class ContactsListNotifier extends StateNotifier<List<Contact>> {
  final ContactsAppService _contactsAppService;

  ContactsListNotifier({required ContactsAppService contactsAppService})
      : _contactsAppService = contactsAppService,
        super([]);

  void init() {
    state = [];
    _contactsAppService.subscribeContactsList(_contactsHaveUpdated);
  }

  void _contactsHaveUpdated(List<Contact> contactsList) {
    state = contactsList.map((contact) => contact.copyWith()).toList();
  }

  void onTapConctact(BuildContext context, WidgetRef ref, Contact contact) {
    ref.read(contactDetailProvider.notifier).setContact(contact);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const ContactsViewPage(),
      ),
    );
  }

  void onTapStar(Contact contact, bool isStared) {
    _contactsAppService.saveOrUpdateContact(
        contact: contact.copyWith(isStared: !isStared));
  }

  void onTapFAB(BuildContext context, WidgetRef ref) {
    ref.read(contactDetailProvider.notifier).initContact();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const ContactsDetailPage(),
      ),
    );
  }
}
