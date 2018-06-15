//
//  ExtensionUIChessPiece.swift
//  MobileChess
//
//  Created by Kathleen on 6/12/18.
//  Copyright © 2018 Team Cowdog. All rights reserved.
//

import UIKit
typealias UIChessPiece = UILabel // UILabel becomes UIChessPiece

// extension for more functionality for UIChessPiece
extension UIChessPiece: Piece{
    var x: CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            // frame = CGRect
            // origin = point = x y
            self.frame.origin.x = newValue
        }
    }
    var y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y = newValue
        }
        
    }
    
    // non confusing name to get color
    var color: UIColor{
        get{
            return self.textColor
        }
    }
   
}
