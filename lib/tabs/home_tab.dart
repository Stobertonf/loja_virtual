import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 211, 118, 130),
                Color.fromARGB(255, 253, 181, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );

    return  Stack(
      children: <Widget>[
        _buildBodyBack(),
        const CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title:  Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                .collection("home").orderBy("pos").getDocuments(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else
                  return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data.documents.map(
                      (doc){
                        return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                      }
                    ).toList(),
                    children: snapshot.data.documents.map(
                      (doc){
                        return FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: doc.data["image"],
                            fit: BoxFit.cover,
                        );
                      }
                    ).toList(),
                  );
              },
            )
          ],
        )
      ],
    );
  }
}
