import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class addcontact extends StatefulWidget {
  const addcontact({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _addcontact();
  }
}

User? _curentUser = FirebaseAuth.instance.currentUser;

class _addcontact extends State<addcontact> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredNum = "";
  var _enteredSurName = "";
  var _authenticating = false;

  File _selectedImage = File('assets/contact2.png');

  @override
  Widget build(BuildContext context) {
    void submit() async {
      final _isValid = _formKey.currentState!.validate();
      if (!_isValid) {
        return;
      }
      setState(() {
        _authenticating = true;
      });

      _formKey.currentState!.save();
      await FirebaseFirestore.instance.collection("Contacts").doc().set({
        'FName': _enteredName,
        'LName': _enteredSurName,
        'Phone': _enteredNum,
        'UserId': _curentUser?.uid,
      });
      setState(() {
        _authenticating = false;
      });
      Navigator.pop(context);
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add contact",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple[300],
        centerTitle: true,
      ),
      backgroundColor: CupertinoColors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.all(20),
              elevation: 8,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              hintText: 'Enter first name',
                              prefixIcon: Icon(Icons.person_2),
                              // Custom border
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue, // Border color
                                  width: 2.0, // Border width
                                ),
                              ),
                              // Focused border
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color:
                                      Colors.green, // Border color when focused
                                  width: 2.0, // Border width when focused
                                ),
                              ),
                              // Error border
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors
                                      .red, // Border color when there's an error
                                  width:
                                      2.0, // Border width when there's an error
                                ),
                              ),
                              // Error text style
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              // Define a regular expression pattern for a valid first name
                              final nameRegExp = RegExp(
                                  r'^[A-Za-z ]+$'); // Adjust the pattern as needed

                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }

                              if (!nameRegExp.hasMatch(value)) {
                                return 'Please enter letters only)';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredName = value!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              hintText: 'Enter Last name',
                              prefixIcon: Icon(Icons.person_2),
                              // Custom border
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue, // Border color
                                  width: 2.0, // Border width
                                ),
                              ),
                              // Focused border
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color:
                                      Colors.green, // Border color when focused
                                  width: 2.0, // Border width when focused
                                ),
                              ),
                              // Error border
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors
                                      .red, // Border color when there's an error
                                  width:
                                      2.0, // Border width when there's an error
                                ),
                              ),
                              // Error text style
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              // Define a regular expression pattern for a valid last name
                              final nameRegExp = RegExp(
                                  r'^[A-Za-z ]+(\d*)$'); // Adjust the pattern as needed

                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }

                              if (!nameRegExp.hasMatch(value)) {
                                return 'letters and optional digits at the end';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredSurName = value!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: 'Enter Phone Number',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.blue,
                              ),
                              // Custom border
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue, // Border color
                                  width: 2.0, // Border width
                                ),
                              ),
                              // Focused border
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color:
                                      Colors.green, // Border color when focused
                                  width: 2.0, // Border width when focused
                                ),
                              ),
                              // Error border
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors
                                      .red, // Border color when there's an error
                                  width:
                                      2.0, // Border width when there's an error
                                ),
                              ),
                              // Error text style
                              errorStyle: TextStyle(color: Colors.red),
                            ),
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              final phoneRegExp = RegExp(r'^\d{10}$');
                              if (value == null || value.isEmpty) {
                                return 'Please enter a phone number';
                              }

                              if (!phoneRegExp.hasMatch(value)) {
                                return 'Please enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredNum = value!;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          if (_authenticating)
                            const CircularProgressIndicator(),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            onPressed: submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text("Submit"),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
