import 'package:flutter/material.dart';
import 'package:scrumboard/Model/TileCard.dart';

// ViewModel/Provider: Manages state and actions for the home screen
class ScrumboardProvider extends ChangeNotifier {
  // State variables
  final String _title = '';
  final String _description = '';

  // Getters for state variables
  String get title => _title;
  String get description => _description;

  // List to store cards
  List<CardDetails> productionlist = [];
  List<CardDetails> storylist = [];
  List<CardDetails> toDolist = [];
  List<CardDetails> doinglist = [];
  List<CardDetails> donelist = [];

  // Method to show a dialog to rename the image
  Future<void> showCreateDialog(BuildContext context) async {
    String newtitle = "";
    String newdescription = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tile'),
                onChanged: (value) {
                  newtitle = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  newdescription = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                addImageToList(newtitle, newdescription);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Method to update image details and notify listeners
  //void _updateImageDetails(String newtitle, String newdescription) {
  // _title = newtitle;
  // _imageName = newName;
  //  notifyListeners();
  //}

  // Method to add selected image details to the list
  void addImageToList(String title, String description) {
    if (title.isNotEmpty && description.isNotEmpty) {
      final newTileCardDetails = CardDetails(
        title: _title,
        description: _description
      );
      productionlist.add(newTileCardDetails);
      notifyListeners();
    }
  }
}
