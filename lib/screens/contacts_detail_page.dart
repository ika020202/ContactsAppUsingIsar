import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_contacts_sample/models/contact.dart';
import 'package:isar_contacts_sample/presentation/contacts_detail_notifier.dart';
import 'package:isar_contacts_sample/screens/contacts_list_page.dart';
import 'package:isar_contacts_sample/widgets/alertDialog_validation.dart';

class ContactsDetailPage extends ConsumerWidget {
  const ContactsDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactDetailProvider);
    final notifier = ref.watch(contactDetailProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Contact"),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SizedBox(
                width: 120.0,
                height: 120.0,
                child: CircleAvatar(
                  child: Icon(Icons.camera_alt),
                ),
              ),
            ],
          ),
          Form(
            //key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: state.name,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    icon: Icon(Icons.person),
                  ),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                  onChanged: (fieldValue) {
                    notifier.changeName(fieldValue);
                  },
                ),
                TextFormField(
                  initialValue: state.phoneNo,
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone No',
                    icon: Icon(Icons.phone),
                  ),
                  onChanged: (fieldValue) {
                    notifier.changePhoneNo(fieldValue);
                  },
                ),
                TextFormField(
                  initialValue: state.address?.countryName ?? "",
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Country Name',
                    icon: Icon(Icons.flag),
                  ),
                  onChanged: (fieldValue) {
                    notifier.changeCountryName(fieldValue);
                  },
                ),
                TextFormField(
                  initialValue: state.address?.zipcode ?? "",
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    icon: Icon(Icons.home),
                  ),
                  onChanged: (fieldValue) {
                    notifier.changeZipcode(fieldValue);
                  },
                ),
                SizedBox(
                  width: 350,
                  child: DropdownButtonFormField<Gender>(
                    hint: const Text("Select Gender"),
                    value: state.gender,
                    items: Gender.values.map((Gender gender) {
                      return DropdownMenuItem<Gender>(
                          value: gender, child: Text(gender.name));
                    }).toList(),
                    onChanged: (fieldValue) {
                      notifier
                          .changeGenderForm(fieldValue ?? Gender.SelectGender);
                    },
                  ),
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
                    if (state.name == "") {
                      var message = "Name is not filled in.";
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialogValidation(
                            messsage: message,
                          );
                        },
                      );
                      return;
                    }

                    ref
                        .read(contactDetailProvider.notifier)
                        .onPressedSaveButton();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactsListPage()),
                    );
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
