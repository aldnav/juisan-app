import 'package:flutter/material.dart';
import 'package:juisan/blocs/stock_for_edit_bloc.dart';
import 'package:juisan/services/stock_items.dart';
import 'package:juisan/widgets/loads/stock_item.dart';
import 'package:provider/provider.dart';

class EditStockPage extends StatefulWidget {
  const EditStockPage({
    Key? key,
  }) : super(key: key);

  @override
  _EditStockPageState createState() => _EditStockPageState();
}

class _EditStockPageState extends State<EditStockPage> {
  String appBarTitle = 'Edit item';

  @override
  Widget build(BuildContext context) {
    return Consumer<StockItemForEdit>(
        builder: (context, stockItemForEdit, child) {
      StockItem stockItem = stockItemForEdit.stockItem;

      /// from bloc

      return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        body: Center(
          child: Row(
            children: [
              Text(stockItem.name + " " + stockItemForEdit.message),
              Text(" "),
              Text(context.read<StockForEditBloc>().state.stockId.toString()),
            ],
          ),
        ),
      );
    });
  }
}
