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
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        chessPieces = [] // empty array
        myChessGame = ChessGame.init(viewController: self) // self = current vc
        
        
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
            
            let sourceIndex = BoardIndex(row: 0, col: 0)
            let destIndex = BoardIndex(row: 0, col: 0)
            
            // move to destination if valid. if not then move back to original location
            if myChessGame.isMoveValid(piece: pieceDragged, fromIndex: sourceIndex, toIndex: destIndex){
                pieceDragged.frame.origin = destOrigin
            }
            else{
                pieceDragged.frame.origin = sourceOrigin
            }
            
            
            
            
        }
        
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

