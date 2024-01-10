// Import necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      // Get a reference to the user's favorites collection
      CollectionReference favoritesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites');

      return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: StreamBuilder(
          stream: favoritesCollection.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            // Display favorited events
            List<Widget> favoritesList = snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['title']),
                subtitle: Text(data['description']),
                leading: Image.network(data['imagePath']),

                trailing: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                // Add other event details as needed
              );
            }).toList();

            return ListView(
              children: favoritesList,
            );
          },
        ),
      );
    } else {
      return Text('User not authenticated');
    }
  }
}
