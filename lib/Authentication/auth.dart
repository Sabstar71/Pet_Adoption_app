import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:PawPalApp/theme_provider.dart";

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
        backgroundColor: ThemeProvider.lightBackground,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(
                    top: 60, bottom: 20, left: 20, right: 20),
                width: 200,
                child: Image.asset('assets/pet.png')),
            Text(
              'PawPal',
              style: ThemeProvider.headingStyle.copyWith(
                color: ThemeProvider.primaryAmber,
                fontSize: 32,
              ),
            ),
            Text(
              _isLogin ? 'Welcome Back!' : 'Create an Account',
              style: ThemeProvider.subheadingStyle.copyWith(
                color: ThemeProvider.lightTextColor,
              ),
            ),
            SizedBox(height: 20),
            Card(
                margin: const EdgeInsets.all(20),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                prefixIcon: Icon(Icons.email, color: ThemeProvider.primaryAmber),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: ThemeProvider.disabledColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 2),
                                ),
                                filled: true,
                                fillColor: ThemeProvider.cardColor,
                              ),
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
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  prefixIcon: Icon(Icons.person, color: ThemeProvider.primaryAmber),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: ThemeProvider.disabledColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: ThemeProvider.cardColor,
                                ),
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
                            SizedBox(height: 16),
                            TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  prefixIcon: Icon(Icons.lock, color: ThemeProvider.primaryAmber),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: ThemeProvider.disabledColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: ThemeProvider.cardColor,
                                ),
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
                            SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ThemeProvider.primaryAmber,
                                  foregroundColor: ThemeProvider.lightTextColor,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 2,
                                ),
                                child: Text(
                                  _isLogin ? "Login" : "Sign Up",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: ThemeProvider.accentColor,
                                ),
                                child: Text(
                                  _isLogin ? "Create an Account" : "I Already have an Account",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ))
                          ],
                        ),
                      )),
                )),
          ],
        )));
  }
}
