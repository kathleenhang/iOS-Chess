//
//  Pawn.swift
//  MobileChess
//
//  Created by Kathleen on 6/12/18.
//  Copyright © 2018 Team Cowdog. All rights reserved.
//

import UIKit

class Pawn: UIChessPiece {
    var triesToAdvanceBy2: Bool = false
    
    
    // initializer automatically draws chess piece on screen and adds it to array of chess pieces
    init(frame: CGRect, color: UIColor, vc: ViewController) {
        super.init(frame: frame)
        
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
            self.text = "♟"
            
        }
        else{
            self.text = "♙"
        }
        
        self.isOpaque = false // draw pawn on top board
        self.textColor = color // color of chess piece symbol
        self.isUserInteractionEnabled = true // let user drag piece on screen
        self.textAlignment = .center // chess piece centered
        self.font = self.font.withSize(36)
        
        vc.chessPieces.append(self) // add this chess piece to array of chess pieces
        vc.view.addSubview(self) // add this label to screen at specified coords in init
        
        
       
        
        
    }
    
    
    func doesMoveSeemFine(fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool{
        
        // check advance by 2
        if source.col == dest.col{
            if(source.row == 1 && dest.row == 3 && color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) || (source.row == 6 && dest.row == 4 && color != #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)){
                triesToAdvanceBy2 = true
                return true
            }
        }
        
        triesToAdvanceBy2 = false
        
        // check advance by 1
        var moveForward = 0
        
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
            moveForward = 1
        }
        else{
            moveForward = -1
        }
        
       
        if dest.row == source.row + moveForward{
            if(dest.col == source.col - 1) || (dest.col == source.col) ||
                (dest.col == source.col + 1){
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
