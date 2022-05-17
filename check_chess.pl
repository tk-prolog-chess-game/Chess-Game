:- [pieces].

check_chess(piece(Color, king, X1, Y1), Board):-
    
    (
        Color == w,
        member(piece(b,king,X1,Y1),Board),

        piece_helper(piece(Color,_,_,_),X1,Y1,Board)
        
    );
    (
        Color == b,
        member(piece(w,king,X1,Y1),Board),

        piece_helper(piece(Color,_,_,_),X1,Y1,Board)
    )
    .