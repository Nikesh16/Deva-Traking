import 'package:Deva_Tracking/view_model/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view_model/utils/colors.dart';

class ProfileWidget extends StatelessWidget {
  final String? image;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? ontap;
  const ProfileWidget({
    super.key,
    this.image,
    required this.icon,
    this.iconColor,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.17,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: AppColor.white.withOpacity(0.5)),
          child: ClipOval(
              child: Image(
            image: NetworkImage(image ??
                "https://imgs.search.brave.com/hEdySpuEufPvuciR5ChDKWHOHdtvdmi4vJNwS46P8z8/rs:fit:1200:1200:1/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAxNi8w/OC8wOC8wOS8xNy9h/dmF0YXItMTU3Nzkw/OV8xMjgwLnBuZw"),
            fit: BoxFit.cover,
          )
              //  Image.asset(
              //   image,
              //   fit: BoxFit.cover,
              // ),
              ),
        ),
        InkWell(
          onTap: ontap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 3.0),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            height: MediaQuery.of(context).size.width * 0.06,
            width: MediaQuery.of(context).size.width * 0.05,
            child: Icon(
              icon,
              size: 14,
              color: AppColor.white,
            ),
          ),
        ),
      ],
    );
  }
}
