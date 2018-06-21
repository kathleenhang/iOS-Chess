//
//  King.swift
//  MobileChess
//
//  Created by Kathleen on 6/12/18.
//  Copyright © 2018 Team Cowdog. All rights reserved.
//

import UIKit

class King: UIChessPiece {
    // initializer automatically draws chess piece on screen and adds it to array of chess pieces
    init(frame: CGRect, color: UIColor, vc: ViewController) {
        super.init(frame: frame)
        
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
            self.text = "♚"
            
        }
        else{
            self.text = "♔"
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
        
        let differenceInRows = abs(dest.row - source.row)
        let differenceInCols = abs(dest.col - source.col)
        
        if case 0...1 = differenceInRows{
            if case 0...1 = differenceInCols{
                return true
            }
        }
        
        return false
    }
    
    // needed in order to instantiate the frame and pawn
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
}
