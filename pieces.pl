abs2(X,Y) :- 
    X < 0 -> Y is -X;
    Y = X.

between(N1, N2, X) :-
    N1 =< N2, X = N1.
between(N1, N2, X) :-
    N1 < N2,
    N3 is N1+1,
    between(N3, N2, X).

r_between(N1, N2, X) :-
    N1 >= N2, X = N1.
r_between(N1, N2, X) :-
    N1 > N2,
    N3 is N1-1,
    r_between(N3, N2, X).

flat_stepper(X,Y,X1,Y1,[H|T],X3,Y3) :-
    (
        (
            X =:= X1,
            Y =\= Y1
        );
        (
            X =\= X1,
            Y =:= Y1
        );
        (
            X =:= X1,
            Y =:= Y1
        )
    ),
    X3 = X,
    Y3 = Y.

flat_stepper(X,Y,X1,Y1,[H|T],X3,Y3) :-
    (
        (
            X =\= X1,
            Y =:= Y1,
            H =:= 1,
            T =:= 0
        );
        (
            X =:= X1,
            Y =\= Y1,
            H =:= 0,
            T =:= 1
        )
    ),
    X4 is X + H,
    Y4 is Y + T,
    flat_stepper(X4,Y4,X1,Y1,[H|T],X3,Y3).

side_stepper(X,Y,X1,Y1,[H|T],X3,Y3) :-
    X =\= X1,
    Y =\= Y1,
    X3 = X,
    Y3 = Y.
side_stepper(X,Y,X1,Y1,[H|T],X3,Y3) :-
    X =:= X1,
    Y =:= Y1,
    X3 = X,
    Y3 = Y.
side_stepper(X,Y,X1,Y1,[H|T],X3,Y3) :- %sideways stepper.
    X =\= X1,
    Y =\= Y1,
    X4 is X + H,
    Y4 is Y + T,
    side_stepper(X4,Y4,X1,Y1,[H|T],X3,Y3).

empty_spot(X, Y, Board) :-
    between(1, 8, X),
    between(1, 8, Y),
    member(piece("-", "-", X, Y), Board),
    !.

legal_move_bishop(piece(Color, bishop, X, Y), Board, X1,Y1) :-
    X1 > 0, X1 < 9,
    Y1 > 0, Y1 < 9,
    abs2(X1-X, X2),
    abs2(Y1-Y, Y2),
    X2 =:= Y2,
    (
        (
            (X < X1, Y < Y1) -> side_stepper(X,Y,X1,Y1,[1|1],X3,Y3)
        );(
            (X > X1, Y < Y1) -> side_stepper(X,Y,X1,Y1,[-1|1],X3,Y3)
        );(
            (X < X1, Y > Y1) -> side_stepper(X,Y,X1,Y1,[1|-1],X3,Y3)
        );(
            (X > X1, Y > Y1) -> side_stepper(X,Y,X1,Y1,[-1|-1],X3,Y3)
        )
    ),
    empty_spot(X3, Y3, Board),
    !.

legal_move_rook(piece(Color, rook, X, Y), Board, X1,Y1) :-
    X1 > 0, X1 < 9,
    Y1 > 0, Y1 < 9,
    abs2(X1-X, X2),
    abs2(Y1-Y, Y2),
    (
        (
            X2 =:= 0,
            Y2 =\= 0,
            (
                (
                    (Y < Y1) -> flat_stepper(X,Y,X1,Y1,[0|1],X3,Y3)
                );(
                    (Y > Y1) -> flat_stepper(X,Y,X1,Y1,[0|-1],X3,Y3)
                )
            )
        );
        (
            X2 =\= 0,
            Y2 =:= 0,
            (
                (
                    (X < X1) -> flat_stepper(X,Y,X1,Y1,[1|0],X3,Y3)
                );(
                    (X > X1) -> flat_stepper(X,Y,X1,Y1,[-1|0],X3,Y3)
                )
            )
        )
    ),
    empty_spot(X3, Y3, Board),
    !.

legal_move_queen(piece(Color, queen, X, Y), Board, X1,Y1) :-
    X1 > 0, X1 < 9,
    Y1 > 0, Y1 < 9,
    abs2(X1-X, X2),
    abs2(Y1-Y, Y2),
    (
        (
            X2 =:= Y2,
            (
                (
                    (X < X1, Y < Y1) -> side_stepper(X,Y,X1,Y1,[1|1],X3,Y3)
                );(
                    (X > X1, Y < Y1) -> side_stepper(X,Y,X1,Y1,[-1|1],X3,Y3)
                );(
                    (X < X1, Y > Y1) -> side_stepper(X,Y,X1,Y1,[1|-1],X3,Y3)
                );(
                    (X > X1, Y > Y1) -> side_stepper(X,Y,X1,Y1,[-1|-1],X3,Y3)
                )
            )
        );
        (
            X2 =:= 0,
            Y2 =\= 0,
            (
                (
                    (Y < Y1) -> flat_stepper(X,Y,X1,Y1,[0|1],X3,Y3)
                );(
                    (Y > Y1) -> flat_stepper(X,Y,X1,Y1,[0|-1],X3,Y3)
                )
            )
        );
        (
            X2 =\= 0,
            Y2 =:= 0,
            (
                (
                    (X < X1) -> flat_stepper(X,Y,X1,Y1,[1|0],X3,Y3)
                );(
                    (X > X1) -> flat_stepper(X,Y,X1,Y1,[-1|0],X3,Y3)
                )
            )
        )
    ),
    empty_spot(X3, Y3, Board),
    !.

legal_move_king(piece(Color, king, X, Y), Board, X1,Y1) :-
    X1 > 0, X1 < 9,
    Y1 > 0, Y1 < 9,
    abs2(X1-X, X2),
    abs2(Y1-Y, Y2),
    (
        (
            X2 =:= 1,
            Y2 =:= 1,
            (
                (
                    (X < X1, Y < Y1) -> side_stepper(X,Y,X1,Y1,[1|1],X3,Y3)
                );(
                    (X > X1, Y < Y1) -> side_stepper(X,Y,X1,Y1,[-1|1],X3,Y3)
                );(
                    (X < X1, Y > Y1) -> side_stepper(X,Y,X1,Y1,[1|-1],X3,Y3)
                );(
                    (X > X1, Y > Y1) -> side_stepper(X,Y,X1,Y1,[-1|-1],X3,Y3)
                )
            )
        );
        (
            X2 =:= 0,
            Y2 =:= 1,
            (
                (
                    (Y < Y1) -> flat_stepper(X,Y,X1,Y1,[0|1],X3,Y3)
                );(
                    (Y > Y1) -> flat_stepper(X,Y,X1,Y1,[0|-1],X3,Y3)
                )
            )
        );
        (
            X2 =:= 1,
            Y2 =:= 0,
            (
                (
                    (X < X1) -> flat_stepper(X,Y,X1,Y1,[1|0],X3,Y3)
                );(
                    (X > X1) -> flat_stepper(X,Y,X1,Y1,[-1|0],X3,Y3)
                )
            )
        )
    ),
    empty_spot(X3, Y3, Board),
    !.