import "package:carrent/core/Color/color.dart";
import "package:carrent/provider/Company_Provider.dart";
import "package:carrent/screen/CompanyCarListPage/Details/CompanyListItem.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

class CompanyListPage extends StatefulWidget {
  const CompanyListPage({super.key});

  @override
  State<CompanyListPage> createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final company = Provider.of<CompanyProvider>(context, listen: false);
    await company.getAllCompany();
  }

  @override
  Widget build(BuildContext context) {
    final company = Provider.of<CompanyProvider>(context, listen: true);
    var allComapny = company.allCompanies;

    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        title: Text(
          'Company',
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
      body: SafeArea(
          child: FutureBuilder(
        future: _fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: tdBlack,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong, check your connection.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: tdGrey,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: allComapny.length,
              itemBuilder: (context, index) {
                final company = allComapny[index];
                return CompanyListItem(company: company);
              },
            );
          }
        },
      )),
    );
  }
}

