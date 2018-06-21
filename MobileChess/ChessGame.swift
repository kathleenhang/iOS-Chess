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
   
    // is it the correct turn and is the move on the board
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
        
        
        return isNormalMoveValid(forPiece: piece, fromIndex: sourceIndex, toIndex: destIndex)
    }
    
    
    
    func isNormalMoveValid(forPiece piece: UIChessPiece, fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool{
        
        guard source != dest else {
            print("MOVING PIECE ON ITS CURRENT POSITION")
            return false
        }
        
        
        guard !isAttackingAlliedPiece(sourceChessPiece: piece, destIndex: dest) else {
            print("ATTACKING ALLIED PIECE")
            return false
        }
        
        
        switch piece {
        case is Pawn:
            return isMoveValid(forPawn: piece as! Pawn, fromIndex: source, toIndex: dest)
        case is Rook, is Bishop, is Queen:
            return isMoveValid(forRookOrBishopOrQueen: piece, fromIndex: source, toIndex: dest)
            // knight doesnt need 2 step check since it can jump over pieces
        case is Knight:
            if !(piece as! Knight).doesMoveSeemFine(fromIndex: source, toIndex: dest){
                return false
            }
            
        case is King:
            return isMoveValid(forKing: piece as! King, fromIndex: source, toIndex: dest)
        default:
            break
        }
 
        return true

    }
    
    
    
    
    
    func isMoveValid(forPawn pawn: Pawn, fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool{
        
        if !pawn.doesMoveSeemFine(fromIndex: source, toIndex: dest){
            return false
        }
        
        // no attack
        if source.col == dest.col{
            // advance by 2
            if pawn.triesToAdvanceBy2{
                var moveForward = 0
                
                if pawn.color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
                    moveForward = 1
                    
                }
                else{
                    moveForward = -1
                }
                
                
                if theChessBoard.board[dest.row][dest.col] is Dummy && theChessBoard.board[dest.row - moveForward][dest.col] is Dummy{
                    return true
                }
                
                
                
                
            }
                // advance by 1
            else{
                if theChessBoard.board[dest.row][dest.col] is Dummy{
                    return true
                }
            }
            
        }
        // attack some piece
        else{
            if !(theChessBoard.board[dest.row][dest.col] is Dummy){
                return true
            }
            
        }
        
        return false
    }
    
    
    func isMoveValid(forRookOrBishopOrQueen piece: UIChessPiece, fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool{
        
        switch piece {
        case is Rook:
            if !(piece as! Rook).doesMoveSeemFine(fromIndex: source, toIndex: dest){
                return false
            }
            
        case is Bishop:
            if !(piece as! Bishop).doesMoveSeemFine(fromIndex: source, toIndex: dest){
                return false
            }
            
        default:
            if !(piece as! Queen).doesMoveSeemFine(fromIndex: source, toIndex: dest){
                return false
            }
            
        }
        
        // source row/col to destination row/col
        // QUEEN OR BISHOP: from 1, 1 to 3, 3 (1,1 then 2,2 then 3,3)
        // QUEEN OR ROOK: from 1, 5 to 1, 2 (1,5 then 1,4 then 1,3 then 1,2)
        
        
        var increaseRow = 0
        
        if dest.row - source.row != 0{
            // -1, 0 , 1
            // increase row / decrease row / no increase in row
            // example: -5 / 5 gives you -1
            increaseRow = (dest.row - source.row) / abs(dest.row - source.row)
        }
        
        var increaseCol = 0
        
        if dest.col - source.col != 0{
            increaseCol = (dest.col - source.col) / abs(dest.col - source.col)
        }
        
        var nextRow = source.row + increaseRow
        var nextCol = source.col + increaseCol
        
        // if one of these conditions are true, then we will continue to loop continuously
        while nextRow != dest.row || nextCol != dest.col{
            if !(theChessBoard.board[nextRow][nextCol] is Dummy){
                return false
            }
            
            nextRow += increaseRow
            nextCol += increaseCol
        }
        
        
        
        
        
        
        
        
        
        
        return true
    }
    
    func isMoveValid(forKing king: King, fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool{
        
        if !king.doesMoveSeemFine(fromIndex: source, toIndex: dest){
            return false

        }
        
        
        if isOpponentKing(nearKing: king, thatGoesTo: dest){
            return false
        }

        return true
    }
    
    
    
    func isOpponentKing(nearKing movingKing: King, thatGoesTo destIndexOfMovingKing: BoardIndex) -> Bool{
        
        
        
        // find out which one is the opponent king
        var theOpponentKing: King
        
        if movingKing == theChessBoard.whiteKing{
            theOpponentKing = theChessBoard.blackKing
        }
        else{
            theOpponentKing = theChessBoard.whiteKing
        }
        
        // get index of opponent king
        var indexOfOpponentKing: BoardIndex!
        
        for row in 0..<theChessBoard.ROWS{
            for col in 0..<theChessBoard.COLS{
                // if condition is true then we have found the opponent king
                if let aKing = theChessBoard.board[row][col] as? King, aKing == theOpponentKing{
                    indexOfOpponentKing = BoardIndex(row: row, col: col)
                }
            }
        }
        
        // compute absolute difference between kings
        let differenceInRows = abs(indexOfOpponentKing.row - destIndexOfMovingKing.row)
        let differenceInCols = abs(indexOfOpponentKing.col - destIndexOfMovingKing.col)
        
        // if they're too close, move is invalid
        if case 0...1 = differenceInRows{
            if case 0...1 = differenceInCols{
                return true
            }
        }
        
        return false
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func isAttackingAlliedPiece(sourceChessPiece: UIChessPiece, destIndex: BoardIndex) -> Bool {
        
        let destPiece: Piece = theChessBoard.board[destIndex.row][destIndex.col]
        
        guard !(destPiece is Dummy) else {
            return false
        }
        // if it is not a dummy, it MUST be a chess piece
        let destChessPiece = destPiece as! UIChessPiece
        // if the source and destination chess pieces are same color, that means they are attacking ally
        return (sourceChessPiece.color == destChessPiece.color)
        
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
