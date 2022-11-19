import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_contacts_sample/presentation/contacts_detail_notifier.dart';
import 'package:isar_contacts_sample/presentation/contacts_list_notifier.dart';

class ContactsListPage extends ConsumerWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactsListProvider);
    final notifier = ref.read(contactsListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Contacts List Page'),
      ),
      body: ListView(
        children: state
            .map(
              (item) => InkWell(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading: CircleAvatar(
                      child: Text(
                        item.name.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                            fontSize: 26, color: Colors.white60),
                      ),
                    ),
                    trailing: IconButton(
                      color: Colors.indigo,
                      icon: item.isStared == true
                          ? const Icon(Icons.star)
                          : const Icon(Icons.star_border),
                      onPressed: () {
                        notifier.onTapStar(item, item.isStared);
                      },
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: item.name,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    subtitle: item.phoneNo.toString().isNotEmpty
                        ? Text(item.phoneNo)
                        : null,
                  ),
                ),
                onTap: () {
                  notifier.onTapConctact(context, ref, item);
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
