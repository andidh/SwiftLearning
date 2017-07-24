//
//  AsynOperation.swift
//  OperationSample
//
//  Created by Dehelean Andrei on 7/24/17.
//  Copyright © 2017 Dehelean Andrei. All rights reserved.
//

import Foundation

final class AsyncOperation: Operation {
    
    override var isExecuting: Bool {
        get { return _executing }
        set {
            willChangeValue(forKey:#keyPath(isExecuting))
            _executing = newValue
            didChangeValue(forKey: #keyPath(isExecuting))
        }
    }
    override var isFinished: Bool {
        get {return _finished }
        set {
            willChangeValue(forKey:#keyPath(isFinished))
            _finished = newValue
            didChangeValue(forKey: #keyPath(isFinished))

        }
        
    }
    
    fileprivate var _executing: Bool = false
    fileprivate var _finished: Bool = false
    
    override var isAsynchronous: Bool { return true }
    
    var message: String
    

    
    init(with message: String) {
        self.message = message
        super.init()
    }
    
    override func start() {
        guard !isFinished else { return }
        guard !isCancelled else {
            done()
            return
        }
        
        isExecuting = true
        doStuff()
    }
    
    var values = [2,3,4]
    
    fileprivate func doStuff() {
        
        let i = Int(arc4random_uniform(3))
        sleep(UInt32(values[i]))
        
        print("message: \(message) - slept \(values[i]) seconds")
        
        done()
    }
    
    func done() {
        isExecuting = false
        isFinished = true
    }
}
