import 'package:flutter/material.dart';
import 'package:juisan/blocs/stock_for_edit_bloc.dart';
import 'package:juisan/services/stock_items.dart';
import 'package:juisan/utils.dart';
import 'package:provider/provider.dart';

enum _MenuOption {
  edit,
  release,
  viewDelivery,
}

class StockQuantityInfo extends StatelessWidget {
  const StockQuantityInfo(
      {Key? key,
      required this.quantity,
      required this.unit,
      required this.description})
      : super(key: key);

  final int quantity;
  final String unit;
  final String description;

  final TextStyle stockQuantityTextStyle = const TextStyle(fontSize: 10);
  final TextStyle stockDescriptionTextStyle = const TextStyle(fontSize: 8);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(quantity.toString(), style: stockQuantityTextStyle),
            const Text(' '),
            Text(unit, style: stockQuantityTextStyle),
          ],
        ),
        Text(description, style: stockDescriptionTextStyle),
      ],
    );
  }
}

/// A widget that displays a stock item's name and quantity, among other details.
class StockItemListTile extends StatelessWidget {
  StockItemListTile({Key? key, required this.stockItem}) : super(key: key);

  final StockItem stockItem;

  final Map _qtyMap = {
    StockQuantity.packs: 'packs',
    StockQuantity.pieces: 'pieces',
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          children: [
            Expanded(child: Text(stockItem.name)),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        StockQuantityInfo(
                            quantity: stockItem.quantityInStock ?? 0,
                            unit: stockItem.quantityUnit != null
                                ? _qtyMap[stockItem.quantityUnit]
                                : "",
                            description: "To deliver"),
                        const SizedBox(width: 8),
                        StockQuantityInfo(
                            quantity: stockItem.quantityInStock ?? 0,
                            unit: stockItem.quantityUnit != null
                                ? _qtyMap[stockItem.quantityUnit]
                                : "",
                            description: "In stock"),
                        const SizedBox(width: 8),
                        StockQuantityInfo(
                            quantity: stockItem.quantityInStock ?? 0,
                            unit: stockItem.quantityUnit != null
                                ? _qtyMap[stockItem.quantityUnit]
                                : "",
                            description: "B/O"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<_MenuOption>(
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<_MenuOption>>[
                const PopupMenuItem<_MenuOption>(
                  value: _MenuOption.edit,
                  child: Text('Edit stock'),
                ),
                const PopupMenuItem<_MenuOption>(
                  value: _MenuOption.release,
                  child: Text('Release items'),
                ),
                const PopupMenuItem<_MenuOption>(
                  value: _MenuOption.viewDelivery,
                  child: Text('View items to deliver'),
                ),
              ],
              onSelected: (option) {
                switch (option) {
                  case _MenuOption.edit:
                    // Navigator.pushNamed(context, '/edit');
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => ChangeNotifierProvider(
                    //       create: (context) => stockItemForEdit,
                    //       builder: (context, child) => EditStockPage(),
                    //     ),
                    //   ),
                    // );
                    context
                        .read<StockForEditBloc>()
                        .add(StockForEditSelected(stockItem.id));
                    Navigator.pushNamed(context, Utils.loadsEditPage);
                    break;
                  case _MenuOption.release:
                    // Navigator.pushNamed(context, '/stock/release');
                    debugPrint("Release items");
                    break;
                  case _MenuOption.viewDelivery:
                    // Navigator.pushNamed(context, '/stock/delivery');
                    debugPrint("View items to deliver");
                    break;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class StockItemForEdit extends ChangeNotifier {
  /// Internal private state of the stock item to edit
  late StockItem _stockItem = StockItem(name: 'N/A', price: 0, id: 0);
  String message = "";

  /// Internal private state of the stock item to edit
  StockItem get stockItem => _stockItem;

  /// Internal private state of the stock item to edit
  // set stockItem(StockItem stockItem) {
  //   _stockItem = stockItem;
  // }

  void setStockItem(StockItem stockItem) {
    _stockItem = stockItem;
    message = "foo";
    notifyListeners();
  }
}
