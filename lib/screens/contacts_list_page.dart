import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_contacts_sample/presentation/contacts_list_notifier.dart';
import 'package:isar_contacts_sample/widgets/searchWidget.dart';

class ContactsListPage extends ConsumerWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactsListProvider);
    final notifier = ref.read(contactsListProvider.notifier);
    final isSearch = ref.watch(isSearchProvider);
    final isSearchNotifier = ref.watch(isSearchProvider.notifier);

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: isSearch
              ? const SearchWidget()
              : const Text('Contacts List Page'),
          actions: !isSearch
              ? [
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      isSearchNotifier.state = !isSearch;
                    },
                  ),
                ]
              : [
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      isSearchNotifier.state = !isSearch;
                    },
                  ),
                ]),
      body: state.isEmpty
          ? const Center(
              child: Text(
                "Please Add Contacts in your storage",
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView(
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
        backgroundColor: const Color(0xff009688),
        onPressed: () {
          notifier.onTapFAB(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
