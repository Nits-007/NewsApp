import 'package:flutter/material.dart';
import 'package:NewsNest/backend/functions.dart';
import 'package:NewsNest/components/newsbox.dart';
import 'package:NewsNest/components/searchbar.dart' ;
import 'package:NewsNest/utils/constants.dart';
import '../components/components.dart';

String categoryInput = "";
String countryInput = "" ;
String dropdownValue = 'India';
Map<String, String> countryMap = {
  'America': 'us',
  'Australia': 'au',
  'Brazil': 'br',
  'Canada': 'ca',
  'China' : 'cn' ,
  'France' : 'fr' ,
  'Great Britain' : 'gb' ,
  'India' : 'in' ,
  'Italy' : 'it' ,
  'Japan' : 'jp' ,
  'Russia' : 'ru' ,
  'South Africa' : 'sa' ,
  'UAE' : 'ua' ,
};


class Home extends StatefulWidget{
  const Home({super.key}) ;
  @override
  State<Home> createState(){
    return _HomeState() ;
  }
}
class _HomeState extends State<Home>{
  void _handleDrawerSelection(String value) {
    setState(() {
      categoryInput = value;
    });
  } 
  void _dropDownSelection(String value) {
    setState(() {
      countryInput = value;
    });
  } 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.red,
                  Colors.grey,
                ],
              ),
            ),
          ),
          title: Center(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'News',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 28 ,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  TextSpan(
                    text: 'Nest',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 28 ,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 50,
              child : DrawerHeader(
          
                decoration: BoxDecoration(
              
                  color: Colors.red,
                ),
                child: Text('Categories' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),),
              ),
            ),
            ListTile(
              title: const Text('Business' , style: TextStyle(color: Colors.white)),
              onTap: () {
                        _handleDrawerSelection('Business');
                        fetchnews() ;
                        Navigator.pop(context) ;
              },
            ),
            DividerWidget() ,
            ListTile(
              title: const Text('Entertainment', style: TextStyle(color: Colors.white)),
              onTap: () {
                        _handleDrawerSelection('Entertainment');
                        fetchnews() ;
                        Navigator.pop(context) ;
              },
            ),
            DividerWidget() ,
            ListTile(
              title: const Text('General', style: TextStyle(color: Colors.white)),
              onTap: () {
                        _handleDrawerSelection('General');
                        fetchnews() ;
                        Navigator.pop(context) ;
              },
            ),
            DividerWidget() ,
            ListTile(
              title: const Text('Health', style: TextStyle(color: Colors.white)),
              onTap: () {
                        _handleDrawerSelection('Health');
                        fetchnews() ;
                        Navigator.pop(context) ;
              },
            ),
            DividerWidget() ,
            ListTile(
              title: const Text('Science', style: TextStyle(color: Colors.white)),
              onTap: () {
                        _handleDrawerSelection('Science');
                        fetchnews() ;
                        Navigator.pop(context) ;
              },
            ),
            DividerWidget() ,
            ListTile(
              title: const Text('Sports', style: TextStyle(color: Colors.white)),
              onTap: () {
                        _handleDrawerSelection('Sports');
                        fetchnews() ;
                        Navigator.pop(context) ;
              },
            ),
            DividerWidget() ,
            ListTile(
              title: const Text('Technology', style: TextStyle(color: Colors.white)),
              onTap: () {
                        _handleDrawerSelection('Technology');
                        fetchnews() ;
                        Navigator.pop(context) ;
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(children: [
            SearchBars() ,
            const SizedBox(width: 12,) ,
            const Icon(Icons.location_city_sharp , color: Colors.white,) ,
            DropdownButton<String>(
              dropdownColor: Colors.black,
              value: dropdownValue,
              items: countryMap.keys.map<DropdownMenuItem<String>>((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(
                    key,
                    style: const TextStyle(fontSize: 14 , fontWeight: FontWeight.bold , color: Colors.white),
                  ),
                );
              }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              _dropDownSelection(countryMap[dropdownValue]!) ;
            });
          },
          )
          ],) ,
          
          Expanded(
            child: Container(
              width:  MediaQuery.of(context).size.width ,
              child: FutureBuilder<List>(
                future: fetchnews() ,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        return NewsBox(
                          url: snapshot.data![index]['url'] ,
                          imageurl: snapshot.data![index]['urlToImage'] ?? Constants.imageurl ,
                          title: snapshot.data![index]['title'] ,
                          time: snapshot.data![index]['publishedAt'] ,
                          description: snapshot.data![index]['description'].toString() ,
                        );
                      },);
                  } else if(snapshot.hasError){
                    return Text("${snapshot.error}") ;
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    )
                  ) ;
                },)
            )
          ) ,
        ],
      )
    ) ;
  }
}