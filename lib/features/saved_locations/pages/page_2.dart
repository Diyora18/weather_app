import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF391A49),
              Color(0xFF301D5C),
              Color(0xFF262171),
              Color(0xFF301D5C),
              Color(0xFF391A49),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 24, right: 24),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Saved Locations",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){},
                      child: Icon(Icons.search, color: Colors.white, size: 32)),
                ],
              ),
              SizedBox(height: 32),
              Container(
                width: 345,
                height: 153,
                decoration: BoxDecoration(
                  color: Color(0xFFAAA5A5).withAlpha(70),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
