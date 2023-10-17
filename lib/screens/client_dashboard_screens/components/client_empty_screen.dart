import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/client_back_app_bar.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientEmptyScreen extends StatelessWidget {
  const ClientEmptyScreen({
    required this.image,
    required this.title,
    required this.subtitle,
    super.key,
  });
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            ContractorBackAppBar(),
            SizedBox(
              height: size.height / 5.5,
            ),
            Image.asset(image),
            Text(
              title,
              style: emptyPageTitle,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              subtitle,
              style: emptyPageSubTitle,
            )
          ],
        ),
      ],
    );
  }
}
