setup_board(B) :-
    B = [piece(b,rook,1,1),piece(b,knight,2,1),piece(b,bishop,3,1),piece(b,queen,4,1),piece(b,king,5,1),piece(b,bishop,6,1),piece(b,knight,7,1),piece(b,rook,8,1),
piece(b,pawn,1,2),piece(b,pawn,2,2),piece(b,pawn,3,2),piece(b,pawn,4,2),piece(b,pawn,5,2),piece(b,pawn,6,2),piece(b,pawn,7,2),piece(b,pawn,8,2),
piece("-","-",1,3),piece("-","-",2,3),piece("-","-",3,3),piece("-","-",4,3),piece("-","-",5,3),piece("-","-",6,3),piece("-","-",7,3),piece("-","-",8,3),
piece("-","-",1,4),piece("-","-",2,4),piece("-","-",3,4),piece("-","-",4,4),piece("-","-",5,4),piece("-","-",6,4),piece("-","-",7,4),piece("-","-",8,4),
piece("-","-",1,5),piece("-","-",2,5),piece("-","-",3,5),piece("-","-",4,5),piece("-","-",5,5),piece("-","-",6,5),piece("-","-",7,5),piece("-","-",8,5),
piece("-","-",1,6),piece("-","-",2,6),piece("-","-",3,6),piece("-","-",4,6),piece("-","-",5,6),piece("-","-",6,6),piece("-","-",7,6),piece("-","-",8,6),
piece(w,pawn,1,7),piece(w,pawn,2,7),piece(w,pawn,3,7),piece(w,pawn,4,7),piece(w,pawn,5,7),piece(w,pawn,6,7),piece(w,pawn,7,7),piece(w,pawn,8,7),
piece(w,rook,1,8),piece(w,knight,2,8),piece(w,bishop,3,8),piece(w,queen,4,8),piece(w,king,5,8),piece(w,bishop,6,8),piece(w,knight,7,8),piece(w,rook,8,8)].

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