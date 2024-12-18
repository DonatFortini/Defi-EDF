import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final String label;
  final DateTime? value;
  final DateTime? minDate;
  final ValueChanged<DateTime> onChanged;

  const DatePickerField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.minDate,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _controller = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    print('DatePickerField - initState');
    print('Initial value: ${widget.value}');
    _updateTextValue();
  }

  @override
  void didUpdateWidget(DatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('DatePickerField - didUpdateWidget');
    print('Old value: ${oldWidget.value}');
    print('New value: ${widget.value}');
    if (oldWidget.value != widget.value) {
      _updateTextValue();
    }
  }

  void _updateTextValue() {
    print('DatePickerField - _updateTextValue');
    print('Updating text for value: ${widget.value}');
    _controller.text =
        widget.value != null ? _dateFormat.format(widget.value!) : '';
    print('Controller text is now: ${_controller.text}');
  }

  Future<void> _selectDate(BuildContext context) async {
    print('DatePickerField - _selectDate started');
    final DateTime now = DateTime.now();
    final DateTime minimumDate = widget.minDate ?? now;

    print('Minimum date: $minimumDate');
    print('Current value: ${widget.value}');

    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.value ?? minimumDate,
        firstDate: minimumDate,
        lastDate: now.add(const Duration(days: 365)),
        locale: const Locale('fr', 'FR'),
      );

      print('Picked date: $picked');

      if (picked != null) {
        print('Calling onChanged with date: $picked');
        widget.onChanged(picked);
      }
    } catch (e) {
      print('Error in _selectDate: $e');
      debugPrint('Erreur lors de la sélection de la date: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('DatePickerField - build');
    print('Current value in build: ${widget.value}');
    print('Current text in controller: ${_controller.text}');

    return TextField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.label,
        hintText: 'JJ/MM/AAAA',
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            print('Calendar icon pressed');
            _selectDate(context);
          },
        ),
      ),
      onTap: () {
        print('TextField tapped');
        _selectDate(context);
      },
    );
  }

  @override
  void dispose() {
    print('DatePickerField - dispose');
    _controller.dispose();
    super.dispose();
  }
}
