import 'package:flutter/material.dart';
import '../../../models/test.dart';

class TestCard extends StatefulWidget {
  final Test test;

  TestCard({required this.test});

  @override
  _TestCardState createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          child: Icon(
            Icons.science,
            size: 35,
            color: Colors.blue[800], // Icon color
          ),
        ),
        title: Text(widget.test.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(widget.test.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: IconButton(
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
          onPressed: _toggleFavorite,
        ),
      ),
    );
  }
}
