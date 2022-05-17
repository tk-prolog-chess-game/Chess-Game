:- [board].
:- [pieces].
:- debug.

% Main program
instructions :-
    write("Welcome to Programming Logic Project"),
    write("\nCHESS GAME"),
    write("\nWrite 'start' to play the game or 'exit' to exit the game : \n"),
    read(Instruction),
    process(Instruction).
process(exit) :- !.
process(start) :-
    begin.

start:- instructions.
begin:- setup_board(Board),playGame(w,Board).

playGame(w,Board):-
    \+member(piece(w,king,_,_),Board),
    %\+legal_move_king(piece(w, king, _, _), Board, _,_);
    writeboard(Board),
    write("\nBlACK WINS!").

%playGame(w,Board):-
    %member(piece(w,king,X1,Y1),Board),
    %piece_helper(piece(w,_,_,_),X1,Y1,Board),
    %writeboard(Board),
    %write("\nBlACK Check!").

playGame(b,Board):-
    \+member(piece(b,king,_,_),Board),
    %\+legal_move_king(piece(w, king, _, _), Board, _,_);
    writeboard(Board),
    write("\nWHITE WINS!").
playGame(w,Board):-
    writeboard(Board),
    write("\nWHITE TURN"),
    repeat,
    fixInput(X,Y,X1,Y1),
    get_position(Z, X, Y),
    nth0(Z,Board,piece(w,Piece,X,Y)),
    piece_helper(piece(w,Piece,X,Y),X1,Y1,Board),
    movePiece(Board,piece(w,Piece,X,Y),X1,Y1,Result),
    playGame(b,Result).
playGame(b,Board):-
    writeboard(Board),
    write("\nBLACK TURN"),
    repeat,
    fixInput(X,Y,X1,Y1),
    get_position(Z, X, Y),
    nth0(Z,Board,piece(b,Piece,X,Y)),
    piece_helper(piece(b,Piece,X,Y),X1,Y1,Board),
    movePiece(Board,piece(b,Piece,X,Y),X1,Y1,Result),
    playGame(w,Result).
%End of main program

movePiece(Board, piece(C,Piece,X,Y), X1,Y1,Result) :-
    get_position(Z, X, Y),
    replace(Z,piece("-","-",X,Y),Board,Middle),
    get_position(Z1, X1, Y1),
    replace(Z1,piece(C,Piece,X1,Y1),Middle,Res),
    pawn_promotion(Res,piece(C,Piece,X1,Y1), Result).

pawn_promotion(Board, piece(w,pawn,X,Y), Result) :-
    Y == 8 -> (
        write("\nPawn Promotion!"),
        write("\n(queen,rook,bishop,knight)"),
        write("\nPlease write piece name in lowercase"),
        read(Piece),
        pawn_promotion_rule(Piece,Board,piece(w,pawn,X,Y),Result, X, Y, w)
        );
        (Result = Board).

pawn_promotion(Board, piece(b,pawn,X,Y), Result) :-
    Y == 1 -> (
        write("\nPawn Promotion!"),
        write("\n(queen,rook,bishop,knight)"),
        write("\nPlease write piece name in lowercase"),
        read(Piece),
        pawn_promotion_rule(Piece,Board,piece(b,pawn,X,Y),Result, X, Y, b)
        );
        (Result = Board).

pawn_promotion_rule(pawn, Board, _, Result, X, Y, Color) :-
    !,
    Color == b -> (
    pawn_promotion(Board, piece(b,pawn,X,Y), Result))
    ;(pawn_promotion(Board, piece(w,pawn,X,Y), Result)).

pawn_promotion_rule(king, Board, _, Result, X, Y, Color) :-
    !,
    Color == b -> (
    pawn_promotion(Board, piece(b,pawn,X,Y), Result))
    ;(pawn_promotion(Board, piece(w,pawn,X,Y), Result)).

pawn_promotion_rule(Piece, Board, _, Result, X, Y, Color) :-
    Res = piece(Color,Piece,X,Y),
    get_position(Z, X, Y),
    replace(Z, Res, Board, Result).

% replaces the Elem in the list based on the Index    
replace(_, _, [], []).
replace(0,R,[_|T],[R|T]).
replace(Index,R,[H1|T1],[H1|T2]) :-
    NextIndex is Index-1,
    replace(NextIndex,R,T1,T2).

%Write board region
writeboard([piece(C,Type,1,Y)|T]) :-
    write("\n"),
    write(Y),
    write("  "),
    place_piece(piece(C,Type,1,Y)),
    writeboard(T).
  
writeboard([X|T]) :-
    place_piece(X),
    writeboard(T).
    
writeboard([piece(_,_,_,_)]):-
    write("\n    a   b   c   d   e   f   g   h").
%end of write board

%Input
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
    write("\nEnter move location, example : 'a7a6' a7 is the position of piece, a6 is the location to move, or 'exit' to exit the game \n"),   % will make prolog try till the answer is in the right form
    write("*Must be in lowercase\n"),
    read(Input),
    string_lower(Input, Processed),
    write(Processed),

    % bagi input menjadi 4 bagian
    sub_string(Processed,0,1,3,Xn),
    sub_string(Processed,1,1,2,Yn),
    sub_string(Processed,2,1,1,NextXn),
    sub_string(Processed,3,1,0,NextYn),
    process_input(Xn,Yn,NextXn,NextYn,X,Y,NextX,NextY).

process_input(Xn,Yn,NextXn,NextYn,X,Y,NextX,NextY):-
    string_to_chars_helper(Xn,Yn,NextXn,NextYn,X,Y,NextX,NextY),
    atom_number(Y,Y1),
    atom_number(NextY,Y2),
    rangePosition(X,Y1,NextX,Y2).

%Exit from the game
process_input(Xn,Yn,NextXn,NextYn,X,Y,NextX,NextY):-
    string_to_chars_helper(Xn,Yn,NextXn,NextYn,X,Y,NextX,NextY),
    X = e,
    Y = x,
    NextX = i,
    NextY = t,
    halt.

string_to_chars_helper(Xn,Yn,NextXn,NextYn,X,Y,NextX,NextY) :-
    string_chars(Xn,[X]),
    string_chars(Yn,[Y]),
    string_chars(NextXn,[NextX]),
    string_chars(NextYn,[NextY]).

rangePosition(X,Y,NextX,NextY):-
    char_code(X,ValueX),
    char_code(NextX,VnextX),
    char_code('h',Max),
    char_code('a',Min),
    ValueX < Max+1,
    ValueX > Min-1,
    VnextX < Max+1,
    VnextX > Min -1,
    Y < 9,
    Y > -1,
    NextY < 9,
    NextY > -1.

get_position(Z, X, Y):-
    Z is (X-1)+(8*(8-Y)).
% End of input