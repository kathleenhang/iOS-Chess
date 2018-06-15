//
//  BoardIndex.swift
//  MobileChess
//
//  Created by Kathleen on 6/12/18.
//  Copyright © 2018 Team Cowdog. All rights reserved.
//



// not using class because we arent interested in reference
struct BoardIndex: Equatable {
    
    var row: Int
    var col: Int
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    static func == (lhs: BoardIndex, rhs: BoardIndex) -> Bool {
        return (lhs.row == rhs.row && lhs.col == rhs.col)
    }
    
    
    
    
    
    
    
    
    
}
