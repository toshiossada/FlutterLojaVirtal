import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot _snapshot;
  CategoryScreen(this._snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_snapshot.data['title']),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("products")
              .document(_snapshot.documentID)
              .collection("items")
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else
              return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    renderGridView(snapshot.data.documents),
                    renderListView(snapshot.data.documents)
                  ]);
          },
        ),
      ),
    );
  }

  Widget renderGridView(List<DocumentSnapshot> doc) {
    return GridView.builder(
        padding: EdgeInsets.all(4.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 0.65,
        ),
        itemCount: doc.length,
        itemBuilder: (context, index) {
          Product data = Product.fromDocument(doc[index]);
          data.category = this._snapshot.documentID;
          return ProductTile("grid", data);
        });
  }

  Widget renderListView(List<DocumentSnapshot> doc) {
    return ListView.builder(
        padding: EdgeInsets.all(4.0),
        itemCount: doc.length,
        itemBuilder: (context, index) {
          Product data = Product.fromDocument(doc[index]);
          data.category = this._snapshot.documentID;
          return ProductTile("list", data);
        });
  }
}
