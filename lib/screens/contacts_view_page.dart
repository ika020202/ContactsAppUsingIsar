import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_contacts_sample/presentation/contacts_detail_notifier.dart';
import 'package:isar_contacts_sample/screens/contacts_detail_page.dart';

class ContactsViewPage extends ConsumerWidget {
  const ContactsViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactDetailProvider);
    final notifier = ref.watch(contactDetailProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: state.isStared == true
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
            onPressed: () {
              notifier.changeIsStared(!state.isStared);
            },
          ),
          IconButton(
            color: Colors.white,
            icon: const Icon(
              Icons.edit,
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ContactsDetailPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(color: Color(0xff009688)),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.33,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 40),
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 160,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            state.name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        title:
                            Text(state.phoneNo != "" ? state.phoneNo : "None"),
                        subtitle: const Text(
                          "PhoneNo",
                          style: TextStyle(color: Colors.black54),
                        ),
                        leading: IconButton(
                          icon: const Icon(Icons.phone, color: Colors.indigo),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(state.address?.countryName == null ||
                                state.address?.countryName == ""
                            ? "None"
                            : state.address!.countryName),
                        subtitle: const Text(
                          "Country",
                          style: TextStyle(color: Colors.black54),
                        ),
                        leading: IconButton(
                          icon: const Icon(Icons.flag, color: Colors.indigo),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(state.address?.zipcode == null ||
                                state.address?.zipcode == ""
                            ? "None"
                            : state.address!.zipcode),
                        subtitle: const Text(
                          "Address",
                          style: TextStyle(color: Colors.black54),
                        ),
                        leading: IconButton(
                          icon: const Icon(Icons.home, color: Colors.indigo),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(state.gender.name),
                        subtitle: const Text(
                          "Gender",
                          style: TextStyle(color: Colors.black54),
                        ),
                        leading: IconButton(
                          icon: const Icon(Icons.person, color: Colors.indigo),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(120, 60)),
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        ),
                        onPressed: () {
                          ref
                              .read(contactDetailProvider.notifier)
                              .onPressedDeleteButton();
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
