import 'package:bloc/employee.dart';
import 'package:bloc/employeebloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EmployeeBloc employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flutter Bloc'),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: employeeBloc.employeeListStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            '${snapshot.data[index].id}',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${snapshot.data[index].name}',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '${snapshot.data[index].salary}',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              employeeBloc.employeeSalaryIncrement
                                  .add(snapshot.data[index]);
                            },
                            child: Icon(
                              Icons.thumb_up,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              employeeBloc.employeeSalaryDecrement
                                  .add(snapshot.data[index]);
                            },
                            child: Icon(
                              Icons.thumb_down,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
