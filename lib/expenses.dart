import 'package:expese_tracker/widgets/chart/chart.dart';
import 'package:expese_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expese_tracker/models/expense.dart';
import 'package:expese_tracker/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});
 
  @override
  State<Expenses> createState() {
   return _ExpensesState();
  }
}
class _ExpensesState extends State<Expenses>{
final List<Expense> _resgiteredExpenses=[
  Expense(title: 'Flutter',
  amount: 19.99,
  date: DateTime.now(),
  category :Category.food,),
  Expense(title: 'Cinema',
  amount: 16.99,
  date: DateTime.now(),
  category :Category.work,),

];


void _openAddExpenseOverlay(){
showModalBottomSheet(
  useSafeArea: true,
  isScrollControlled: true,
  context: context, 
  builder:(ctx)=> NewExpense(onAddExpense:_addExpense ),);
}
void _addExpense( Expense expense){
  setState(() {
    _resgiteredExpenses.add(expense);
  });
}
void _removeExpense(Expense expense){
  final expenseIndex=_resgiteredExpenses.indexOf(expense);
  setState(() {
    _resgiteredExpenses.remove(expense);
  });
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    duration:const  Duration(seconds: 3),
    content:const Text('Expense deleted.'),
    action: SnackBarAction(label: "Undo", onPressed:(){
      setState(() {
        _resgiteredExpenses.insert(expenseIndex, expense);
      });
    }),));
}
 
  @override
  Widget build(BuildContext context) {
    final width =(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);

    Widget mainContent= const Center(child :Text('No Expenses found,Start adding some!'),);
    if(_resgiteredExpenses.isNotEmpty){
      mainContent=ExpensesList(expenses: _resgiteredExpenses,onRemoveExpense: _removeExpense,);
    }
   return  Scaffold(
    appBar: AppBar(
      title: const Text('Flutter Expenses Tracker'),
      actions: [
        IconButton(onPressed: _openAddExpenseOverlay,
         icon:const Icon(Icons.add)),
      ]
      ),
    body: width<600? 
    Column(
    children: [
       Chart(expenses: _resgiteredExpenses),
      Expanded(
        child : mainContent ),
    ],
   ):Row(
    children: [
       Expanded(child: Chart(expenses: _resgiteredExpenses)),
      Expanded(
        child : mainContent ),],
   ));
  }
}

