import 'package:flutter/material.dart';
import 'package:flutter_school/second_screen.dart';
import 'package:flutter_school/services/database.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants.dart';

// This widget represents the screen for choosing a child for a parent.
class ChooseChildScreen extends StatelessWidget {
  // The service for the database.
  final DatabaseService _databaseService = DatabaseService();
  // The service for the authentication.
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // Returns a Scaffold widget that contains the choose child screen.
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Child'),
        backgroundColor: myDarkBlue, // Set app bar background color
      ),
      body: FutureBuilder<List<String>>(
        // Initialize the children.
        future: _initializeChildren(),
        builder: (context, snapshot) {
          // If the data is still loading, display a loading indicator.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If there is an error, display an error message.
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // The list of children.
            List<String>? children = snapshot.data;
            if (children == null || children.isEmpty) {
              // If there are no children, display a message.
              return Center(
                child: Text('No children found.'),
              );
            } else {
              // If there are children, display the child list.
              return _buildChildList(children, context);
            }
          }
        },
      ),
    );
  }

  // This method initializes the children.
  Future<List<String>> _initializeChildren() async {
    try {
      // Get the current user.
      User? user = _authService.getCurrentUser();
      if (user != null) {
        // Fetch the children for the user.
        List<String>? fetchedChildren =
            await _databaseService.getChildren(user);
        return fetchedChildren ?? [];
      } else {
        throw 'User not found.';
      }
    } catch (e) {
      throw 'Error fetching children: $e';
    }
  }

  // This method builds the child list.
  Widget _buildChildList(List<String> children, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Select a Child',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: children.length,
              itemBuilder: (context, index) {
                // Create a card for each child.
                return Card(
                  elevation: 3.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      children[index],
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onTap: () {
                      // Navigate to the second screen when the card is tapped.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondScreen(
                            child: children[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}