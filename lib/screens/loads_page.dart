import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juisan/blocs/stock_for_edit_bloc.dart';
import 'package:juisan/services/stock_items.dart';
import 'package:juisan/widgets/loads/stock_item.dart';

class LoadsPage extends StatefulWidget {
  const LoadsPage({Key? key}) : super(key: key);

  @override
  State<LoadsPage> createState() => _LoadsPageState();
}

Widget _buildItemsWidget() {
  return FutureBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              StockItem stockItem = snapshot.data[index];
              return StockItemListTile(stockItem: stockItem);
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: getItemsInStock());
}

class _LoadsPageState extends State<LoadsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Load')),
      // TODO: Is this the best place to place blocbuilder? Seems excessive to load the whole list for one item updated?
      body: BlocBuilder<StockForEditBloc, StockForEditState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildItemsWidget(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
