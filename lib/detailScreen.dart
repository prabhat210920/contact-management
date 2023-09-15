import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class detailScreen extends StatefulWidget {
  var docId, fname, lname, phone, userId;

  detailScreen(
      @required this.docId,
      @required this.fname,
      @required this.lname,
      @required this.phone,
      @required this.userId,
      );

  @override
  State<detailScreen> createState() => _detailScreenState();
}

class _detailScreenState extends State<detailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Detail'),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage('assets/contact2.png'),
                backgroundColor: Colors.white,
                // Add any border or shadow customization here
              ),
              SizedBox(height: 40.0),
              Text(
                '${widget.fname} ${widget.lname}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(Icons.call, 'Call', () {
                    // Handle call action
                  }),
                  _buildActionButton(Icons.message, 'Message', () {
                    // Handle message action
                  }),
                  _buildActionButton(Icons.video_call, 'Video', () {
                    // Handle video call action
                  }),
                ],
              ),
              SizedBox(height: 20.0),
              Card(
                elevation: 4.0,
                margin: EdgeInsets.all(16.0),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    size: 36.0,
                    color: Colors.blue,
                  ),
                  title: Text(
                    widget.phone.toString(),
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Phone',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    // Handle phone call action
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Function()? onTap) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          width: 60.0,
          height: 60.0,
          child: IconButton(
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            onPressed: onTap,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

