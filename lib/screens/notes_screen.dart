import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note_model.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen>
    with SingleTickerProviderStateMixin {
  // final Map _categories = {
  //   "Food": "12",
  //   "Cars": "33",
  //   "Buy": "32",
  //   "Deutsch": "45",
  //   "English": "32"
  // };

  int _selectedCategoryIndex = 0;
  TabController _tabController;
  final DateFormat _dateFormatter = DateFormat("dd MMM");
  final DateFormat _timeFormatter = DateFormat("h:mm");

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
  }

  Widget _buildCategoryCard(int index, String title, int count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        width: 175,
        height: 240,
        decoration: BoxDecoration(
          color: _selectedCategoryIndex == index
              ? Color(0xff417bfb)
              : Color(0xfff5f7fb),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            _selectedCategoryIndex == index
                ? BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  )
                : BoxShadow(color: Colors.transparent),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                title,
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Color(0xffafb4c6),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Color(0xfff5f7fb),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                notes[0].title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _timeFormatter.format(notes[0].date),
                style: TextStyle(
                  color: Color(0xffafb4c6),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            notes[0].content,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _dateFormatter.format(notes[0].date),
                style: TextStyle(
                  color: Color(0xffafb4c6),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff417bfb),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage("assets/images/profile.jpg"),
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Parsa Hosseini",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SizedBox(width: 20);
                }
                return _buildCategoryCard(
                    index - 1,
                    categories.keys.toList()[index - 1],
                    categories.values.toList()[index - 1]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Color(0xffafb4c6),
              indicatorWeight: 4,
              indicatorColor: Color(0xff417bfb),
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              tabs: [
                Tab(
                  child: Text(
                    "Notes",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Important",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Performed",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ...[
            _buildNoteCard(notes[0]),
            SizedBox(
              height: 20,
            ),
            _buildNoteCard(notes[1]),
          ]
        ],
      ),
    );
  }
}
