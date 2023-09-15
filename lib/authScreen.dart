import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class authScreen extends StatefulWidget {
  const authScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _authScreen();
  }
}

var _islogin = true;
final _firebase = FirebaseAuth.instance;
User? _curentUser = FirebaseAuth.instance.currentUser;

class _authScreen extends State<authScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredUserName = '';
  var _enteredPassword = '';
  var _authenticating = false;
  void submit() async {
    final _isValid = _formKey.currentState!.validate();
    if (!_isValid) {
      return;
    }
    _formKey.currentState!.save();
    print(_enteredEmail);
    print(_enteredPassword);
    print(_firebase);

    try {
      setState(() {
        _authenticating = true;
      });
      if (_islogin) {
        final userCredential = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.uid)
            .set({
          'userName': _enteredUserName,
          'email': _enteredEmail,
          'userId': _curentUser?.uid,
        });
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed'),
        ),
      );
    }
    print("completed");
    setState(() {
      _authenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      // backgroundColor: Colors.black,
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
              margin: EdgeInsets.all(8),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Container(
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_islogin)
                              CircleAvatar(
                                radius: 30,
                                foregroundImage:
                                    AssetImage('assets/contact2.png'),
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                prefixIcon:
                                    Icon(Icons.email), // Prefix icon for email
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
                                    color: Colors
                                        .green, // Border color when focused
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
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (!_islogin)
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'UserName',
                                  hintText: 'Enter your username',
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
                                      color: Colors
                                          .green, // Border color when focused
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a username';
                                  }

                                  // Check if the username contains at least 6 characters
                                  if (value.length < 3) {
                                    return 'Must contain at least 3 characters';
                                  }

                                  if (value.contains(' ')) {
                                    return 'Username cannot contain spaces';
                                  }

                                  // Check if the username contains only letters, numbers, and underscores
                                  if (!RegExp(r'^[a-zA-Z0-9_]+$')
                                      .hasMatch(value)) {
                                    return 'Username can only contain letters, numbers, and underscores';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enteredUserName = value!;
                                },
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                prefixIcon: Icon(
                                    Icons.lock), // Prefix icon for password
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
                                    color: Colors
                                        .green, // Border color when focused
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
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }

                                // Check if the password contains at least 8 characters
                                if (value.length < 6) {
                                  return 'Password must contain at least 8 characters';
                                }

                                // Check if the password contains at least one uppercase letter
                                if (!value.contains(RegExp(r'[A-Z]'))) {
                                  return 'Must contain at least one Uppercase letter';
                                }

                                // Check if the password contains at least one lowercase letter
                                if (!value.contains(RegExp(r'[a-z]'))) {
                                  return 'Must contain at least one lowercase letter';
                                }

                                // Check if the password contains at least one digit
                                if (!value.contains(RegExp(r'[0-9]'))) {
                                  return 'Password must contain at least one digit';
                                }

                                // Check if the password contains at least one special character
                                if (!value.contains(
                                    RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                  return 'Password must contain at least one special character';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (_authenticating)
                              const CircularProgressIndicator(),
                            if (!_authenticating)
                              ElevatedButton(
                                // Setst
                                onPressed: submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                                child: Text(_islogin ? 'login' : 'signup'),
                              ),
                            if (!_authenticating)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _islogin = !_islogin;
                                  });
                                },
                                child: Text(
                                  _islogin
                                      ? 'create an account'
                                      : 'I already have an account login',
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
