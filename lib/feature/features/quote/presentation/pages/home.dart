import 'package:flutter/material.dart';
import 'package:quote/feature/features/quote/data/datasources/quote_remote_source.dart';
import 'package:quote/feature/features/quote/data/repositories/quote_repository_impl.dart';
import 'package:quote/feature/features/quote/domain/usecases/quote_usecase.dart';
import 'package:quote/feature/features/quote/presentation/bloc/quote_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    http.Client client = http.Client();
    QuoteRepositoryImpl repo = QuoteRepositoryImpl(QuoteRemoteDataSourceImpl(client: client)); 
    return BlocProvider(
      create: (context) =>  QuoteBloc(GetUsecase(repo)),
      child: MaterialApp(
      title: 'Dropdown Form Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    )
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedValue = "age"; // Default selected value

  List<String> dropdownItems = [
    "age", "alone", "amazing", "anger", "architecture", "art",
    "attitude", "beauty", "best", "birthday", "business", "car",
    "change", "communications", "computers", "cool", "courage",
    "dad", "dating", "death", "design", "dreams", "education",
    "environmental", "equality", "experience", "failure", "faith",
    "family", "famous", "fear", "fitness", "food", "forgiveness",
    "freedom", "friendship", "funny", "future", "god", "good",
    "government", "graduation", "great", "happiness", "health",
    "history", "home", "hope", "humor", "imagination",
    "inspirational", "intelligence", "jealousy", "knowledge",
    "leadership", "learning", "legal", "life", "love",
    "marriage", "medical", "men", "mom", "money", "morning",
    "movies", "success"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dropdown Form Example"),
      ),
      body:  BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          if (state is QuoteLoadingState){
            return const Center(child: const CircularProgressIndicator());
          } else if (state is QuoteInitial){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton<String>(
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Perform an action based on the selected value
                      print("Selected value: $selectedValue");
                      BlocProvider.of<QuoteBloc>(context).add(GetQuoteEvent(selectedValue),);                     
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            );
          } else if (state is GetQuoteSuccess){
            return Text(state.quote.quote);
          } else{
            return const Text('ERROR');
          }
        }
      ),
    );
  }
}
