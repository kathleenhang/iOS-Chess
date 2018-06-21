//
//  Bishop.swift
//  MobileChess
//
//  Created by Kathleen on 6/12/18.
//  Copyright © 2018 Team Cowdog. All rights reserved.
//

import UIKit

class Bishop: UIChessPiece {
    // initializer automatically draws chess piece on screen and adds it to array of chess pieces
    init(frame: CGRect, color: UIColor, vc: ViewController) {
        super.init(frame: frame)
        
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
            self.text = "♝"
            
        }
        else{
            self.text = "♗"
        }
        
        self.isOpaque = false // draw pawn on top board
        self.textColor = color // color of chess piece symbol
        self.isUserInteractionEnabled = true // let user drag drog piece on screen
        self.textAlignment = .center // chess piece centered
        self.font = self.font.withSize(36)
        
        vc.chessPieces.append(self) // add this chess piece to array of chess pieces
        vc.view.addSubview(self) // add this label to screen at specified coords in init
        
        
     
        
        
    }
    
    func doesMoveSeemFine(fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool{
        
        // difference of rows, difference of columns
        // pattern: absolute value is always the same
        
        //-1, -1
        // 1, 1
        // 1, -1
        //-1, 1
        
        //-2,-2
        // 2, 2
        // 2, -2
        //-2, 2
        
        if abs(dest.row - source.row) == abs(dest.col - source.col){
            return true
        }

        
        return false
        
    }
    
    // needed in order to instantiate the frame and pawn
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
