import 'dart:async';

import 'package:isar_contacts_sample/models/contact.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final contactsRepoProvider = Provider((ref) => ContactsRepository());

class ContactsRepository {
  final Isar isar = Isar.openSync([ContactSchema]);

  // データの監視
  void listenToContacts(
    void Function(List<Contact>) watchedResults,
  ) {
    Stream<List<Contact>> watchContacts =
        isar.contacts.where().watch(fireImmediately: true);
    watchContacts.listen((contacts) {
      watchedResults(contacts);

      print("Contactに$contactsの変更が入りました");
    });
  }

  // 保存+更新処理
  void save(Contact contact) {
    isar.writeTxnSync(() => isar.contacts.putSync(contact));
  }

  // 削除
  void delete(Contact contact) {
    isar.writeTxnSync(() => isar.contacts.delete(contact.id));
  }

  // データの取得(星印)
  Future<List<Contact>> queryOfStared() async {
    return await isar.contacts.filter().isStaredEqualTo(true).findAll();
  }

  // 初期設定
  /*
  void openDB() async {
    final dir = await getApplicationSupportDirectory();
    isar =
        await Isar.open([ContactSchema], directory: dir.path, inspector: true);
    print("コンストラクタ起動");
  }
  */
}
