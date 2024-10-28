import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsIcon extends StatefulWidget {
  @override
  _SettingsIconState createState() => _SettingsIconState();
}

class _SettingsIconState extends State<SettingsIcon> {
  OverlayEntry? _overlayEntry;
  bool isMenuVisible = false;

  @override
  void dispose() {
    _removeMenu();
    super.dispose();
  }

  // Create the overlay for the settings dropdown menu
  OverlayEntry _createMenuOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy - size.height  * 3, // Offset below the icon
        width: 300, // Menu width
        child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Log Out', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    _logOut(); // Log out functionality
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        _removeMenu();
                      },
                      icon: Icon(Icons.close, color: Colors.red),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleMenu() {
    if (isMenuVisible) {
      _removeMenu();
    } else {
      _showMenu();
    }
  }

  void _showMenu() {
    _overlayEntry = _createMenuOverlay();
    Overlay.of(context)?.insert(_overlayEntry!);
    setState(() {
      isMenuVisible = true;
    });
  }

  void _removeMenu() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;  // Clear reference after removal
      setState(() {
        isMenuVisible = false;
      });
    }
  }

  // Firebase log-out function
  Future<void> _logOut() async {
    try {
      await FirebaseAuth.instance.signOut(); // Firebase sign-out
      print('User logged out successfully');

    } catch (e) {
      print('Error logging out: $e');
    } finally {
     // _removeMenu(); // Close the menu after log-out
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleMenu,
      child: Icon(
        Icons.settings,
        color: Colors.white,
      ),
    );
  }
}
