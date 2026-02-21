import 'package:flutter/material.dart';
import 'package:w4_practice/2_download_app/ui/screens/downloads/widgets/download_tile.dart';
import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widgets/download_controler.dart';

class DownloadsScreen extends StatefulWidget {

  const DownloadsScreen({super.key});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  @override
  void initState() {
    super.initState();
    // Create a controllers for each ressource
    for (Ressource ressource in ressources) {
      controllers.add(DownloadController(ressource));
    }
  }

  // Create the list of fake ressources
  final List<Ressource> ressources = [
    Ressource(name: "image1.png", size: 120),
    Ressource(name: "image2.png", size: 500),
    Ressource(name: "image3.png", size: 12000),
  ];

  final List<DownloadController> controllers = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColorProvider.currentThemeColor.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            "Downloads",
            style: AppTextStyles.heading.copyWith(
              color: themeColorProvider.currentThemeColor.color,
            ),
          ),

          SizedBox(height: 50),

          // TODO - Add the Download tiles
          Expanded(
            child: ListView.builder(
              itemCount: ressources.length,
              itemBuilder: (context, index) => DownloadTile(
                ressource: ressources[index],
                controller: controllers[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
