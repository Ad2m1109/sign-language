import 'package:flutter/material.dart';
import 'another_screen.dart';
import 'add_friend_screen.dart';
import 'about_page.dart';
import 'sign_in_page.dart';
import 'services/api_service.dart';
import 'utils/user_preferences.dart';
import 'conversation_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "Loading...";
  List<String> friends = []; // Dynamically fetched friends list
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userId = await UserPreferences.getUserId();
      final token = await UserPreferences.getUserToken();
      if (userId != null && token != null) {
        final userProfile = await ApiService.getUserProfile(userId, token);
        setState(() {
          userName = userProfile['name']; // Use the connected user's name
          friends = List<String>.from(userProfile['friends']); // Fetch friends
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data: $e')),
      );
    }
  }

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void _showCloseAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Close Account"),
        content: Text("Are you sure you want to close your account?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  void _navigateToAddFriendScreen() async {
    // Navigate to AddFriendScreen and wait for it to return
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFriendScreen()),
    );
    // Reload the friends list after returning
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.blue,
        title: Text(userName), // Dynamically display the connected user's name
        actions: [
          IconButton(
            icon: Icon(Icons.dark_mode),
            onPressed: _toggleDarkMode,
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: _showCloseAccountDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isDarkMode ? Colors.grey[700] : Colors.blue[100],
              child: Text(
                friends[index][0]
                    .toUpperCase(), // First letter of friend's email
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            title: Text(
              friends[index],
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            onTap: () async {
              try {
                final userId = await UserPreferences.getUserId();
                final token = await UserPreferences.getUserToken();

                if (userId != null && token != null) {
                  // Fetch the conversation ID for the selected friend
                  final conversationId = await ApiService.getConversationId(
                    userId,
                    friends[index],
                    token,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConversationPage(
                        friendEmail: friends[index],
                        conversationId: conversationId,
                      ),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to load conversation: $e')),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddFriendScreen, // Use the new method
        child: Icon(Icons.add),
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.blue,
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
    );
  }
}
