import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lati_project/features/auth/screens/Register/chooseTopicsToShare.dart';

class MaleOrFemale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xffF4A1BE),
        title: Text(
          "4/2",
          style: GoogleFonts.almarai(
            textStyle: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: Text(
                  "هل أنت؟",
                  style: GoogleFonts.almarai(
                    textStyle: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              CustomButton('أنثى'),
              SizedBox(height: 20),
              CustomButton('ذكر'),
              SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "وما المعالج الذي تفضله؟",
                  style: GoogleFonts.almarai(
                    textStyle: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomButton('لا تفضيل'),
              SizedBox(height: 20),
              CustomButton('امرأة'),
              SizedBox(height: 20),
              CustomButton('ذكر'),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => ChooseTopicsToShare());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff561789),
                    minimumSize: Size(double.minPositive, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'التالي',
                    style: GoogleFonts.almarai(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

class CustomButton extends StatefulWidget {
  final String title;

  CustomButton(this.title);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isPressed = !isPressed; // Toggle the pressed state
        });
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(350, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: isPressed ? Colors.purple : Colors.white,
        foregroundColor: isPressed ? Colors.white : Colors.deepPurple,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          widget.title,
          style: GoogleFonts.almarai(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}