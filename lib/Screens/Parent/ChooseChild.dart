import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/SecondScreen.dart';
import 'package:flutter_school/services/database.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants.dart';

class ChooseChildScreen extends StatelessWidget {
  final DatabaseService _databaseService = DatabaseService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Child'),
        backgroundColor: myDarkBlue, // Set app bar background color
      ),
      body: FutureBuilder<List<String>>(
        future: _initializeChildren(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<String>? children = snapshot.data;
            if (children == null || children.isEmpty) {
              return Center(
                child: Text('No children found.'),
              );
            } else {
              return _buildChildList(children, context);
            }
          }
        },
      ),
    );
  }

  Future<List<String>> _initializeChildren() async {
    try {
      User? user = _authService.getCurrentUser();
      if (user != null) {
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
                return Card(
                  elevation: 3.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      children[index],
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onTap: () {
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
