import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_contacts_sample/presentation/contacts_notifier.dart';

class ContactsListPage extends ConsumerWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactsListProvider);
    final notifier = ref.read(contactsListProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List Page'),
      ),
      body: ListView(
        children: state
            .map(
              (item) => InkWell(
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      text: item.firstName,
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  notifier.onTapConctact(context, ref, item);
                },
                onLongPress: () async {
                  //await notifier.onLongPressItem(context: context, item: item);
                },
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notifier.onTapFAB(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
