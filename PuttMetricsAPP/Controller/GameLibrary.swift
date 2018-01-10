//
//  GameLibrary.swift
//  PuttMetricsAPP
//
//  Created by User on 1/9/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import Foundation

class GameLibrary {
    
//    private static var _Instance : GameLibrary! = nil
//    public static var Instance: GameLibrary {
//        if _Instance == nil {
//            _Instance = GameLibrary()
//        }
//        return _Instance
//    }
    
    
    //TODO: Thread safety!!!!!!!!!!!!
    public static let Instance: GameLibrary =  GameLibrary()
    
    private init() {
        
    }
    
    private var _games: [Game] = []
    
    
    public var count: Int {
        return _games.count
    }
    
    public func createNewGame() {
        _games.append(Game())
    }
    
    public func deleteGame(index: Int) {
    _games.remove(at: index)
    
    }
    
    public func game(index: Int) -> Game {
    
        return _games[index]
    }
    
    public func load() {
        //TODO: Load from file
    }
    public func save() {
        // Save to file
        
        
    }
    
    
}
