import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactdetail/addcontact.dart';
import 'package:contactdetail/editScreen.dart';
import 'package:contactdetail/loadingScreen.dart';
import 'package:contactdetail/nodata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detailScreen.dart';

class contacDetail extends StatefulWidget {
  const contacDetail({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _contactDetail();
  }
}

class _contactDetail extends State<contacDetail> {
  User? userId = FirebaseAuth.instance.currentUser;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String docId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Contact'),
          content: Text('Are you sure you want to delete this contact?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Contacts')
                    .doc(docId)
                    .delete();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSignOutConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _signOut(); // Sign out the user
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  // var _isavtar = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact List',
          style: TextStyle(
            color: Colors
                .white, // You can use 'Colors.white' or a light gray shade
          ),
        ),
        backgroundColor: Colors.deepPurple[300],
        actions: [
          IconButton(
              onPressed: () {
                _showSignOutConfirmationDialog(context);
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => addcontact(),
          ),
        ),
        child: Icon(Icons.add), // Change the icon as needed
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Contacts')
              .where('UserId', isEqualTo: userId?.uid)
              .orderBy('FName')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something error has occured');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingScreen();
            }
            if (snapshot.data!.docs.isEmpty) {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>nodata()));
              return nodata();
            }

            if (snapshot != null && snapshot.data != null) {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var fname = snapshot.data!.docs[index]['FName'];
                    print(fname);
                    var Lname = snapshot.data!.docs[index]['LName'];
                    print(Lname);
                    var Phone = snapshot.data!.docs[index]['Phone'];
                    var UserId = snapshot.data!.docs[index]['UserId'];
                    var docId = snapshot.data!.docs[index].id;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detailScreen(
                                    docId, fname, Lname, Phone, UserId)));
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12.0), // Rounded corners for the card
                        ),
                        color: Colors.white, // Set the background color
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage:
                                        AssetImage('assets/contact2.png'),
                                  ),
                                  SizedBox(width: 16.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]['FName'],
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black, // Text color
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['Phone'],
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue, // Icon color
                                    ),
                                    onPressed: () {
                                      // Navigate to edit screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => editScreen(
                                              docId,
                                              fname,
                                              Lname,
                                              Phone,
                                              UserId),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red, // Icon color
                                    ),
                                    onPressed: () {
                                      _showDeleteConfirmationDialog(
                                          context, docId);
                                      // Show delete confirmation dialog
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
