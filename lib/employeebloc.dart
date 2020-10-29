import 'dart:async';
import 'employee.dart';

class EmployeeBloc {
  //List of employees that you are going to use.
  List<Employee> employeeList = [
    Employee(1, 'pritesh', 1000),
    Employee(2, 'pritesh', 2000),
    Employee(3, 'pritesh', 3000),
    Employee(4, 'pritesh', 4000),
    Employee(5, 'pritesh', 5000),
    Employee(6, 'pritesh', 6000),
    Employee(7, 'pritesh', 7000),
  ];

  //define StreamControllers that your are going to use.

  final employeeListStreamController = StreamController<List<Employee>>();

  final incrementStreamController = StreamController<Employee>();

  final decrementStreamController = StreamController<Employee>();

  Stream<List<Employee>> get employeeListStream =>
      employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      incrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      decrementStreamController.sink;

  EmployeeBloc() {
    employeeListStreamController.add(employeeList);
    incrementStreamController.stream.listen(incrementSalary);
    decrementStreamController.stream.listen(decrementSalary);
  }

  incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementedsalary = salary * 20 / 100;

    employeeList[employee.id - 1].salary = salary + incrementedsalary;

    employeeListSink.add(employeeList);
  }

  decrementSalary(Employee employee) {
    double salary = employee.salary;

    double decrementedSalary = salary * 20 / 100;
    employeeList[employee.id - 1].salary = salary - decrementedSalary;

    employeeListSink.add(employeeList);
  }

  void dispose() {
    employeeListStreamController.close();
    incrementStreamController.close();
    decrementStreamController.close();
  }
}
