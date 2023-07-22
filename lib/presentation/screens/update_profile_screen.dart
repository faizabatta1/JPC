import 'package:flutter/material.dart';
import 'package:jpc/core/helpers/theme_helper.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with existing user data (if available)
    _nameController.text = 'John Doe';
    _emailController.text = 'johndoe@gmail.com';
    _phoneController.text = '+1 555-123-4567';
    _addressController.text = '123 Main St, Anytown USA';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                      ),
                      radius: 60,
                    ),
                    if (_isEditing)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            // Add logic to change profile picture here
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildProfileField(
                label: 'Name',
                controller: _nameController,
                isEnabled: _isEditing,
              ),
              SizedBox(height: 10),
              _buildProfileField(
                label: 'Email',
                controller: _emailController,
                isEnabled: _isEditing,
              ),
              SizedBox(height: 10),
              _buildProfileField(
                label: 'Phone',
                controller: _phoneController,
                isEnabled: _isEditing,
              ),
              SizedBox(height: 10),
              _buildProfileField(
                label: 'Address',
                controller: _addressController,
                isEnabled: _isEditing,
              ),
              SizedBox(height: 30),
              _buildButtonsRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required bool isEnabled,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeHelper.primaryColor,
          minimumSize: Size(200,40)
        ),
        child: Text('Update',style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
