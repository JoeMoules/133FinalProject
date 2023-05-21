import 'database_helper.dart';
import 'package:flutter/material.dart';

class OrderCompleted extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(backgroundColor:Colors.yellow, title: const Text('Order Completed', style: TextStyle(color: Colors.black),)),//appBar
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container (
                alignment: Alignment.center,
                child: Text(
                  "Order Completed!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //navigate users to Home page
            const SizedBox(height: 100),  //SizedBox
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Set the background color of the button
                onPrimary: Colors.yellow, // Set the text color
              ),
              onPressed:() {
                Navigator.pushNamed(context, 'Home',);
              },
              child: const Text('Back to main'),
            ),
          ],
        ),
      ),
    );
  }
}