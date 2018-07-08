//
//  ViewController.swift
//  MobileChess
//
//  Created by Kathleen on 6/12/18.
//  Copyright © 2018 Team Cowdog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet var panOUTLET: UIPanGestureRecognizer!
    @IBOutlet var lblDisplayTurnOUTLET: UILabel!
    
    @IBOutlet var lblDisplayCheckOUTLET: UILabel!
    
    var pieceDragged: UIChessPiece!
    var sourceOrigin: CGPoint!
    var destOrigin: CGPoint!
    static var SPACE_FROM_LEFT_EDGE: Int = 8
    static var SPACE_FROM_TOP_EDGE: Int = 132
    static var TILE_SIZE: Int = 38
    var myChessGame: ChessGame! // chess match
    var chessPieces: [UIChessPiece]! // array of chess pieces
    var isAgainstAI: Bool!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        chessPieces = [] // empty array
        
        
        myChessGame = ChessGame.init(viewController: self) // self = current vc
        print("SINGLEPLAYER: \(isAgainstAI)")
        
    }
    
    
    // which was dragged and is it a chess piece? then move it in touches moved
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        pieceDragged = touches.first!.view as? UIChessPiece // drag if its a chess piece
        
       
        if pieceDragged != nil{ // if we have a valid chess piece
            sourceOrigin = pieceDragged.frame.origin  // make piece go back where it was if user drags to invalid location
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if pieceDragged != nil{
              drag(piece: pieceDragged, usingGestureRecognizer: panOUTLET) // drag that piece using our pan outlet
        }
      
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if pieceDragged != nil{
            // get location of where user touched
            let touchLocation = touches.first!.location(in: view)
            
            
            // for destination location 
            var x = Int(touchLocation.x)
            var y = Int(touchLocation.y)
            
            // touch location minus - 2 offsets
            x -= ViewController.SPACE_FROM_LEFT_EDGE
            y -= ViewController.SPACE_FROM_TOP_EDGE
            
            // this makes x be at that tile's origin
            x = (x / ViewController.TILE_SIZE) * ViewController.TILE_SIZE
            y = (y / ViewController.TILE_SIZE) * ViewController.TILE_SIZE
            
            // place back the offsets
            x += ViewController.SPACE_FROM_LEFT_EDGE
            y += ViewController.SPACE_FROM_TOP_EDGE
            
            // set destination origin
            destOrigin = CGPoint(x: x, y: y)
            
            let sourceIndex = ChessBoard.indexOf(origin: sourceOrigin)
            let destIndex = ChessBoard.indexOf(origin: destOrigin)
            
            // move to destination if valid. if not then move back to original location
            if myChessGame.isMoveValid(piece: pieceDragged, fromIndex: sourceIndex, toIndex: destIndex){
                
                myChessGame.move(piece: pieceDragged, fromIndex: sourceIndex, toIndex: destIndex, toOrigin: destOrigin)
                
               
                
                // check if game is over
                if myChessGame.isGameOver(){
                    displayWinner()
                    return
                }
                
                
                if shouldPromotePawn(){
                    promptForPawnPromotion()
                }
                else{
                    resumeGame()
                    
                    
                    
                    
                    
              
                }
                
                
                
                
                
           
            }
            else{
                pieceDragged.frame.origin = sourceOrigin
            }
  
        }
        
    }
    
    func resumeGame(){
        
        // if a move is made..
        
        displayCheck()
        // change the turn
        myChessGame.nextTurn()
        
        
        // display turn on screen
        updateTurnOnScreen()
        
        // make AI move, if necessary
        if isAgainstAI == true && !myChessGame.isWhiteTurn{
            
            myChessGame.makeAIMove()
            if myChessGame.isGameOver(){
                displayWinner()
                return
            }
            
            if shouldPromotePawn(){
                promote(pawn: myChessGame.getPawnToBePromoted()!, into: "Queen")
                
            }
            
            displayCheck()
            
            myChessGame.nextTurn()
            
            updateTurnOnScreen()
            
        }
        
    }
    
    
    
    func promote(pawn pawnToBePromoted: Pawn, into pieceName: String){
        
        let pawnColor = pawnToBePromoted.color
        let pawnFrame = pawnToBePromoted.frame
        let pawnIndex = ChessBoard.indexOf(origin: pawnToBePromoted.frame.origin)
        
        myChessGame.theChessBoard.remove(piece: pawnToBePromoted)
        
        switch pieceName {
        case "Queen":
            myChessGame.theChessBoard.board[pawnIndex.row][pawnIndex.col] = Queen(frame: pawnFrame, color: pawnColor, vc: self)
        case "Knight":
            myChessGame.theChessBoard.board[pawnIndex.row][pawnIndex.col] = Knight(frame: pawnFrame, color: pawnColor, vc: self)
        case "Rook":
            myChessGame.theChessBoard.board[pawnIndex.row][pawnIndex.col] = Rook(frame: pawnFrame, color: pawnColor, vc: self)
        case "Bishop":
            myChessGame.theChessBoard.board[pawnIndex.row][pawnIndex.col] = Bishop(frame: pawnFrame, color: pawnColor, vc: self)
        default:
            break
        }
        
        
        
        
    }
    
    func promptForPawnPromotion(){
        
        if let pawnToPromote = myChessGame.getPawnToBePromoted(){
            
            let box = UIAlertController(title: "Pawn promotion", message: "Choose piece", preferredStyle: UIAlertControllerStyle.alert)
            
            box.addAction(UIAlertAction(title: "Queen", style: UIAlertActionStyle.default, handler: { action in
                self.promote(pawn: pawnToPromote, into: action.title!)
                
                self.resumeGame()
            }))
            
            
            box.addAction(UIAlertAction(title: "Knight", style: UIAlertActionStyle.default, handler: { action in
                self.promote(pawn: pawnToPromote, into: action.title!)
                
                self.resumeGame()
            }))
            
            box.addAction(UIAlertAction(title: "Rook", style: UIAlertActionStyle.default, handler: { action in
                self.promote(pawn: pawnToPromote, into: action.title!)
                
                self.resumeGame()
            }))
            
            box.addAction(UIAlertAction(title: "Bishop", style: UIAlertActionStyle.default, handler: { action in
                self.promote(pawn: pawnToPromote, into: action.title!)
                
                self.resumeGame()
            }))
            
            self.present(box, animated: true, completion: nil)
            
            
            
            
        }
        
    }
    
    
    func shouldPromotePawn() -> Bool{
        return (myChessGame.getPawnToBePromoted() != nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    func displayCheck(){
        let playerChecked = myChessGame.getPlayerChecked()
        if playerChecked != nil{
            lblDisplayCheckOUTLET.text = playerChecked! + "is in check!"
        }
        else{
            // no player is checked
            lblDisplayCheckOUTLET.text = nil
        }
    }
    
    func displayWinner(){
        let box = UIAlertController(title: "Game Over", message: "\(myChessGame.winner!) wins", preferredStyle: UIAlertControllerStyle.alert)
        
        box.addAction(UIAlertAction(title: "Back to main menu", style: UIAlertActionStyle.default, handler: {
            
            // set up unwind segue manually
            action in self.performSegue(withIdentifier: "backToMainMenu", sender: self)
        }))
        
        box.addAction(UIAlertAction(title: "Rematch", style: UIAlertActionStyle.default, handler: {
        action in
            
            // clear screen, chess pieces array, and board matrix
            for chessPiece in self.chessPieces{
                // remove all pieces from the board
                self.myChessGame.theChessBoard.remove(piece: chessPiece)
            }
            
            // create new game
            // when you initialize new game, you reset board with new chess pieces
            self.myChessGame = ChessGame(viewController: self)
            
            // update labels with game status
            self.updateTurnOnScreen()
            self.lblDisplayCheckOUTLET.text = nil
  
        }))
        self.present(box, animated: true, completion: nil)
    }
    
    func updateTurnOnScreen(){
        lblDisplayTurnOUTLET.text = myChessGame.isWhiteTurn ? "White's turn": "Black's turn"
        lblDisplayTurnOUTLET.textColor = myChessGame.isWhiteTurn ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }

    func drag(piece: UIChessPiece, usingGestureRecognizer gestureRecognizer: UIPanGestureRecognizer){
        
        let translation = gestureRecognizer.translation(in: view)
        
        // where it started to where it ended
        piece.center = CGPoint(x: translation.x + piece.center.x, y: translation.y + piece.center.y)
        
        // pieces to go exactly where finger goes. no velocity gain
        gestureRecognizer.setTranslation(CGPoint.zero, in: view)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

