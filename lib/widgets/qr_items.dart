import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models.dart/qr_info_provider.dart';
import 'scan_result.dart';

class QrItems extends StatelessWidget {
  final String id;
  final String info;
  final DateTime dateTime;
  final IconData icon;
  const QrItems({super.key, 
    required this.id,
    required this.info,
    required this.dateTime,
    required this.icon,
  });

  String get formatedDateTime =>
      'Saved on ${DateFormat('dd/MM/yyy').format(dateTime)} at ${DateFormat('hh:mm a').format(dateTime)}';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(52, 58, 64, 1),
      elevation: 10,
      margin: const EdgeInsets.all(15),
      child: ListTile(
        textColor: Colors.white,
        leading: Icon(
          icon,
          color: const Color.fromRGBO(146, 224, 0, 1),
        ),
        title: Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          formatedDateTime,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            Provider.of<QrInfo>(
              context,
              listen: false,
            ).deleteQRInfo(id);
          },
          icon: const Icon(
            Icons.delete,
            color: Color.fromRGBO(146, 224, 0, 1),
          ),
        ),
        onTap: () => Navigator.of(context).pushNamed(
          ScanResult.routeName,
          arguments: info,
        ),
      ),
    );
  }
}
