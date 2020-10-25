import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(String) onRemove;

  TransactionList(this.transaction, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transaction.isEmpty
          ? Column(children: [
              SizedBox(height: 20),
              Text(
                "Nenhuma Transação Cadastrada",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ])
          : ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (ctx, index) {
                final e = transaction[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('R\$${e.value}'),
                        ),
                      ),
                      radius: 30,
                    ),
                    title: Text(
                      e.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(e.date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed: () => onRemove(e.id),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
