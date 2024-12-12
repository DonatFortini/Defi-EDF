import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/providers/faulty_comp_provider.dart';
import 'package:frontend/widgets/faulty_comp/component_form.dart';
import 'package:frontend/widgets/image_picker_widget.dart';
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
            children: [
              const ComponentForm(),
              const SizedBox(height: 20),
              ImagePickerWidget(
                updateImageCallback: (image) {
                  context.read<FaultyCompProvider>().updateImage(image!);
                },
              ),
              const SizedBox(height: 20),
              const SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
