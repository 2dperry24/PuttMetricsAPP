//
//  Game.swift
//  PuttMetricsAPP
//
//  Created by User on 1/9/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import Foundation

class Game {
    
    public enum Token {
        case none
        case x
        case o
    }
    
    private var _board: [[Token]] = [
        [.none, .none, .none],
        [.none, .none, .none],
        [.none, .none, .none]]
    
    public var board: [[Token]] {
        return _board
    }
    
    public var currentPlayerIsX: Bool {
        return moveCount % 2 == 0
    }
    
    public var winner: Token {
        //TODO: Win logic
        return .none
    }
    
    public var moveCount: Int{
        var count: Int = 0
        for boardColumn: [Token] in _board {
            for cell: Token in boardColumn {
                if (cell != .none) {
                    count = count + 1
                }
            }
        }
        return count
    }
    
    public func takeTurn(col: Int, row: Int) {
        if (_board[col][row] == .none){
            _board[col][row] = currentPlayerIsX ? .x : .o
        } else {
            //TODO: Error! Do something?
        }
    }
    
}
