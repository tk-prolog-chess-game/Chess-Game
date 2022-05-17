:- [pieces].

check_chess(piece(Color, king, X1, Y1), Board):-
    member(piece(Color,king,X1,Y1),Board),
    (
        Color == w,
        piece_helper(piece(b,_,_,_),X1,Y1,Board)
        
    );
    (
        Color == b,
        piece_helper(piece(w,_,_,_),X1,Y1,Board)
    )
    .