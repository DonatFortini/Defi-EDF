import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final DateTime? minDate;
  final ValueChanged<DateTime> onChanged;
  var dateFormat = DateFormat('dd/MM/yyyy');

  DatePickerField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.minDate,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: minDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(
        text: value != null ? dateFormat.format(value!) : '',
      ),
      readOnly: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: 'JJ/MM/AAAA',
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ),
      onTap: () => _selectDate(context),
    );
  }
}
