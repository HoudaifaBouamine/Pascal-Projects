program RockPaperScissors;


type
  enGameChoice = record
    Stone: Integer;
    Paper: Integer;
    Scissors: Integer;
  end;

  enWinner = record
    Player1: Integer;
    Computer: Integer;
    Draw: Integer;
  end;

  stRoundInfo = record
    RoundNumber: Integer;
    Player1Choice: Integer;
    ComputerChoice: Integer;
    Winner: Integer;
  end;

  stGameResults = record
    GameRounds: Integer;
    Player1WinTimes: Integer;
    Computer2WinTimes: Integer;
    DrawTimes: Integer;
    GameWinner: Integer;
  end;

var
  TheWinner: enWinner;
  TheChoice: enGameChoice;

function RandomNumber(From, ToVal: Integer): Integer;
begin
  RandomNumber := Random(ToVal - From + 1) + From;
end;

function WinnerName(Winner: Integer): String;
begin

    if(Winner = TheWinner.Player1) then 
        WinnerName := 'Player 1'
    else if (Winner = TheWinner.Computer) then
        WinnerName := 'Computer'
    else if (Winner = TheWinner.Draw) then
        WinnerName := 'Draw';
        
end;

function WhoWonTheRound(RoundInfo: stRoundInfo): integer;
var Result : integer;
begin
  Result := TheWinner.Draw;
  
  if RoundInfo.Player1Choice = RoundInfo.ComputerChoice then
    Result := TheWinner.Draw
  else
  begin
  
    if( (RoundInfo.Player1Choice = TheChoice.Paper) 
        and (RoundInfo.ComputerChoice = TheChoice.Stone) ) then
        Result := TheWinner.Player1
    else if ( (RoundInfo.Player1Choice = TheChoice.Stone) 
        and (RoundInfo.ComputerChoice = TheChoice.Scissors)) then
        Result := TheWinner.Player1
    else if ((RoundInfo.Player1Choice = TheChoice.Scissors) 
        and (RoundInfo.ComputerChoice = TheChoice.Paper)) then
        Result := TheWinner.Player1
    else
        Result := TheWinner.Computer;
  end;
  
  WhoWonTheRound := Result;
end;

function ChoiceName(Choice: Integer): String;
const
  arrGameChoices: array [1..3] of String = ('Stone', 'Paper', 'Scissors');
begin
  ChoiceName := arrGameChoices[Choice];
end;

procedure PrintRoundResults(RoundInfo: stRoundInfo);
begin
  WriteLn;
  WriteLn('____________Round [', RoundInfo.RoundNumber, '] ____________');
  WriteLn;
  WriteLn('Player1 Choice: ', ChoiceName(RoundInfo.Player1Choice));
  WriteLn('Computer Choice: ', ChoiceName(RoundInfo.ComputerChoice));
  WriteLn('Round Winner : [', WinnerName(RoundInfo.Winner), ']');
  WriteLn('__________________________________');
end;

function WhoWonTheGame(Player1WinTimes, ComputerWinTimes: Integer): Integer;
begin
  if Player1WinTimes > ComputerWinTimes then
    WhoWonTheGame := TheWinner.Player1
  else if ComputerWinTimes > Player1WinTimes then
    WhoWonTheGame := TheWinner.Computer
  else
    WhoWonTheGame := TheWinner.Draw;
end;

function FillGameResults(GameRounds, Player1WinTimes, ComputerWinTimes, DrawTimes: Integer): stGameResults;
var Result : stGameResults;
begin
  Result.GameRounds := GameRounds;
  Result.Player1WinTimes := Player1WinTimes;
  Result.Computer2WinTimes := ComputerWinTimes;
  Result.DrawTimes := DrawTimes;
  Result.GameWinner := WhoWonTheGame(Player1WinTimes, ComputerWinTimes);
  
  FillGameResults := Result;
end;

function ReadPlayer1Choice: Integer;
var Result:integer;
begin
  repeat
    WriteLn('Your Choice: [1]:Stone, [2]:Paper, [3]:Scissors ? ');
    ReadLn(Result);
  until (Result >= 1) and (Result <= 3);
  
  ReadPlayer1Choice:= Result;
end;

function GetComputerChoice: Integer;
begin
  GetComputerChoice := RandomNumber(1, 3);
end;

procedure ShowGameOverScreen;
begin
  WriteLn('__________________________________________________________');
  WriteLn;
  WriteLn(' +++ G a m e O v e r +++');
  WriteLn('__________________________________________________________');
end;

procedure ShowFinalGameResults(GameResults: stGameResults);
begin
  WriteLn('_____________________ [Game Results]_____________________');
  WriteLn;
  WriteLn('Game Rounds : ', GameResults.GameRounds);
  WriteLn('Player1 won times : ', GameResults.Player1WinTimes);
  WriteLn('Computer won times : ', GameResults.Computer2WinTimes);
  WriteLn('Draw times : ', GameResults.DrawTimes);
  WriteLn('Final Winner : ', WinnerName(GameResults.GameWinner));
  WriteLn('___________________________________________________________');
end;

function ReadHowManyRounds: Integer;
var Result : integer;
begin
  repeat
    WriteLn('How Many Rounds 1 to 10 ? ');
    ReadLn(Result);
  until (Result >= 1) and (Result <= 10);
  ReadHowManyRounds := Result;
  
end;

function PlayGame(HowManyRounds: integer): stGameResults;
var
  RoundInfo: stRoundInfo;
  Player1WinTimes, ComputerWinTimes, DrawTimes, GameRound: ShortInt;
begin
  Player1WinTimes := 0;
  ComputerWinTimes := 0;
  DrawTimes := 0;

  for GameRound := 1 to HowManyRounds do
  begin
    WriteLn;
    WriteLn('Round [', GameRound, '] begins:');
    
    RoundInfo.RoundNumber := GameRound;
    RoundInfo.Player1Choice := ReadPlayer1Choice;
    RoundInfo.ComputerChoice := GetComputerChoice;
    RoundInfo.Winner := WhoWonTheRound(RoundInfo);

    // Increase win/Draw counters
    if(RoundInfo.Winner = TheWinner.Player1) then 
        Player1WinTimes := Player1WinTimes + 1
        
    else if(RoundInfo.Winner = TheWinner.Computer) then 
        ComputerWinTimes := ComputerWinTimes + 1
        
    else if(RoundInfo.Winner = TheWinner.Draw) then 
        DrawTimes := DrawTimes + 1;

    PrintRoundResults(RoundInfo);
  end;

  PlayGame := FillGameResults(HowManyRounds, Player1WinTimes, ComputerWinTimes, DrawTimes);
end;


procedure StartGame;
var
  PlayAgain: Char;
  GameResults: stGameResults;
begin
  repeat
    GameResults := PlayGame(ReadHowManyRounds);
    ShowGameOverScreen;
    ShowFinalGameResults(GameResults);
    WriteLn;
    WriteLn('Do you want to play again? Y/N? ');
    ReadLn(PlayAgain);
  until ( (PlayAgain = 'N') or (PlayAgain = 'n') );
end;

procedure InitGlobalVariables;
begin
  TheWinner.Player1 := 1;
  TheWinner.Computer := 2;
  TheWinner.Draw := 3;

  TheChoice.Stone := 1;
  TheChoice.Paper := 2;
  TheChoice.Scissors := 3;
end;



begin
  Randomize;
  InitGlobalVariables;
  StartGame;
end.