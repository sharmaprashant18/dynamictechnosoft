import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Required for JSON encoding/decoding of the text list

/// A StatefulWidget that demonstrates storing multiple text entries
/// using SharedPreferences with full CRUD operations
class SharedPreferencesPage extends StatefulWidget {
  const SharedPreferencesPage({super.key});

  @override
  State<SharedPreferencesPage> createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  final TextEditingController textEditingController = TextEditingController();

  SharedPreferences? _prefs;

  List<String> savedTexts = [];

  @override
  void initState() {
    super.initState();
    // Initialize SharedPreferences when widget is created
    _initializePrefs();
  }

  @override
  void dispose() {
    // Clean up resources when widget is disposed
    textEditingController.dispose();
    super.dispose();
  }

  /// Initializes SharedPreferences and loads existing saved texts
  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSavedTexts();
  }

  /// Loads saved texts from SharedPreferences
  /// The texts are stored as a JSON array string
  void _loadSavedTexts() {
    // Retrieve saved texts or use empty array if none exist
    final textsJson = _prefs?.getString('texts') ?? '[]';
    setState(() {
      // Convert JSON array string back to List<String>
      savedTexts = List<String>.from(jsonDecode(textsJson));
    });
  }

  /// Saves a new text entry to the list and persists it
  Future<void> save() async {
    // Validate input is not empty
    if (textEditingController.text.isEmpty) {
      _showSnackBar('Please enter some text');
      return;
    }

    try {
      // Add new text to the list
      savedTexts.add(textEditingController.text);

      // Convert list to JSON string and save to SharedPreferences
      await _prefs?.setString('texts', jsonEncode(savedTexts));

      setState(() {
        textEditingController.clear(); // Clear input field after saving
      });
      _showSnackBar('Text saved successfully');
    } catch (e) {
      _showSnackBar('Error saving text: $e');
    }
  }

  /// Deletes a specific text entry at the given index
  Future<void> deleteText(int index) async {
    try {
      // Remove text at specified index
      savedTexts.removeAt(index);

      // Update SharedPreferences with modified list
      await _prefs?.setString('texts', jsonEncode(savedTexts));
      _showSnackBar('Text deleted successfully');
    } catch (e) {
      _showSnackBar('Error deleting text: $e');
    }
  }

  /// Deletes all saved texts
  Future<void> deleteAll() async {
    try {
      // Clear the list in memory
      savedTexts.clear();
      // Save empty array to SharedPreferences
      await _prefs?.setString('texts', '[]');
      _showSnackBar('All texts deleted successfully');
    } catch (e) {
      _showSnackBar('Error deleting texts: $e');
    }
  }

  /// Helper method to show feedback to the user
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Pereferences'),
        // Show delete all button only when there are saved texts
        actions: [
          if (savedTexts.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: deleteAll,
              tooltip: 'Delete All',
            ),
        ],
      ),
      // Show loading indicator during async operations
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Input section: Text field and save button
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Enter text',
                    hintText: 'Type something to save',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: save,
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // List of saved texts
          Expanded(
            child: savedTexts.isEmpty
                // Show placeholder when no texts are saved
                ? const Center(
                    child: Text(
                      'No saved texts',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                // ListView of saved texts with delete buttons
                : ListView.builder(
                    itemCount: savedTexts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(savedTexts[index]),
                          // Delete button for each text entry
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteText(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
