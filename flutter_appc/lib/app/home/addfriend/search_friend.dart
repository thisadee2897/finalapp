import 'package:flutter/material.dart';
import 'package:flutter_appc/app/home/models/phone.dart';
import 'package:flutter_appc/common_widgets/theme.dart';

class SearchFriend extends SearchDelegate {
  SearchFriend({
    String hintText = 'กรอกหมายเลขโทรศัพท์',
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.search,
        );
  List<Phone> searchFriend = [];

  TextEditingController controller;

  String get image => "assets/3.jpg";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Phone> sugFriend = [];
    sugFriend.clear();
    query.characters.length < 10
        ? sugFriend = []
        : sugFriend.addAll(_buildFriend()
            .where((p) => p.phoneNumber.startsWith(query))
            .toList());
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            shadowColor: Colors.black38,
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                height: 150,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Row(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                image: DecorationImage(
                                    image: AssetImage('assets/4.jpg'))),
                          ),
                          Text(
                            'dsadasad',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                print('addfriend');
              },
              child: Container(
                color: MyColors.primaryColorLight,
                height: 40,
                width: 100,
                child: Center(
                  child: Text(
                    'เพิ่มเพื่อน',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Phone> _buildFriend() {
    return [
      Phone(phoneNumber: '0956502897', id: '1'),
      Phone(phoneNumber: '0977777777', id: '2'),
      Phone(phoneNumber: '0888888888', id: '3'),
    ];
  }
}
