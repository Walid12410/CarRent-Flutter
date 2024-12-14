import 'dart:io'; // Import dart:io for File
import 'package:carrent/Api/UserService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrent/core/Color/color.dart';
import 'package:carrent/provider/User_Provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PhotoUploadCard extends StatefulWidget {
  const PhotoUploadCard({
    super.key,
  });

  @override
  _PhotoUploadCardState createState() => _PhotoUploadCardState();
}

class _PhotoUploadCardState extends State<PhotoUploadCard> {
  File? _imageFile;
  bool _isUploading = false; // Flag to track upload progress

  // Pick an image from gallery or camera
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Upload the picked image to the server
  Future<void> _uploadImageToServer() async {
    if (_imageFile == null) {
      return;
    }

    setState(() {
      _isUploading = true; // Set uploading flag to true
    });

    UserService service = UserService();

    try {
      if (_imageFile != null) {
        // String imagePath = _imageFile!.path; // Assuming _imageFile is not null
        // await service.uploadProfileImage(imagePath);
      }

      // After successful upload, update UI with the new profile image URL
      setState(() {
        _isUploading = false; // Reset uploading flag
      });

      // Optionally, update the user's profile picture or show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile image uploaded successfully')),
      );
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      // Handle the error (show error message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true);
    var userDetails = user.userDetails;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 70.w,
            height: 60.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10).w,
              child: _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      fit: BoxFit.fill,
                    )
                  : CachedNetworkImage(
                      imageUrl: userDetails!.photo!.url.isEmpty
                          ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                          : userDetails.photo!.url,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: tdBlueLight,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
            ),
          ),
          TextButton(
            onPressed: _isUploading
                ? null
                : _pickImage, // Disable picking during upload
            child: Text(
              _isUploading ? 'Uploading...' : 'Change profile picture',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: tdBlueLight,
                  fontWeight: FontWeight.w500),
            ),
          ),
          if (_imageFile != null && !_isUploading)
            ElevatedButton(
              onPressed: _uploadImageToServer, // Upload the image
              child: Text('Upload Image'),
            ),
        ],
      ),
    );
  }
}
