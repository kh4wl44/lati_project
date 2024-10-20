import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lati_project/features/auth/screens/Register/common.dart';
import 'package:lati_project/features/auth/screens/Register/signup.dart';
import 'package:get/get.dart';
import 'package:lati_project/features/auth/screens/Therapist/TherapistHome.dart';
import 'package:lati_project/features/auth/screens/home_page.dart';
import 'forgetpassword.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final String token = jsonDecode(response.body)['token'];
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      await saveUserInfo(decodedToken['name'], decodedToken['email'],
          decodedToken['isTherapist'] ?? false);
      // await checkSavedInfo();

      Get.snackbar("Success", "Login successful");
      Get.to(
        () =>
            decodedToken['isTherapist'] ?? false ? TherapistHome() : HomePage(),
      );
      // Navigate to another screen or perform other actions
    } else {
      Get.snackbar("Error", "Invalid credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffF4A1BE),
              Color(0xffBF75D4),
              Color(0xff9064F4),
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'تسجيل الدخول',
                      style: GoogleFonts.almarai(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Center(
                    child: Container(
                      width: 350,
                      child: TextField(
                        controller: usernameController,
                        style: GoogleFonts.almarai(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "البريد الإلكتروني",
                          hintStyle: TextStyle(color: Color(0xff595959)),
                          prefixIcon: const Icon(Icons.person,
                              color: Color(0xff595959)),
                          filled: true,
                          fillColor: Colors.white54,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.purple),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      width: 350,
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: GoogleFonts.almarai(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: "كلمة السر",
                          hintStyle: TextStyle(color: Color(0xff595959)),
                          prefixIcon:
                              const Icon(Icons.lock, color: Color(0xff595959)),
                          filled: true,
                          fillColor: Colors.white54,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.purple),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => ForgetPassword());
                      },
                      child: Text(
                        'نسيت كلمة السر؟',
                        style: GoogleFonts.almarai(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await loginUser();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff103D78),
                        minimumSize: Size(double.minPositive, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'تسجيل الدخول',
                        style: GoogleFonts.almarai(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "ليس لديك حساب؟",
                      style: GoogleFonts.almarai(
                          color: Colors.white, fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => Signup(
                            isTherapist: null,
                          ));
                    },
                    child: Center(
                      child: Text(
                        'قم بإنشاء حساب جديد',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.almarai(
                            color: Color(0xff103D78), fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
