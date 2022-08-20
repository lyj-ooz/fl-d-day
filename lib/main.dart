import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DDayList(),
    );
  }
}

class DDayList extends StatefulWidget {
  const DDayList({Key? key}) : super(key: key);

  @override
  State<DDayList> createState() => _DDayListState();
}

class _DDayListState extends State<DDayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('D-Day list'),
      ),
      body: Center(
        child: Container(
            child: Column(
          children: [
            Text('여태 저장된 디데이가 없습니다.'),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SettingDDay();
                  }));
                },
                child: Text('디데이 추가하기'))
          ],
        )),
      ),
    );
  }
}

class SettingDDay extends StatefulWidget {
  const SettingDDay({Key? key}) : super(key: key);

  @override
  State<SettingDDay> createState() => _SettingDDayState();
}

class _SettingDDayState extends State<SettingDDay> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('d-day'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '디데이 제목 입력'
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '내용을 입력하세요.';
                  }
                  return null;
                },
              ),
            ),
            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2022, 8, 20),
                    locale: LocaleType.ko,
                    currentTime: DateTime.now(), onChanged: (date) {
                  print('onChanged! $date');
                }, onConfirm: (date) {
                  print('onConfirm! $date');
                });
              },
              child: Text('날짜 선택하기'),
            ),
            ElevatedButton(onPressed: () {
              if(_formKey.currentState!.validate()) {
                print('폼 validate 문제 없음');
                // sqlLite로 기기에 저장 후 이전 화면으로 돌아가기
              }
            }, child: const Text('디데이 추가하기'))
          ],
        ),
      ),
    );
  }
}
