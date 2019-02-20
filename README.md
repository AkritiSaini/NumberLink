# NumberLink
The Numberlink puzzle requires to connect number pairs on a grid without crossing paths. Paths have to be continuous and can only move horizontally or vertically, not diagonally. The successful result has to have touched on each cell in the grid with some path (i.e. no unused cells).

Pre Work: Install SWI-Prolog in your system. Online tutorials have been provided how to install and execute a simple prolog program.
How to Run numberLinkSolution.pl:
Open SWI-Prolog console.
    Type & press Enter: [numberLinkSolution]. 
    Type & Press Enter: main.
    Type & Press Enter: (6,5, (1:(4,1),(6,3)), (2:(5,1),(5,5)), (3:(1,1),(2,2)), (4:(1,2),(3,1)), (5:(2,3),(2,5))).
    It will display the path of the coordinates matching them under 6X6 size board.
    
Algorithm: 
Read Input from the user
Break down the input into fetching requirements and specifications from it. (Size of the Board/Matrix, and the numbers and their coordinates)
   Create Board/Matrix w.r.t the size provided in the input. 
    Board is the Quadratic Board of lists. Basically, it’s the List consisting Lists, as displayed below.                 

  M = [[,_,_,_,],

         [,_,_,_,_],

         [,_,_,_,_],

         [_,_,_,_,_],

         [_,_,_,_,_]].

      Fill the Board/Matrix with the Coordinates specified inside the input. Following is the pseudo code 
      for the rule for filling the Board.
      Coordinates have a format of (N: (StartColumn, StartRow), (EndColumn, EndRow))

      enter_number_in_matrix(Matrix,Coordinates)  
                Check if number already exists in the same coordinate through Prolog inbuilt Function “nth1”
                Enter number in the coordinates (Start Row, Start Column) & (End Row, End Column)     

      Coordinates consists of the input specification: (1: (3,6), (5,3)), (2: (5,2), (1,7)),  

       (3: (2,2), (4,3)), (4: (4,1), (5,7)), (5: (6,2), (4,4)).

      Cut Operator Used: With the cut operator, which basically states "if we got up to here, don't 
      backtrack." To stop unnecessary backtracking once the boards filled correctly.

      Find the path between two coordinates having same number in it: 
                   path_linking_two_coordinates(Matrix,Coordinates)
                                                               link_between_coordinates(Matrix,Cell(StartColumn, StartRow),   

                                                          Cell(EndColumn, EndRow)))
                 Find a path between Start and End with all the cells on the path having the same number. 
                 Two scenarios are possible: 
                                     a. Start and End Coordinates as adjacent to each other:
                       First call to find the adjacent cell Start and End. 
                                     b. Finding the path between coordinates which are not adjacent to each other.
                        In this case scenario, checking each adjacent coordinate of start point if its visited or not 
                        Recursive loop to the rule, checking for each adjacent coordinate and then their adjacent 
                        coordinate and then reaching to end coordinate finding the path in this entire sequence
                        Also, adding each adjacent angle to the visited list every time a new adjacent coordinate is
                        tracked in order to stop other coordinate to track the path consisting that coordinate. 
Finally, when the entire, paths have been found then traversed for printing the result.
