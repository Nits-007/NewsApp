import 'dart:convert' ;
import 'package:http/http.dart' as http ;
import 'package:NewsNest/components/searchbar.dart';
import 'package:NewsNest/pages/home.dart';


Future<List> fetchnews() async{
  http.Response response ;
  if(categoryInput.isEmpty){
    if(countryInput.isEmpty){
      response = await http.get(
        Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=in&category=technology&pageSize=100&apiKey=cec7484e22ac40cf98f965ecb6081257&q=${SearchBars.searchcontroller.text}'
        ),
      ) ;
    }
    else{
      response = await http.get(
        Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=technology&category=$categoryInput&pageSize=100&apiKey=cec7484e22ac40cf98f965ecb6081257&q=${SearchBars.searchcontroller.text}'
        ),
      ) ;
    }
  }
  else{
    if(countryInput.isEmpty){
      response = await http.get(
        Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=in&category=$categoryInput&pageSize=100&apiKey=cec7484e22ac40cf98f965ecb6081257&q=${SearchBars.searchcontroller.text}'
        ),
      ) ;
    }
    else{
      response = await http.get(
        Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=$countryInput&category=$categoryInput&pageSize=100&apiKey=cec7484e22ac40cf98f965ecb6081257&q=${SearchBars.searchcontroller.text}'
        ),
      ) ;
    }
  }
  
  Map result = jsonDecode(response.body);

  return (result['articles']) ;

}