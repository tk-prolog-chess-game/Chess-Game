setup_board(B) :-
    B = [piece(b,rook,1,1),piece(b,knight,2,1),piece(b,bishop,3,1),piece(b,queen,4,1),piece(b,king,5,1),piece(b,bishop,6,1),piece(b,knight,7,1),piece(b,rook,8,1),
piece(b,pawn,1,2),piece(b,pawn,2,2),piece(b,pawn,3,2),piece(b,pawn,4,2),piece(b,pawn,5,2),piece(b,pawn,6,2),piece(b,pawn,7,2),piece(b,pawn,8,2),
piece("-","-",1,3),piece("-","-",2,3),piece("-","-",3,3),piece("-","-",4,3),piece("-","-",5,3),piece("-","-",6,3),piece("-","-",7,3),piece("-","-",8,3),
piece("-","-",1,4),piece("-","-",2,4),piece("-","-",3,4),piece("-","-",4,4),piece("-","-",5,4),piece("-","-",6,4),piece("-","-",7,4),piece("-","-",8,4),
piece("-","-",1,5),piece("-","-",2,5),piece("-","-",3,5),piece("-","-",4,5),piece("-","-",5,5),piece("-","-",6,5),piece("-","-",7,5),piece("-","-",8,5),
piece("-","-",1,6),piece("-","-",2,6),piece("-","-",3,6),piece("-","-",4,6),piece("-","-",5,6),piece("-","-",6,6),piece("-","-",7,6),piece("-","-",8,6),
piece(w,pawn,1,7),piece(w,pawn,2,7),piece(w,pawn,3,7),piece(w,pawn,4,7),piece(w,pawn,5,7),piece(w,pawn,6,7),piece(w,pawn,7,7),piece(w,pawn,8,7),
piece(w,rook,1,8),piece(w,knight,2,8),piece(w,bishop,3,8),piece(w,queen,4,8),piece(w,king,5,8),piece(w,bishop,6,8),piece(w,knight,7,8),piece(w,rook,8,8)].
 
instructions :-
    write("Welcome to Programming Logic Project"),
    write("\nCHESS GAME"),
    write("\nWrite 'start' to play the game or 'exit' to exit the game : \n"),
    read(Instruction),
    process(Instruction).
process(exit) :- !.
process(start) :-
    begin.

% place piece in board predicate
place_piece(piece(w,pawn,_,_)) :-
    write("["),    
    write('\u265F'),
    write(' '),
    write("]").
place_piece(piece(w,rook,_,_)) :-
    write("["),
    write('\u265C'),
    write(' '),
    write("]").
place_piece(piece(w,knight,_,_)) :-
    write("["),
    write('\u265E'),
    write(' '),
    write("]").
place_piece(piece(w,bishop,_,_)) :-
    write("["),
    write('\u265D'),
    write(' '),
    write("]").
place_piece(piece(w,queen,_,_)) :-
    write("["),
    write('\u265B'),
    write(' '),
    write("]").
place_piece(piece(w,king,_,_)) :-
    write("["),
    write('\u265A'),
    write(' '),
    write("]").

place_piece(piece(b,pawn,_,_)) :-
    write("["),
    write('\u2659'),
    write(' '),
    write("]").
place_piece(piece(b,rook,_,_)) :-
    write("["),
    write('\u2656'),
    write(' '),
    write("]").
place_piece(piece(b,knight,_,_)) :-
    write("["),
    write('\u2658'),
    write(' '),
    write("]").
place_piece(piece(b,bishop,_,_)) :-
    write("["),
    write('\u2657'),
    write(' '),
    write("]").
place_piece(piece(b,queen,_,_)) :-
    write("["),
    write('\u2655'),
    write(' '),
    write("]").
place_piece(piece(b,king,_,_)) :-
    write("["),
    write('\u2654'),
    write(' '),
    write("]").

place_piece(piece("-",_,_,_)) :-
    write("[--]").
% end of place piece

% Writes the Pieces on the Board recursive calls till all pieces are written 
writeboard([piece(C,Type,1,Y)|T]) :-
    write("\n"),
    write(Y),
    write("  "),
    place_piece(piece(C,Type,1,Y)),
    writeboard(T).
  
writeboard([X|T]) :-
    place_piece(X),
    writeboard(T).
    
    
% writeBoard([piece(C,T,X,Y)]), C for color, T for Type , X for X coord Y for Y coord 
writeboard([piece(C,T,X,Y)]):-
    write("\n    a   b   c   d   e   f   g   h").

test:- setup_board(B),writeboard(B), !.

% process(start) :-
%     write(B),
%     write("White first"),
%     play().

% play().

% return true if  the cooresponding letter/ character exist 
letter(bishop, 'b').
letter(king,   'k').
letter(knight, 'h').
letter(pawn,   'p').
letter(queen,  'q').
letter(rook,   'r').
letter("-", "_").

% fixes Input given 
fixInput(X,Y,NextX,NextY):-
    enterMove(CX,CY,NX,NY),
    char_code(CX,CX1),
    char_code(NX,NX1),
    X is CX1-96,
    NextX is NX1-96,
    atom_number(CY,Y),
    atom_number(NY,NextY).

enterMove(X,Y,NextX,NextY):-
    repeat,
    write("\nEnter Player Location and move in form 'a1h8.' or enter 'exit.' to end the game \n"),   % will make prolog try till the answer is in the right form
    read(Input),
    string_lower(Input,Processed),
    write(Processed),
    sub_string(Processed,0,1,3,XUnprocessed),
    sub_string(Processed,1,1,2,YUnprocessed),
    sub_string(Processed,2,1,1,NextXUnprocessed),
    sub_string(Processed,3,1,0,NextYUnprocessed),
    process_input(XUnprocessed,YUnprocessed,NextXUnprocessed,NextYUnprocessed,X,Y,NextX,NextY).

% p_input (X,Y,X1,Y1,CX,CY,NX,NY) parsing input given and returns true if either quit or correct format is enterted    
process_input(XUnprocessed,YUnprocessed,NextXUnprocessed,NextYUnprocessed,X,Y,NextX,NextY):-
    string_chars(XUnprocessed,[X]),
    string_chars(YUnprocessed,[Y]),
    string_chars(NextXUnprocessed,[NextX]),
    string_chars(NextYUnprocessed,[NextY]),
    atom_number(Y,Y1),
    atom_number(NextY,Y2),
    withinBounds(X,Y1,NextX,Y2).

process_input(XUnprocessed,YUnprocessed,NextXUnprocessed,NextYUnprocessed,X,Y,NextX,NextY):-
    string_chars(XUnprocessed,[X]),
    string_chars(YUnprocessed,[Y]),
    string_chars(NextXUnprocessed,[NextX]),
    string_chars(NextYUnprocessed,[NextY]),
    X = e,
    Y = x,
    NextX = i,
    NextY = t,
    halt.

withinBounds(X,Y,NextX,NextY):-
    char_code(X,VX),
    char_code(NextX,VnextX),
    char_code('h',Max),
    char_code('a',Min),
    VX < Max+1,
    VX > Min-1,
    VnextX < Max+1,
    VnextX > Min -1,
    Y < 9,
    Y > -1,
    NextY < 9,
    NextY > -1.

playGame(w,Board):-
    \+member(piece(w,king,_,_),Board),
    write("\nBlACK WINS!"),
    write("\n o{^.^}o").
playGame(b,Board):-
    \+member(piece(b,king,_,_),Board),
    write("\nWHITE WINS!"),
    write("\n o{^.^}o").
playGame(w,Board):-
    writeboard(Board),
    write("\nWHITE TURN"),
    repeat,
    fixInput(X,Y,X1,Y1),
    Z is (X-1)+8*(Y-1),
    nth0(Z,Board,piece(w,Piece,X,Y)),
    %piece_helper(piece(w,Piece,X,Y),X1,Y1,Board),
    movePiece(Board,piece(w,Piece,X,Y),X1,Y1,Result),
    playGame(b,Result).
playGame(b,Board):-
    writeboard(Board),
    write("\nBLACK TURN"),
    repeat,
    fixInput(X,Y,X1,Y1),
    Z is (X-1)+8*(Y-1),
    nth0(Z,Board,piece(b,Piece,X,Y)),
    %piece_helper(piece(b,Piece,X,Y),X1,Y1,Board),
    movePiece(Board,piece(b,Piece,X,Y),X1,Y1,Result),
    playGame(w,Result).

start:- instructions.
begin:- setup_board(Board),playGame(w,Board).

% movePiece(Board,piece(X,Piece,X,Y),X1,Y1,Result) return true if we are able to move the piece to correct location on the Board based on X1 Y1 coord 
movePiece(Board, piece(C,Piece,X,Y), X1,Y1,Result) :-
    Z is (X-1)+8*(Y-1),
    replace(Z,piece("-","-",X,Y),Board,Middle),
    Z2 is (X1-1)+8*(Y1-1),
    replace(Z2,piece(C,Piece,X1,Y1),Middle,Result).

% replaces the Elem in the list based on the Index    
replace(_, _, [], []).
replace(0,R,[H|T],[R|T]).
replace(Index,R,[H1|T1],[H1|T2]) :-
    NextIndex is Index-1,
    replace(NextIndex,R,T1,T2).