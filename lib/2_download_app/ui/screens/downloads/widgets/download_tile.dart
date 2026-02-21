import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatefulWidget {
  const DownloadTile({
    super.key,
    required this.controller,
    required this.ressource,
  });

  final DownloadController controller;
  final Ressource ressource;

  @override
  State<DownloadTile> createState() => _DownloadTileState();
}

class _DownloadTileState extends State<DownloadTile> {
  // TODO
  IconData getIcon(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.notDownloaded:
        return Icons.download;
      case DownloadStatus.downloading:
        return Icons.downloading;
      case DownloadStatus.downloaded:
        return Icons.folder;
    }
  }

  double getSize(double progress) {
    return ((progress / 100) * widget.ressource.size);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
        return ListTile(
          title: Text(widget.ressource.name),
          subtitle: widget.controller.status == DownloadStatus.downloading ? Text(
            '${widget.controller.progress} % completed - ${getSize(widget.controller.progress)} of ${widget.ressource.size} MB',
          ) : null,
          trailing: IconButton(
            onPressed: () {
              widget.controller.startDownload();
            },
            icon: Icon(getIcon(widget.controller.status)),
          ),
        );
      },
    );
  }
}
