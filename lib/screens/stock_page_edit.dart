import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juisan/blocs/stock_for_edit_bloc.dart';
import 'package:juisan/services/stock_items.dart';
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
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: _buildEditStockForm(
        context.read<StockForEditBloc>().state.stockId,
        _formKey,
      ),
    );
  }
}

Widget _buildEditStockForm(int stockId, GlobalKey<FormState> _formKey) {
  return FutureBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          StockItem stockItem = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stockItem.name),
                // Start FORM
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Quantity in ${stockItem.getQuantityUnitDisplay()}"),
                        TextFormField(
                          initialValue: stockItem.quantityInStock.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onSaved: (value) {
                            stockItem.quantityInStock = int.parse(value!);
                          },
                          // onSaved: (value) => stockItem.name = value,
                          // validator: (value) {
                          //   var inputValue = int.tryParse(value!);
                          //   if (inputValue <) {
                          //     return 'Please enter a name';
                          //   }
                          //   return value;
                          // },
                        ),
                        const Text("B/O"),
                        TextFormField(
                          initialValue: stockItem.quantityInBO.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onSaved: (value) {
                            stockItem.quantityInBO = int.parse(value!);
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            child: const Text('Save'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // Provider.of<StockForEditBloc>(context,
                                //         listen: false)
                                //     .updateStockItem(stockItem);
                                context
                                    .read<StockForEditBloc>()
                                    .add(const StockForEditIsSaving());
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  // TODO: Show snackbar when saved successfully
                                  const snackBar = SnackBar(
                                    content: Text('Saving changes'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar,
                                  );
                                  Navigator.pop(context);
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: getItemWithId(stockId));
}
