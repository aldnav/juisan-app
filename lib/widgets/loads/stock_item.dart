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
  const StockItemListTile({Key? key, required this.stockItem})
      : super(key: key);

  final StockItem stockItem;

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
                        // TODO: Decide how to get "To deliver"
                        // StockQuantityInfo(
                        //     quantity: stockItem.quantityInStock ?? 0,
                        //     unit: stockItem.getQuantityUnitDisplay(),
                        //     description: "To deliver"),
                        // const SizedBox(width: 8),
                        StockQuantityInfo(
                            quantity: stockItem.quantityInStock ?? 0,
                            unit: stockItem.getQuantityUnitDisplay(),
                            description: "In stock"),
                        const SizedBox(width: 8),
                        StockQuantityInfo(
                            quantity: stockItem.quantityInBO ?? 0,
                            unit: stockItem.getQuantityUnitDisplay(),
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
