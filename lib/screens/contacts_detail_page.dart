import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_contacts_sample/models/contact.dart';
import 'package:isar_contacts_sample/presentation/contact_detail_notifier.dart';
import 'package:isar_contacts_sample/presentation/contacts_notifier.dart';

class ContactsDetailPage extends ConsumerWidget {
  const ContactsDetailPage({Key? key}) : super(key: key);
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactDetailProvider);
    final notifier = ref.watch(contactDetailProvider.notifier);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("連絡先の作成"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  //initialValue:,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onFieldSubmitted: (fieldValue) {
                    notifier.changeFirstName(fieldValue);
                  },
                ),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onFieldSubmitted: (fieldValue) {
                    notifier.changeLastName(fieldValue);
                  },
                ),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone No',
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone No';
                    }
                    return null;
                  },
                  onFieldSubmitted: (fieldValue) {
                    notifier.changePhoneNo(fieldValue);
                  },
                ),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Country Name',
                    icon: Icon(Icons.flag),
                  ),
                  onFieldSubmitted: (fieldValue) {
                    notifier.changeCountryName(fieldValue);
                  },
                ),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    icon: Icon(Icons.person),
                  ),
                  onFieldSubmitted: (fieldValue) {
                    notifier.changeZipcode(fieldValue);
                  },
                ),
                DropdownButtonFormField<Gender>(
                  hint: const Text("Select Gender"),
                  items: Gender.values.map((Gender gender) {
                    return DropdownMenuItem<Gender>(
                        value: gender, child: Text(gender.name));
                  }).toList(),
                  onChanged: (fieldValue) {
                    notifier.changeGenderForm(fieldValue ?? Gender.none);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 70)),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 21),
                  ),
                  onPressed: () {
                    ref
                        .read(contactDetailProvider.notifier)
                        .onPressedSaveButton();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
