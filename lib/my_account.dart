import 'package:flutter/material.dart';
import 'package:login/custom_scaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAccountScreen(), // Setting MyAccountScreen as the home screen
    );
  }
}

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Portfolio(), // Use the Portfolio widget inside the body
      ),
      showBottomNavBar: true,
      initialIndex: 1,
    );
  }
}

class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context)
          .size
          .height, // Ensure the container takes up the full height of the screen
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey[900]!, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with shadow for better effect
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('images/rizky_ganteng.png'),
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 30),

          // Name Section
          Text(
            'Rizky Adhita Saputra',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Mobile Developer',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.red[400],
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 30),

          // Age Section
          buildInfoSection('Age', '22'),

          // Contact Section
          buildInfoSection('Contact', '+62 8971234567', icon: Icons.phone),
          buildInfoSection('Email', 'rizkyadhitasaputra24@gmail.com',
              icon: Icons.email),

          SizedBox(height: 40),

          // Back to Home Button
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                  context); // Navigate back to the previous screen (Home)
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400], // Button color
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
            ),
            child: Text(
              'Back to Home',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoSection(String title, String content, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors.grey[400],
            ),
          SizedBox(width: icon != null ? 10 : 0),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red[500],
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(width: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
