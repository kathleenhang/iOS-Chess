//
//  Dummy.swift
//  MobileChess
//
//  Created by Kathleen on 6/12/18.
//  Copyright © 2018 Team Cowdog. All rights reserved.
//

import UIKit

// implements Piece protocol
class Dummy: Piece
{
    private var xStorage: CGFloat! // since variable is private, use getters to retrieve value
    private var yStorage: CGFloat! // implicitly unwrapped. nil but dont need to unwrap them
    var x: CGFloat
    {
        get
        {
            return self.xStorage
        }
        set{
            self.xStorage = newValue
        }
    }
    var y: CGFloat
        {
        get{
            return self.yStorage
            
        }
        set{
            self.yStorage = newValue
            
        }
    }
    
    init(frame: CGRect) {
        self.xStorage = frame.origin.x
        self.yStorage = frame.origin.y
    }
    
    init(){
        
    }
    
    
    
    
    
    
}
