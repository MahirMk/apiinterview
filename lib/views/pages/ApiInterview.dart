import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiInterview extends StatefulWidget {

  @override
  State<ApiInterview> createState() => _ApiInterviewState();
}

class _ApiInterviewState extends State<ApiInterview> {

  Future<List> alldata;

  Future<List> getdata() async {
    Uri url = Uri.parse("https://invicainfotech.com/apicall/mydata");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      print(json);
      return json["contacts"];
    } else {
      print("API Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade900,
        title: Text("Api Interview"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300.0,
              child: FutureBuilder(
                future: alldata,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length <= 0) {
                      return Center(
                        child: Text("No Data"),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Container(
                                  child: Image.network(
                                    snapshot.data[index]["userimage"].toString(),height: 100,width: 100,),
                                ),
                              ),
                              Text(snapshot.data[index]["id"].toString(),),
                            ],
                          );
                        },
                      );
                    }
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              height: 300.0,
              child: FutureBuilder(
                future: alldata,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length <= 0) {
                      return Center(
                        child: Text("No Data"),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Container(
                                  child: Text(
                                    snapshot.data[index]["email"].toString()),
                                ),
                              ),
                              Text(snapshot.data[index]["id"].toString(),),
                            ],
                          );
                        },
                      );
                    }
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
