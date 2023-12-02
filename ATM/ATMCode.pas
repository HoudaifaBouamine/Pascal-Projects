
program atm_project;

var choice : integer;
 Balance : integer;
 PinCode : string;
 Running : boolean;

procedure Show_Menu();
begin

    writeln('=======================================================');
    writeln('                M a i n    M e n u                     ');
    writeln('=======================================================');
    writeln('   1) Show Balance');
    writeln('   2) Withdraw  (Get Money From Account)');
    writeln('   3) Deposit   (Put Money To The Account)');
    writeln('   4) Exit');
    writeln('=======================================================');

end;

function Read_Choice() : integer;
var Client_choice : integer;
begin

    write('Enter Your choice (Between 1 and 4) >> ');
    readln(Client_choice);

    while ((Client_choice > 4) OR (Client_choice < 1)) do
    begin

        writeln;
        writeln('Error : Number ',Client_choice,' is out of the range [1,4]');
        writeln;

        write('Enter Your choice (Between 1 and 4) >> ');
        readln(Client_choice);

    end;
    
    Read_Choice := Client_choice;

end;

procedure Show_Balance();
begin

    writeln;
    writeln('Your Balance is : ',Balance,'$');
    writeln;

end;

procedure Withdraw();
var amount:integer;
begin

    writeln;
    write('Enter Amount to Withdraw >> ');
    readln(amount);
    
    if(amount <= Balance) then
    begin
        Balance := Balance - amount;
        writeln('Withdraw Complited Successfuly !!!');
        writeln;
        writeln('Your Balance Now is : ',Balance,'$');
    end
    else
    begin
        writeln('Withdraw Failed');
        writeln('Your Blance ',Balance,' is Less than the amount ',amount,' that you want to withdraw');
    end;
    
    writeln;

end;

procedure Deposit();
var amount:integer;
begin
    
    writeln;
    write('Enter Amount to Withdraw >> ');
    readln(amount);   
    
    Balance := Balance + amount;
    writeln('Deposit Complited Successfuly !!!');
    writeln;
    writeln('Your Balance Now is : ',Balance,'$');


    writeln;
end;

procedure Back_To_Menu();
begin
    writeln('Press [Enter] to back to Main Menu');
    readln;
end;

procedure Performe_Choice(choice : integer);
begin

    if(choice = 1) then 
    begin
        Show_Balance();
        Back_To_Menu();
    end;

    if(choice = 2) then 
    begin
        Withdraw();
        Back_To_Menu();
    end;

    if(choice = 3) then 
    begin
        Deposit();
        Back_To_Menu();
    end;

    if(choice = 4) then 
    begin
        Running := false; // this will exit the program
    end;

end;

procedure set_info();
begin

    Balance := 10000;
    PinCode := '1234';
    Running := true;

end;

procedure Closing();
begin
    
    writeln;
    
    writeln('=======================================================');
    writeln('       Thank you for using our ATM system');
    writeln('=======================================================');

    writeln;

end;

procedure Login();
var Try_PinCode : string;
begin

    writeln;
    writeln;

    write('Enter Your PinCode >> ');
    readln(Try_PinCode);
    
    while(Try_PinCode <> PinCode) do
    begin
        writeln('Wrong Pincode');
        write('Enter Your PinCode >> ');
        readln(Try_PinCode);
    end;
    
    // If you are here , so you enter the PinCode correctly

end;

begin

    set_info();
    
    Login();
    
    while(Running) do
    begin
        
        Show_Menu();
        choice := Read_Choice();
        Performe_Choice(choice);
    
    end;
    
    Closing();    

end.