//
//  Piece.swift
//  MobileChess
//
//  Created by Kathleen on 6/12/18.
//  Copyright © 2018 Team Cowdog. All rights reserved.
//

import UIKit

protocol Piece
{
    // anything that is a piece must implement get / set for x y
    var x: CGFloat { get set }
    var y: CGFloat { get set }
}
