//
//  ChessGame.swift
//  MobileChess
//
//  Created by Kathleen on 6/12/18.
//  Copyright © 2018 Team Cowdog. All rights reserved.
//


// chess game instance will create new instance of chess board which will place all chess pieces on the screen
import UIKit

class ChessGame: NSObject {
    var theChessBoard: ChessBoard!
    
    
    
    // creates chessboard for this chess game
    init(viewController: ViewController) {
        
        theChessBoard = ChessBoard.init(viewController: viewController)
        
    }
    
    func isMoveValid(piece: UIChessPiece, fromIndex sourceIndex: BoardIndex, toIndex destIndex: BoardIndex) -> Bool{
        return true
    }
}
