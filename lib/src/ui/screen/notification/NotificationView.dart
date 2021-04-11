import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart' as AppColor;
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/Models/Notification.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart'as AppTypo;
class NotificationView extends StatelessWidget {
  final List<Notification> _notifications = <Notification>[
    Notification("Bapak Greg mengirimkan pesan baru", "20 Sep"),
    Notification("Pesanan Sedang di Proses", "19 Sep"),
    Notification("Pesanan Sedang di Proses", "18 Sep"),
  ];


  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              AppBarContainer(
                  context, "Notifkasi", null, Colors.white),
              Expanded(child:
              ListView.separated(
                padding:
                // EdgeInsets.only(top: _screenWidth * (5 / 100)),
                EdgeInsets.all(_screenWidth * (5 / 100)),
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: _notifications.length,
                itemBuilder: (context, index) =>
                    _buildNotificationListItem(context, index),
              )),
            ],
          ),
        ));
  }
  Dismissible _buildNotificationListItem(BuildContext context, int index) {
    final Notification item = this._notifications[index];
    return Dismissible(
      key: Key(index.toString()),
      onDismissed: (direction) => Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Notif ${index + 1} terhapus"),
        ),
      ),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: AppColor.redTextColor,
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              FlutterIcons.delete_mco,
              color: Colors.white,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              "Delete",
              style: AppTypo.overlineInv,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      movementDuration: Duration(milliseconds: 750),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(7.5),
        color: Colors.white,
        shadowColor: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.message,
                style: AppTypo.body1,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: 5),
              Text(
                item.time,
                style: AppTypo.overline.copyWith(color: AppColor.colorPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

