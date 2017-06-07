//
//  ViewController.swift
//  KerasOniOS
//
//  Created by Amund Tveit on 6/7/17.
//  Copyright © 2017 AmundTveit. All rights reserved.
//

import UIKit
import CoreML

class ViewController: UIViewController {
    
    let model = keras_model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func xor_with_keras(x:NSNumber,y:NSNumber) -> String{
        guard let input_data = try? MLMultiArray(shape:[2], dataType:MLMultiArrayDataType.float32) else {
            fatalError("Unexpected runtime error. MLMultiArray")
        }
        
        input_data[0] = x
        input_data[1] = y
        let i = keras_modelInput(input1: input_data)
        
        guard let xor_prediction = try? model.prediction(input: i) else {
            fatalError("Unexpected runtime error. model.prediction")
        }
        
        let result = String(describing: xor_prediction.output1[0])
        
        print(input_data[0].stringValue + " XOR "  + input_data[1].stringValue + " = " + result)
        return result
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let input_data = try? MLMultiArray(shape:[2], dataType:MLMultiArrayDataType.float32) else {
            fatalError("Unexpected runtime error. MLMultiArray")
        }
        
        xor_with_keras(x: 0, y: 0)
        xor_with_keras(x: 0, y: 1)
        xor_with_keras(x: 1, y: 0)
        xor_with_keras(x: 1, y: 1)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

