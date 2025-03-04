import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  const CategoryScreen(this.snapshot, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
          bottom:const TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list),)
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("products").document(snapshot.documentID)
            .collection("items").getDocuments(),
            builder: (context, snapshot){
              if(!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator(),);
              } else {
                return TabBarView(
                    physics:const NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.all(4.0),
                          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            childAspectRatio: 0.65,
                          ),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index){
                            ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                            data.category = this.snapshot.documentID;
                            return ProductTile("grid", data);
                          }
                      ),
                      ListView.builder(
                          padding:const EdgeInsets.all(4.0),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index){
                            ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                            data.category = this.snapshot.documentID;
                            return ProductTile("list", data);
                          }
                      )
                    ]
                );
              }
            }
        )
      ),
    );
  }
}
