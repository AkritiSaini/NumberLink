%%NumberLink Puzzle
%%Author: Akriti Saini

%%  main method to execute the problem in chunks
%% solution_numberlink have argument IN as the input read though the console.
main :-
    %%open('inputfile.txt', read, Str),
    %%read_file(Str,Lines),
    %%close(Str).
    read(In), nl,
    solution_numberlink(In).

%% Execute the problem in chunks
%% Solving problem,calling to display output in the following rule
solution_numberlink((MatrixSize,Pathfinders,Coordinates)) :-
    numberLink_solve((MatrixSize,Pathfinders,Coordinates), Matrix), !,
    format("(~w, ~w,~n", [MatrixSize, Pathfinders]),
    print_method_final_output(Matrix, 1),
    forall(between(2,Pathfinders,X), (format(",~n"), print_method_final_output(Matrix, X))),
    format(")~n").

%% solve the puzzle first creating a board, filling the matrix/board and finding path
numberLink_solve(
    (MatrixSize,_,Coordinates),
    Matrix
) :-
    matrix_of(MatrixSize, Matrix),
    plot_into_matrix(Matrix, Coordinates), !,
    track_path(Matrix, Coordinates).

%% creating the Matrix/Board as a list of lists w.r.t the size inputted by the user
matrix_of(
    MatrixSize,
    Matrix
) :-
    length(Matrix,MatrixSize),
    create_matrix(Matrix, MatrixSize).

%empty matrix of lists
create_matrix( 
    [],
    _
).
create_matrix(
    [Row|RowN],
    Length
) :-
    length(Row, Length),
    create_matrix(RowN, Length).

%% plotting the number into the empty lists as the numbers provided into the 
%% input w.r.t the coordinates
plot_into_matrix(
    Matrix,
    (C)
) :-
    plot_cells(Matrix, C).
plot_into_matrix(
    Matrix,
    (C,CN)
) :-
    plot_cells(Matrix, C), plot_into_matrix(Matrix, CN).


%% Storing the numbers into their coordinates
plot_cells(
    Matrix,
    (PF: (StartCol, StartRow), (EndCol, EndRow))
) :-
    plot_cell_of_matrix(Matrix, matrixCell(StartRow,StartCol), PF),
    plot_cell_of_matrix(Matrix, matrixCell(EndRow,EndCol), PF).


%% Checking whether a number is in the list or not
plot_cell_of_matrix(
    Matrix,
    matrixCell(Row, Column),
    PFNum
) :-
    nth1(Row, Matrix, R),
    nth1(Column, R, PFNum).


%% Finding the path between two coordinates
track_path(
    Matrix,
    (Coordinates)
) :-
    track_path_between_coordinates(Matrix, Coordinates).
track_path(
    Matrix,
    (Coordinates,CoordinatesC)
) :-
    track_path_between_coordinates(Matrix, Coordinates), track_path(Matrix, CoordinatesC).



%% tracking down path between coordinates with the same number
track_path_between_coordinates(
    Matrix,
    (_: (StartCol, StartRow), (EndCol, EndRow))
) :-
    path_between(Matrix, matrixCell(StartRow,StartCol), matrixCell(EndRow,EndCol)).


%% find path between two coordinate start and end having same number
%% algo used: check the adjcent cells first if they are beighbours or not 
%% next find teh adjacent cell to track down the path one by one to find the 
%% path between two coordinates
path_between(
    Matrix,
    StartCoordinate,
    EndCoordinate,
    CoordinatesVisited
) :-
    % Start and End are neighbours, check that End isnt in the path
    % yet (circular paths are no fun) and that the cells have the same
    % number.
    (
        adjacentCell(StartCoordinate, EndCoordinate),
        \+ member(EndCoordinate, CoordinatesVisited),
        plot_cell_of_matrix(Matrix, StartCoordinate, Y),
        plot_cell_of_matrix(Matrix, EndCoordinate, Y)
    ); % or

    % Find a neighbour X of start which hasnt been visited yet
    % and has the same number as start.  Then search from there to
    % End.
    (
        adjacentCell(StartCoordinate, X),
        \+ member(X, CoordinatesVisited),
        plot_cell_of_matrix(Matrix, StartCoordinate, Y),
        plot_cell_of_matrix(Matrix, EndCoordinate, Y),
        path_between(Matrix, X, EndCoordinate, [X|CoordinatesVisited])
    ).


path_between(
    Matrix,
    StartCoordinate,
    EndCoordinate
) :-
	%adding the adjecent cell already visited into the Visited List
    path_between(Matrix,StartCoordinate,EndCoordinate,[StartCoordinate]). 

%%finding all the neighbours of the cell of the matrix or Coordinates
adjacentCell(
    matrixCell(Row, Column),
    matrixCell(NeighbourRow, NeighbourColumn)
) :-
    % same row but adjacent column
    (Row = NeighbourRow, distance_between_coordinates(NeighbourColumn, Column)); % or
    % same column but adjacent row
    (Column = NeighbourColumn, distance_between_coordinates(NeighbourRow, Row)).

%% calculate the difference between to Coordinates to know the distance between them if they are neighbours or not
distance_between_coordinates(
    Var1,
    Var2
) :-
    Var1 is Var2 + 1; % OR
    Var1 is Var2 - 1.

%% predicate displying the output
print_method_final_output(Matrix, X) :-
    bagof(Y, (plot_cell_of_matrix(Matrix, Y, X)), MatrixCells),
    format("(~w: ", [X]), print_cells(MatrixCells),
    format(")").

print_cells([matrixCell(Row,Column)]) :-
    format("(~w,~w)", [Column,Row]).
print_cells([matrixCell(Row,Column)|Rest]) :-
    format("(~w,~w), ", [Column,Row]),
    print_cells(Rest).

