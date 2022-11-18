import 'package:isar_contacts_sample/infrastructure/contacts_repository.dart';
import 'package:isar_contacts_sample/models/contact.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsAppService = Provider(
  (ref) => ContactsAppService(
    contactsRepoProvider: ref.read(contactsRepoProvider),
  ),
);

class ContactsAppService {
  final ContactsRepository _contactsRepoProvider;

  ContactsAppService({required ContactsRepository contactsRepoProvider})
      : _contactsRepoProvider = contactsRepoProvider;

  void subscribeContactsList(
    void Function(List<Contact>) watchedResults,
  ) {
    _contactsRepoProvider.listenToContacts(
      watchedResults,
    );
  }

  // 保存+更新処理
  void saveOrUpdateContact({required Contact contact}) {
    _contactsRepoProvider.save(contact);
  }

  // 削除
  void deleteContact({required Contact contact}) {
    _contactsRepoProvider.delete(contact);
  }

  // データの取得(星印)
  Future<List<Contact>> findStaredContacts() async {
    return await _contactsRepoProvider.queryOfStared();
  }
}
