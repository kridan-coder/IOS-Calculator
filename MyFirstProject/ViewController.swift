//
//  ViewController.swift
//  MyFirstProject
//
//  Created by Daniil Zavodchanovich on 09.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var oldValue = "0"
    var currValue = "0"
    var operation = Operation.nothing
    
    enum Operation: String{
        case divide="÷", multiply="x", summarize="+", substract="-", remaind="%", nothing=""
    }
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
        if (currValue != "0")
        {
            currValue = String(Double(currValue)! * -1)
            updateUILabel(currValue)
        }
    }
    @IBAction func clearButton(_ sender: UIButton) {
        clear(wasDividedByZero: false)
    }
    
    func clear(wasDividedByZero: Bool){
        if wasDividedByZero
        {
            print("Division by zero is prohibited")
        }
        oldValue = "0"
        currValue = "0"
        operation = .nothing
        updateUILabel(currValue)
    }
    @IBAction func equalButton(_ sender: UIButton) {
        switch operation
        {
        case .divide:
            (currValue == "0") ? clear(wasDividedByZero: true): (currValue = String(Double(oldValue)! / Double(currValue)!))
        case .multiply:
            (currValue = String(Double(oldValue)! * Double(currValue)!))
        case .summarize:
            (currValue = String(Double(oldValue)! + Double(currValue)!))
        case .substract:
            (currValue = String(Double(oldValue)! - Double(currValue)!))
        case .remaind:
            (currValue = String(Double(oldValue)!.truncatingRemainder(dividingBy: Double(currValue)!)))
        case .nothing:
            return
        }
        oldValue = "0"
        operation = Operation.nothing
        updateUILabel(currValue)
    }
    @IBAction func operationButton(_ sender: UIButton) {
        
        operation = Operation(rawValue: sender.currentTitle!) ?? .nothing
        
        if (oldValue != "0")
        {
            stashResult()
        }
        else
        {
            oldValue = currValue
            currValue = "0"
        }
    }
    @IBAction func commaButton(_ sender: UIButton) {
        if (!isFloat(currValue))
        {
            currValue += "."
            updateUILabel(currValue)
        }
    }
    @IBAction func digitButton(_ sender: UIButton) {
        
        if (currValue == "0")
        {
            currValue = sender.currentTitle!
        }
        else if (currValue.count < 8)
        {
            currValue += sender.currentTitle ?? "0"
        }
        updateUILabel(currValue)
    }
    
    func isFloat(_ value: String) -> Bool{
        return value.contains(".")
    }
    
    // this func was created because "1" should be converted to " 1" for better UI
    func updateUILabel(_ newValue: String){
        var result = ""
        
        var currIteration = 0
        var spacesAdded = 0
        var currIndex = newValue.startIndex
        while (currIteration != newValue.count)
        {
            if (newValue[currIndex] == "1")
            {
                result.append(" ")
                spacesAdded += 1
            }
            result.append(newValue[currIndex])
            currIteration += 1
            currIndex = newValue.index(newValue.startIndex, offsetBy: currIteration)
        }
        if (newValue.count > 8)
        {
            result = String(result.prefix(8 + spacesAdded))
        }
        numberLabel.text = result
        
    }
    
    
    
    
    func setButtonShadows(buttons: [UIButton])
    {
        for button in buttons{
            button.setButtonShadow()
        }
    }
    
    func stashResult(){
        switch operation
        {
        case .divide:
            (currValue == "0") ? clear(wasDividedByZero: true) : (oldValue = String(Double(oldValue)! / Double(currValue)!))
        case .multiply:
            (oldValue = String(Double(oldValue)! * Double(currValue)!))
        case .summarize:
            (oldValue = String(Double(oldValue)! + Double(currValue)!))
        case .substract:
            (oldValue = String(Double(oldValue)! - Double(currValue)!))
        case .remaind:
            (oldValue = String(Double(oldValue)!.truncatingRemainder(dividingBy: Double(currValue)!)))
        case .nothing:
            return
        }
        currValue = "0"
        updateUILabel(oldValue)    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonShadows(buttons: buttonCollection)
        
        
    }
    
    
}

extension UIButton {
    func setButtonShadow(){
        layer.shadowOpacity = 1.0
        layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.shadowOffset = CGSize(width: -3.0, height: -4.0)
        layer.shadowRadius = 6.0
        layer.cornerRadius = 8.0
    }
}
