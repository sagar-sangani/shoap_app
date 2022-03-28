import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem({
    this.id,
    this.title,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (contex) => ProductDetailScreen(title: title),
              ),
            );
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(title, textAlign: TextAlign.center),
          leading: IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.white,
            onPressed: () {},
          ),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
              color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
