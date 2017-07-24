//
//  ViewController.swift
//  OperationSample
//
//  Created by Dehelean Andrei on 7/24/17.
//  Copyright © 2017 Dehelean Andrei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var queue: OperationQueue!

    override func viewDidLoad() {
        super.viewDidLoad()

    }



    @IBAction func startButtonTapped(_ sender: UIButton) {
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        let doneOperation = BlockOperation { 
            print("all operations are done")
        }
        
        var prevOperation: Operation?
        
        var message = "message for queue -> "
        for i in 1...5 {
            message = message + "\(i)"
            
            let newOperation = AsyncOperation(with: message)
            
//            if let operation = prevOperation {
//                newOperation.addDependency(operation)
//            }
            newOperation.queuePriority = .low
            newOperation.qualityOfService = .background
            queue.addOperation(newOperation)
            prevOperation = newOperation
    
            message = "message for queue -> "
        }
        
        doneOperation.addDependency(prevOperation!)

        queue.addOperation(doneOperation)
    }
}

