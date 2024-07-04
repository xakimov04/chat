import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  final Function(String email, String username, String password, bool isLogin)
      getUserDetails;
  final bool isLoading;

  const AuthForm(this.getUserDetails, this.isLoading, {super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _userData = {
    "email": "",
    "username": "",
    "password": ""
  };
  bool isLogin = true;

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.getUserDetails(
        _userData['email']!.trim(),
        _userData['username']!.trim(),
        _userData['password']!.trim(),
        isLogin,
      );
    }
  }

  Widget _buildTextField({
    required String key,
    required String labelText,
    required bool isPassword,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextFormField(
        key: ValueKey(key),
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Chat app",
                style: TextStyle(
                  fontFamily: 'GrandHotel',
                  fontSize: 50,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20.0),
              Card(
                color: Colors.white54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTextField(
                          key: 'email',
                          labelText: "Email manzili",
                          isPassword: false,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return "Iltimos to'g'ri email manzil kiriting.";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _userData['email'] = newValue!;
                          },
                        ),
                        if (!isLogin)
                          _buildTextField(
                            key: 'username',
                            labelText: "Username",
                            isPassword: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Iltimos username kiriting.";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _userData['username'] = newValue!;
                            },
                          ),
                        _buildTextField(
                          key: 'password',
                          labelText: "Parol",
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Iltimos parol kiriting.";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _userData['password'] = newValue!;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        if (widget.isLoading)
                          const CircularProgressIndicator()
                        else
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: _submit,
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  backgroundColor: Colors.blue,
                                ),
                                child: Text(
                                  isLogin ? "Kirish" : "Ro'yxatdan o'tish",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isLogin = !isLogin;
                                  });
                                },
                                child: Text(
                                  isLogin ? "Ro'yxatdan o'tish" : "Kirish",
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
