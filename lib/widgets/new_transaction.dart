import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titalcontroller = TextEditingController();
  final amountcotroller = TextEditingController();
  DateTime? _selectDate;

  void submitData() {
    if (amountcotroller.text.isEmpty) {
      return;
    }
    final enteredTitle = titalcontroller.text;
    final enteredAmount = double.parse(amountcotroller.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => submitData(),
              controller: titalcontroller,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountcotroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(_selectDate == null
                      ? 'No Date Chosen!'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectDate!)}'),
                ),
                TextButton(
                    onPressed: _presentDatePicker, child: Text('Choose Date'))
              ],
            ),
            //Padding(padding: EdgeInsets.only(top: -10)),
            ElevatedButton(
                onPressed: submitData,
                child: Text('Add Transaction'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
