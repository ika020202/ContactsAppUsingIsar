import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_contacts_sample/theme.dart';
import 'screens/contacts_list_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const ContactsListPage(),
        theme: myTheme,
      ),
    ),
  );
}
