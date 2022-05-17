:- [pieces].

check_chess(piece(Color, king, X1, Y1), Board):-
    
    (
        Color == w,
        member(piece(b,king,X1,Y1),Board),

        piece_iterate(w, X1, Y1, Board, Board)
        
    );
    (
        Color == b,
        member(piece(w,king,X1,Y1),Board),

        piece_iterate(b, X1, Y1, Board, Board)
    )
    .

piece_iterate(Color, X1, Y1, [H|T], Board) :-
    H \== piece(Color, king, X1, Y1),
    piece_helper(H, X1, Y1, Board),
    piece_iterate(Color, X1, Y1, T, Board).
    
% piece_iterate(Color, X1, Y1, [H|T], Board) :-
%     piece_iterate(Color, X1, Y1, T, Board).

piece_iterate(_, _, _, [], _) :- !.