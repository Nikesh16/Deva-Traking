import 'package:Deva_Tracking/view_model/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view_model/utils/colors.dart';

class TilePlayerScreen extends StatefulWidget {
  const TilePlayerScreen({
    super.key,
    this.imageUrl,
    required this.title,
    required this.subtitle,
    this.iconData1,
    this.delete1,
  });

  final String? imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback? delete1;

  final IconData? iconData1;

  @override
  _TilePlayerScreenState createState() => _TilePlayerScreenState();
}

class _TilePlayerScreenState extends State<TilePlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
        leading: Container(
          width: MediaQuery.of(context).size.width * 0.17,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: AppColor.white.withOpacity(0.5)),
          child: ClipOval(
            child: Image(
              image: NetworkImage(
                  widget.imageUrl ?? AppConstant.userPlaceholderImage),
              fit: BoxFit.cover,
            ),
            // Image.asset(
            //   widget.imageUrl ?? "",
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColor.white,
              ),
        ),
        subtitle: Text(
          widget.subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColor.white,
              ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (widget.iconData1 != null)
              IconButton(
                onPressed: () {
                  widget.delete1?.call();
                },
                icon: Icon(
                  widget.iconData1,
                  color: AppColor.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
