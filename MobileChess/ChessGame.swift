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
    var isWhiteTurn = true
    
    
    // creates chessboard for this chess game
    init(viewController: ViewController) {
        
        theChessBoard = ChessBoard.init(viewController: viewController)
        
    }
    
    func move(piece chessPieceToMove: UIChessPiece, fromIndex sourceIndex: BoardIndex, toIndex destIndex: BoardIndex, toOrigin destOrigin: CGPoint){
        
        // get initial chess piece frame
        let initialChessPieceFrame = chessPieceToMove.frame
        
        // remove piece at destination
        let pieceToRemove = theChessBoard.board[destIndex.row][destIndex.col]
        theChessBoard.remove(piece: pieceToRemove)
        
        // place the chess piece at destination
        theChessBoard.place(chessPiece: chessPieceToMove, toIndex: destIndex, toOrigin: destOrigin)
        
        // put a Dummy piece in the vacant source tile
        theChessBoard.board[sourceIndex.row][sourceIndex.col] = Dummy(frame: initialChessPieceFrame)
        
    }
   
    
    func isMoveValid(piece: UIChessPiece, fromIndex sourceIndex: BoardIndex, toIndex destIndex: BoardIndex) -> Bool{
        
        
        
        guard isMoveOnBoard(forPieceFrom: sourceIndex, thatGoesTo: destIndex)
            else{
                print("MOVE IS NOT ON BOARD")
                return false
        }
        
        guard isTurnColor(sameAsPiece: piece) else {
            print("WRONG TURN")
            return false
        }
        
        
        return true
    }
    
    func nextTurn(){
        isWhiteTurn = !isWhiteTurn
    }
    
    
    func isTurnColor(sameAsPiece piece: UIChessPiece) -> Bool {
        if piece.color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
            if !isWhiteTurn{
                return true
                
            }
        }
        else{
            if isWhiteTurn{
                return true
            }
        }
        return false
    }
    
    
    
    func isMoveOnBoard(forPieceFrom sourceIndex: BoardIndex, thatGoesTo destIndex: BoardIndex) -> Bool {
        if case 0..<theChessBoard.ROWS = sourceIndex.row{
            if case 0..<theChessBoard.COLS = sourceIndex.col{
                if case 0..<theChessBoard.ROWS = destIndex.row{
                    if case 0..<theChessBoard.COLS = destIndex.col{
                        return true
                    }
                }
            }
        }
        return false
    }
}
