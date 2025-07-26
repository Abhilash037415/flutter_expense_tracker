import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _textController = TextEditingController();
  final _autocontroller = TextEditingController();

  void presentDatePicker() {
    final currentDate = DateTime.now();
    final firstDate = DateTime(
      currentDate.year - 1,
      currentDate.month,
      currentDate.day,
    );
    showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: currentDate,
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _autocontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            maxLength: 50,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _autocontroller,
                  maxLength: 50,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(label: Text('\$')),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Select Date'),
                    IconButton(
                      onPressed: presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_autocontroller.text);
                  print(_textController.text);
                },
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
