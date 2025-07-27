import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) addExpense;
  const NewExpense({super.key, required this.addExpense});
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _textController = TextEditingController();
  final _amountcontroller = TextEditingController();
  final formatter = DateFormat.yMd();
  Category _selectedCategory = Category.leisure;
  DateTime? _pickedDate;
  void presentDatePicker() async {
    final currentDate = DateTime.now();
    final firstDate = DateTime(
      currentDate.year - 1,
      currentDate.month,
      currentDate.day,
    );
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: currentDate,
    );
    setState(() {
      _pickedDate = selectedDate;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountcontroller.text);
    final amountIsValid = enteredAmount == null || enteredAmount < 0;
    if (_textController.text.trim().isEmpty ||
        amountIsValid ||
        _pickedDate == null) {
      //error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure you entered a valid title, amount, and picked a date.',
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ),
          ],
        ),
      );
    } else {
      widget.addExpense(
        Expense(
          title: _textController.text,
          amount: enteredAmount,
          date: _pickedDate!,
          category: _selectedCategory,
        ),
      );
    }
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
            decoration: InputDecoration(
              label: Text('Title'),
              filled: true,
              fillColor: Color.fromARGB(255, 242, 223, 249), // pale green-ish
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          TextField(
            controller: _amountcontroller,
            maxLength: 50,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text('₹'),
              filled: true,
              fillColor: Color.fromARGB(255, 242, 223, 249), // pale green-ish
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2DFF9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepPurple.shade100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _pickedDate == null
                              ? 'No date Selected'
                              : formatter.format(_pickedDate!),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: _pickedDate == null
                                ? const Color.fromARGB(255, 110, 110, 110)
                                : Colors.deepPurple,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: presentDatePicker,
                        icon: Icon(Icons.calendar_month, size: 26),
                        color: Colors.deepPurple,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<Category>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    icon: const Icon(Icons.arrow_drop_down, size: 26),
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
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
                  _submitExpenseData();
                  Navigator.pop(context);
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
