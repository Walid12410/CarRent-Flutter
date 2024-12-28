import "package:carrent/Api/SearchService.dart";
import "package:carrent/Widget/Car/SearchCarCard.dart";
import "package:carrent/Widget/Toast/ToastError.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Car/CarModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";

class LatestCarSearchPage extends StatefulWidget {
  const LatestCarSearchPage({super.key});

  @override
  State<LatestCarSearchPage> createState() => _LatestCarSearchPageState();
}

class _LatestCarSearchPageState extends State<LatestCarSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Car> _searchResults = [];
  bool _isLoading = false;

  void _performSearch(String query) async {
    SearchService service = SearchService();
    setState(() {
      _isLoading = true;
    });

    try {
      List<Car> results = await service.searchCars(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      showToast('Something went wrong');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20).w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: tdGrey,
                        size: 20.w,
                      )),
                  SizedBox(height: 10.h),
                  Container(
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12).w,
                        border: Border.all(color: tdGrey)),
                    child: Padding(
                      padding: const EdgeInsets.all(5).w,
                      child: TextField(
                        cursorColor: tdGrey,
                        controller: _searchController,
                        onChanged: (value) {
                          _performSearch(_searchController.text);
                        },
                        style: TextStyle(fontSize: 12.sp, color: tdBlueLight),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search for special car",
                            hintStyle:
                                TextStyle(color: tdGrey, fontSize: 12.sp),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: tdGrey,
                              size: 20.w,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 500.h,
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: tdBlueLight,
                          ))
                        : _searchResults.isEmpty
                            ? Center(
                                child: Text(
                                'No results found',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: tdBlack,
                                    fontWeight: FontWeight.bold),
                              ))
                            : ListView.builder(
                                itemCount: _searchResults.length,
                                itemBuilder: (context, index) {
                                  final car = _searchResults[index];
                                  return SearchCarCard(car: car);
                                },
                              ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
