import UIKit
import PlaygroundSupport

// Rotten Oranges
//In a given grid, each cell can have one of three values:
//
//the value 0 representing an empty cell;
//the value 1 representing a fresh orange;
//the value 2 representing a rotten orange.
//Every minute, any fresh orange that is adjacent (4-directionally) to a rotten orange becomes rotten.
//
//Return the minimum number of minutes that must elapse until no cell has a fresh orange.  If this is impossible, return -1 instead.

//Example 1:

let oranges = UIImage(named: "oranges.png")

// Min 0    Min 1   Min 2   Min 3   Min 4 (End)
// R O O    R R O   R R R   R R R   R R R
// O O _    R O _   R R _   R R _   R R _
// _ O O    _ O O   _ O O   _ R O   _ R R

//Input: [[2,1,1],[1,1,0],[0,1,1]]
//Output: 4


var input = [[2,1,1],[1,1,0],[0,1,1]]

func orangesRotting(_ grid: [[Int]]) -> Int {
    let rows = grid.count, cols = grid[0].count
    guard rows != 0, cols != 0 else { return -1 }
    
    var fresh = 0 // Fresh orange count
    var rotten = [(Int, Int)]() // Array of Tuples that keeps track of indexes of rotten oranges
    var grid = grid // Mutable copy
    
    for row in 0..<rows {
        for col in 0..<cols {
            //If fresh found
            if grid[row][col] == 1 {
                fresh += 1
            }
            //Else if rotten found
            else if grid[row][col] == 2 {
                rotten.append((row, col))
            }
        }
    }
    
    // If we have no fresh fruit, we have nothing to rot. So we report that it'll take 0 minutes.
    if fresh == 0 { return 0 }
    
    var minutes = 0
    
    while rotten.count > 0, fresh > 0 {
        let count = rotten.count
        minutes += 1
        
        for _ in 0..<count {
            // Let's get the first rotten orange and it's coordinate as a tuple
            let (row, col) = rotten.removeFirst()
            
            // If fresh orange to our left
            if row-1 >= 0, grid[row-1][col] == 1 {
                rotten.append((row-1, col)) //Make it rotten and add it to our list
                grid[row-1][col] = 0    //Update the grid to be empty
                fresh -= 1  //decrement rotten count
            }
            if row+1 < rows, grid[row+1][col] == 1 {
                rotten.append((row+1, col))
                grid[row+1][col] = 0
                fresh -= 1
            }
            if col-1 >= 0, grid[row][col-1] == 1 {
                rotten.append((row, col-1))
                grid[row][col-1] = 0
                fresh -= 1
            }
            if col+1 < cols, grid[row][col+1] == 1 {
                rotten.append((row, col+1))
                grid[row][col+1] = 0
                fresh -= 1
            }
        }
    }
    
    return fresh == 0 ? minutes : -1
}

orangesRotting(input)
