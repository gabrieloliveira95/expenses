import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _valueController = TextEditingController();

  _submitForm() {
    final title = _titleController.text.toString();
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) return;
    widget.onSubmit(title, value, _selectedDate);
  }

  _datePicker() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                onSubmitted: (_) => _submitForm(),
                controller: _titleController,
                decoration: InputDecoration(labelText: "Titulo"),
              ),
              TextField(
                onSubmitted: (_) => _submitForm(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _valueController,
                decoration: InputDecoration(labelText: "Valor R\$"),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data Selecionada'
                            : DateFormat('dd/MM/y').format(_selectedDate),
                      ),
                    ),
                    FlatButton(
                      onPressed: _datePicker,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    onPressed: _submitForm,
                    color: Theme.of(context).primaryColor,
                    child: Text("Nova Transacao"),
                    textColor: Theme.of(context).textTheme.button.color,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
