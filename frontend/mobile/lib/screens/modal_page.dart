import 'package:flutter/material.dart';
import 'package:frontend/layout/modal_content.dart';

class ModalPage extends StatelessWidget {
  const ModalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ModalContent());
  }
}
