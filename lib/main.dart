import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:isar_contacts_sample/models/contact.dart';
import 'package:isar_contacts_sample/presentation/contacts_notifier.dart';

import 'screens/contacts_list_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ContactsListPage(),
      ),
    ),
  );
}
