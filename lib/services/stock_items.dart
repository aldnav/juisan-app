class StockItems {
  StockItems(this.items);

  final List<StockItem> items;
}

enum StockQuantity {
  pieces,
  packs,
}

/// The stock item model
class StockItem {
  StockItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantityUnit = StockQuantity.packs,
    this.quantityInStock = 0,
    this.quantityInBO = 0,
  });

  int id;
  String name;
  double price = 0.0;
  StockQuantity? quantityUnit;
  int? quantityInStock;
  int? quantityInBO;
}

/// Retrieve the stock items from the server
/// TODO: Implement fetching from the server
Future getItemsInStock() async {
  List<StockItem> stocksList = [
    StockItem(id: 1, name: "Coca Cola", price: 10, quantityInStock: 4),
    StockItem(id: 2, name: "Fruit Juice", price: 10, quantityInStock: 4),
    StockItem(id: 3, name: "Orange", price: 10, quantityInStock: 4),
    StockItem(id: 4, name: "Grapes", price: 10, quantityInStock: 4),
  ];
  return stocksList;
}
