import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/faulty_comp_provider.dart';
import 'package:frontend/widgets/faulty_comp/component_form.dart';
import 'package:frontend/widgets/faulty_comp/image_picker.dart';
import 'package:frontend/widgets/faulty_comp/submit_button.dart';

class FaultyCompContent extends StatelessWidget {
  const FaultyCompContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FaultyCompProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signaler une pièce défectueuse'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              ComponentForm(),
              SizedBox(height: 20),
              ImagePickerWidget(),
              SizedBox(height: 20),
              SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
