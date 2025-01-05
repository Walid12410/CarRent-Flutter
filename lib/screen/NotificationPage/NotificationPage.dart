import "package:carrent/Api/NotificationService.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/provider/Notification_Provider.dart";
import "package:carrent/screen/NotificationPage/Details/NotificationCard.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late ScrollController _scrollController;
  late NotificationProvider notificationProvider;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notificationProvider.getUserNotification();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      Provider.of<NotificationProvider>(context, listen: false)
          .getUserNotification();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(
              fontSize: 15.sp, color: tdBlueLight, fontWeight: FontWeight.bold),
        ),
        backgroundColor: tdWhite,
        shadowColor: tdWhite,
        surfaceTintColor: tdWhite,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20).w,
          child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
                color: tdGrey,
              )),
        ),
      ),
      body: Consumer<NotificationProvider>(
          builder: (context, notificationProvider, child) {
        if (notificationProvider.isLoading &&
            notificationProvider.userNotification.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: tdBlueLight,
            ),
          );
        }

        if (notificationProvider.userNotification.isEmpty) {
          return Center(
            child: Text(
              'Notification is empty',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: tdBlueLight,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                NotificationService service = NotificationService();
                notificationProvider.resetUserNotification();
                service.deleteNotification();
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 10).w,
                  child: Text(
                    'Clear notification',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: tdBlueLight,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: notificationProvider.userNotification.length +
                      (notificationProvider.hasMoreData ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == notificationProvider.userNotification.length) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: tdBlueLight,
                        ),
                      );
                    }
                    final notification =
                        notificationProvider.userNotification[index];
                    DateTime parsedDate = DateTime.parse(
                        notification.createdAt); // Parse the ISO date
                    String formattedDate =
                        DateFormat('MMM d, y, h:mm a').format(parsedDate);

                    return NotificationCard(
                        notification: notification,
                        formattedDate: formattedDate);
                  }),
            ),
          ],
        );
      }),
    );
  }
}
