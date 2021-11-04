// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionFrom extends StatefulWidget {
  final void Function(String, double, DateTime)? onSubmit;

  const TransactionFrom(this.onSubmit);

  @override
  State<TransactionFrom> createState() => _TransactionFromState();
}

class _TransactionFromState extends State<TransactionFrom> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectdDate = DateTime.now();

  _subimitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectdDate == null) {
      return;
    }

    widget.onSubmit!(title, value, _selectdDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }

        setState(
          () {
            _selectdDate = pickedDate;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              //onSubmitted: (_) => _subimitForm(),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _subimitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectdDate == null
                          ? 'Nenhuma data selecionada!'
                          : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectdDate)}',
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text(
                    'Nova Transação',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _subimitForm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
