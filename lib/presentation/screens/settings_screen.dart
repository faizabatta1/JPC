
import 'package:flutter/material.dart';
import 'package:jpc/presentation/screens/general_settings.dart';

import '../../core/helpers/theme_helper.dart';

class SettingsScreen extends StatelessWidget {
  static const String settingsScreen = '/settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ThemeHelper.primaryColor,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          SizedBox(height: 20),
          _buildGeneralSettingsTile(context),
          SizedBox(height: 10),
          _buildNotificationsTile(context),
          SizedBox(height: 10),
          _buildSoundTile(),
          SizedBox(height: 10),
          _buildAccountTile(),
          SizedBox(height: 20),
          _buildLogoutButton(context),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGeneralSettingsTile(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => GeneralSettings())
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            Icons.settings,
            size: 30,
            color: ThemeHelper.primaryColor,
          ),
          title: Text(
            'General Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: ThemeHelper.secondaryColor,
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildNotificationsTile(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GeneralSettings())
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            Icons.notifications,
            size: 30,
            color: ThemeHelper.primaryColor,
          ),
          title: Text(
            'Notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: ThemeHelper.secondaryColor,
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildSoundTile() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          Icons.multitrack_audio,
          size: 30,
          color: ThemeHelper.primaryColor,
        ),
        title: Text(
          'Sound',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 20,
          color: ThemeHelper.secondaryColor,
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildAccountTile() {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
            'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
      ),
      title: Text(
        'John Doe',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        'johndoe@gmail.com',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        'Logout',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ThemeHelper.fullSizeSecondaryButtonStyle(context),
    );
  }
}