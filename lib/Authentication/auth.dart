import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

final _firebase = FirebaseAuth.instance;

class Auth extends StatefulWidget {
  @override
  State<Auth> createState() {
    return _Auth();
  }
}

class _Auth extends State<Auth> {
  final _form = GlobalKey<FormState>();
  var _isLogin = false;
  var _enterdEmail = "";
  var _enterdPassword = "";
  var _enterdUsername = "";

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    try {
      UserCredential userCredential;

      if (_isLogin) {
        userCredential = await _firebase.signInWithEmailAndPassword(
          email: _enterdEmail,
          password: _enterdPassword,
        );
      } else {
        userCredential = await _firebase.createUserWithEmailAndPassword(
          email: _enterdEmail,
          password: _enterdPassword,
        );

        // Save user data to Firestore only if it's a new user (i.e., sign-up)
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _enterdUsername,
          'email': _enterdEmail,
        });
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(
                    top: 30, bottom: 20, left: 20, right: 20),
                width: 200,
                child: Image.asset('assets/pet.png')),
            Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Email Address"),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return "The Entered Email is Incorrect";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enterdEmail = value!;
                              },
                            ),
                            if (!_isLogin)
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: "Username "),
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length < 4) {
                                    return 'Please enter at least 4 Characters';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enterdUsername = value!;
                                },
                              ),
                            TextFormField(
                                decoration: const InputDecoration(
                                    labelText: "Password"),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().length < 6) {
                                    return 'Password is not Correct';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enterdPassword = value!;
                                }),
                            const SizedBox(height: 16),
                            ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryFixedVariant,
                                ),
                                child: Text(_isLogin ? "Login" : "Sign Up")),
                            const SizedBox(
                              height: 6,
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Text(_isLogin
                                    ? "Create an Account"
                                    : "I Already have an Account"))
                          ],
                        ),
                      )),
                )),
          ],
        )));
  }
}
