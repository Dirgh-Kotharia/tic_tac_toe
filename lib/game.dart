import 'package:flutter/material.dart';
import './buttons.dart';
import './dialogbox.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<GameButton> buttonList;

  var player1;
  var player2;
  var activePlayer;
  var noofmoves;

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    buttonList = setGame();

  }
  List<GameButton> setGame(){
    player1 = new List();
    player2 = new List();
    activePlayer = 1;
    noofmoves = 0;

    var buttons =<GameButton> [
    new GameButton(id : 1),
    new GameButton(id : 2),
    new GameButton(id : 3),
    new GameButton(id : 4),
    new GameButton(id : 5),
    new GameButton(id : 6),
    new GameButton(id : 7),
    new GameButton(id : 8),
    new GameButton(id : 9)];
    return buttons;
  }
  void playGame(GameButton gb){
    noofmoves += 1;
    setState(() {
      if(activePlayer == 1){
        gb.text='X';
        gb.bg = Colors.red;
        activePlayer = 2;
        player1.add(gb.id);
      }
      else{
        gb.text='O';
        gb.bg = Colors.blue;
        activePlayer = 1;
        player2.add(gb.id);
      }

      gb.enabled = false;
      checkWinner();
    });
  }

  void checkWinner(){
    var winner = -1;
    //row winner
    if(player1.contains(1) && player1.contains(2) && player1.contains(3)){
      winner = 1;
    }
    if(player2.contains(1) && player2.contains(2) && player2.contains(3)){
      winner = 2;
    }
    if(player1.contains(4) && player1.contains(5) && player1.contains(6)){
      winner = 1;
    }
    if(player2.contains(4) && player2.contains(5) && player2.contains(6)){
      winner = 2;
    }
    if(player1.contains(7) && player1.contains(8) && player1.contains(9)){
      winner = 1;
    }
    if(player2.contains(7) && player2.contains(8) && player2.contains(9)){
      winner = 2;
    }

    //column winner

    if(player1.contains(1) && player1.contains(4) && player1.contains(7)){
      winner = 1;
    }
    if(player2.contains(1) && player2.contains(4) && player2.contains(7)){
      winner = 2;
    }
    if(player1.contains(2) && player1.contains(5) && player1.contains(8)){
      winner = 1;
    }
    if(player2.contains(2) && player2.contains(5) && player2.contains(8)){
      winner = 2;
    }
    if(player1.contains(3) && player1.contains(6) && player1.contains(9)){
      winner = 1;
    }
    if(player2.contains(3) && player2.contains(6) && player2.contains(9)){
      winner = 2;
    }

    //diagonal check
    if(player1.contains(1) && player1.contains(5) && player1.contains(9)){
      winner = 1;
    }
    if(player2.contains(1) && player2.contains(5) && player2.contains(9)){
      winner = 2;
    }
    if(player1.contains(3) && player1.contains(5) && player1.contains(7)){
      winner = 1;
    }
    if(player2.contains(3) && player2.contains(5) && player2.contains(7)){
      winner = 2;
    }
    //checks complete
    if(winner != -1){
      if(winner == 1){
        for(int i=0 ; i<9 ;i++){

          buttonList[i].enabled = false;
        }
        showDialog(
            context: context,
            builder: (_) => DialogBox(
              "Player with X Won",
            "Press Reset to Play Again ", resetGame)
        );
        activePlayer = 0;
      }
      else{
        for(int i=0 ; i<9 ;i++){

          buttonList[i].enabled = false;
        }
        showDialog(
            context: context,
            builder: (_) => DialogBox(
                "Player with O Won",
                "Press Reset to Play Again ", resetGame)
        );
        activePlayer = 0;

      }

    }
    else{
      if(noofmoves == 9){
        showDialog(
            context: context,
            builder: (_) => DialogBox(
              "Match is Drawn !!!!",
              "Press Reset to Play Again", resetGame)
        );
        activePlayer = 0;
      }
    }

  }

  void resetGame(){
    if(Navigator.canPop(context))
      Navigator.pop(context);

      setState(() {
        buttonList = setGame();
      });
  }

  String displayTurn(){

      if(activePlayer == 1 ){
        return "X turn to play";
      }
      else if (activePlayer == 2 ){
        return "O turn to play";
      }
      else{
        return "Match Completed !!!";
      }

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("TIC-TAC-TOE", style: TextStyle(fontStyle:FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 24.0),),
          elevation:12.0 ,
          titleSpacing: 12.0,
        ),
        body: Material(
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 100.0,
                child: Center(
                    child: Text(displayTurn(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),)),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 9.0,
                      mainAxisSpacing: 9.0,
                    ),
                    padding: EdgeInsets.all(10.0),
                    itemCount: buttonList.length,
                    itemBuilder: (context,i) => new SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: RaisedButton(
                          padding: EdgeInsets.all(8.0),
                          onPressed: buttonList[i].enabled ? () => playGame(buttonList[i]) : null,
                          child: Text(buttonList[i].text,style: TextStyle(fontSize:60.0,color: Colors.white,fontWeight: FontWeight.bold),),
                          color: buttonList[i].bg,
                          disabledColor: buttonList[i].bg,
                      ),
                    ),
                  ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 0.0,bottom: 20.0),
                  height: 75.0,
                  width: 350.0,
                  child: RaisedButton(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child:
                      Text("Reset", style: TextStyle(color: Colors.white,fontSize: 20.0),),
                      color: Colors.deepPurple,
                      onPressed: resetGame,
                  ),
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
