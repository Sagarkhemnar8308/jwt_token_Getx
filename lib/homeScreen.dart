import 'package:flutter/material.dart';
import 'package:jwt_token_getx/localestorageutils/localestorageutils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(LocaleStorageUtil.userData().name.toString()),
        ],
      ),
    );
  }
}