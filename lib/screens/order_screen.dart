import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrderScreen({Key key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapShot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemBuilder: (ctx, i) => OrderItemWidget(
                    order: orderData.orders[i],
                  ),
                  itemCount: orderData.orders.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
