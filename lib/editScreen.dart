import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class editScreen extends StatefulWidget {
  var docId, fname, lname, phone, userId;
  editScreen(
      @required this.docId, @required this.fname, @required this.lname,
      @required this.phone, @required this.userId);

  @override
  State<editScreen> createState() => _editScreenState();
}

class _editScreenState extends State<editScreen> {
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  var _enteredFName = "";
  var _enteredLName = "";
  var _enteredPhone = "";
  var _authenticating = false;

  @override
  void initState() {
    super.initState();
    _fnameController.text = widget.fname.toString();
    _lnameController.text = widget.lname.toString();
    _phoneController.text = widget.phone.toString();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        backgroundColor: Colors.deepPurple[300],
        centerTitle: true,
      ),
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
            SizedBox(
              height: 20,
            ),
            Card(
              margin: EdgeInsets.all(16),
              elevation: 8, // Elevation for shadow
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Container(
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _fnameController,
                              decoration: InputDecoration(
                                labelText: 'First Name',
                                hintText: 'Edit first name',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                errorStyle: TextStyle(color: Colors.red),
                              ),
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                final nameRegExp = RegExp(r'^[A-Za-z ]+$');

                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }

                                if (!nameRegExp.hasMatch(value)) {
                                  return 'Please enter a valid first name (letters only)';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _enteredFName = value!;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _lnameController,
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                hintText: 'Edit last name',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                errorStyle: TextStyle(color: Colors.red),
                              ),
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                final nameRegExp = RegExp(r'^[A-Za-z ]+(\d*)$');

                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }

                                if (!nameRegExp.hasMatch(value)) {
                                  return 'Please enter a valid last name (letters and optional digits at the end)';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _enteredLName = value!;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                hintText: 'Edit Phone Number',
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                errorStyle: TextStyle(color: Colors.red),
                              ),
                              keyboardType: TextInputType.phone,
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
                                _enteredPhone = value!;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            if (_authenticating)
                              CircularProgressIndicator(
                                color: Colors.blue, // Set the color of the progress indicator
                              ),
                            SizedBox(height: 5,),
                            ElevatedButton(
                              onPressed: () async {
                                final _isValid = _formKey.currentState!.validate();
                                if (!_isValid) {
                                  return;
                                }
                                setState(() {
                                  _authenticating = true;
                                });
                                _formKey.currentState!.save();
                                await FirebaseFirestore.instance
                                    .collection("Contacts")
                                    .doc("${widget.docId.toString()}")
                                    .update({
                                  'FName': _enteredFName,
                                  'LName': _enteredLName,
                                  'Phone': _enteredPhone,
                                });
                                setState(() {
                                  _authenticating = false;
                                });

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Update",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurple, // Button background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 16), // Button padding
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
