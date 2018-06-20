//
//  ChessBoard.swift
//  MobileChess
//
//  Created by Kathleen on 6/12/18.
//  Copyright © 2018 Team Cowdog. All rights reserved.
//





// chessboard object will place all the chess pieces onto the screen
import UIKit

class ChessBoard: NSObject {
    var board: [[Piece]]! // matrix 2d array
    var vc: ViewController!
    let ROWS = 8
    let COLS = 8
    var whiteKing: King!
    var blackKing: King!
    
    
    func remove(piece: Piece)
    {
        if let chessPiece = piece as? UIChessPiece{
            // remove from board matrix
            let indexOnBoard = ChessBoard.indexOf(origin: chessPiece.frame.origin)
            board[indexOnBoard.row][indexOnBoard.col] = Dummy(frame: chessPiece.frame)
            
            // remove from array of chess pieces
            if let indexInChessPiecesArray = vc.chessPieces.index(of: chessPiece){
                vc.chessPieces.remove(at: indexInChessPiecesArray)
                
                
                
            }
            // remove from screen. super view = main screen
            chessPiece.removeFromSuperview()
            
        }
    }
    
    func place(chessPiece: UIChessPiece, toIndex destIndex: BoardIndex, toOrigin destOrigin: CGPoint)
    {
        chessPiece.frame.origin = destOrigin
        board[destIndex.row][destIndex.col] = chessPiece
    }
    
    
    
    
    
    
    
    // doesnt depend on instance of chess board = static
    static func getFrame(forRow row: Int, forCol col: Int) -> CGRect {
        // algorthim to get location of chess piece
        let x = CGFloat(ViewController.SPACE_FROM_LEFT_EDGE + col * ViewController.TILE_SIZE)
        let y = CGFloat(ViewController.SPACE_FROM_TOP_EDGE + row * ViewController.TILE_SIZE)
        
        return CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: ViewController.TILE_SIZE, height: ViewController.TILE_SIZE))
    }
    
    
    static func indexOf(origin: CGPoint) -> BoardIndex{
        let row = (Int(origin.y) - ViewController.SPACE_FROM_TOP_EDGE) / ViewController.TILE_SIZE
        let col = (Int(origin.x) - ViewController.SPACE_FROM_LEFT_EDGE) / ViewController.TILE_SIZE
        
        return BoardIndex(row: row, col: col)
    }
    
    
    
    init(viewController: ViewController) {
        
        vc = viewController
        
        // initialize the board matrix with dummies
        let oneRowOfBoard = Array(repeating: Dummy(), count: COLS) // repeat dummy piece 8x
        board = Array(repeating: oneRowOfBoard, count: ROWS) // repeat rows 8x
        
        for row in 0..<ROWS{
            for col in 0..<COLS{
                switch row {
                case 0: // 0 and 1 = black pieces
                    switch col {
                    case 0:
                        board[row][col] = Rook(frame: ChessBoard.getFrame(forRow: row,
                                forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    case 1:
                        board[row][col] = Knight(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    case 2:
                        board[row][col] = Bishop(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    case 3:
                        board[row][col] = Queen(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    case 4:
                        blackKing = King(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                        board[row][col] = blackKing
                    case 5:
                        board[row][col] = Bishop(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    case 6:
                        board[row][col] = Knight(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    default:
                        board[row][col] = Rook(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    }
                case 1:
                    board[row][col] = Pawn(frame: ChessBoard.getFrame(forRow: row,
                                                                      forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                case 6: // 6 and 7 = white pieces
                    board[row][col] = Pawn(frame: ChessBoard.getFrame(forRow: row,
                                                                      forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                case 7:
                    switch col {
                    case 0:
                        board[row][col] = Rook(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    case 1:
                        board[row][col] = Knight(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    case 2:
                        board[row][col] = Bishop(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    case 3:
                        board[row][col] = Queen(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    case 4:
                        whiteKing = King(frame: ChessBoard.getFrame(forRow: row,
                                                                          forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                        board[row][col] = whiteKing
                    case 5:
                        board[row][col] = Bishop(frame: ChessBoard.getFrame(forRow: row,
                                                                           forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    case 6:
                        board[row][col] = Knight(frame: ChessBoard.getFrame(forRow: row,
                                                                           forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    default:
                        board[row][col] = Rook(frame: ChessBoard.getFrame(forRow: row,
                                                                           forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                        
                    }
                    
                default:
                    board[row][col] = Dummy(frame: ChessBoard.getFrame(forRow: row, forCol: col))
                    
                }
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
}
