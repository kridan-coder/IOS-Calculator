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
    var operation = Operation.Nothing
    
    enum Operation: String{
        case Divide="÷", Multiply="x", Summarize="+", Substract="-", Remaind="%", Nothing=""
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
        if (wasDividedByZero)
        {
            print("Division by zero is prohibited")
        }
        oldValue = "0"
        currValue = "0"
        operation = Operation.Nothing
        updateUILabel(currValue)
    }
    @IBAction func equalButton(_ sender: UIButton) {
        switch operation
        {
        case .Divide:
            (currValue == "0") ? clear(wasDividedByZero: true): (currValue = String(Double(oldValue)! / Double(currValue)!))
        case .Multiply:
            (currValue = String(Double(oldValue)! * Double(currValue)!))
        case .Summarize:
            (currValue = String(Double(oldValue)! + Double(currValue)!))
        case .Substract:
            (currValue = String(Double(oldValue)! - Double(currValue)!))
        case .Remaind:
            (currValue = String(Double(oldValue)!.truncatingRemainder(dividingBy: Double(currValue)!)))
        case .Nothing:
            return
        }
        oldValue = "0"
        operation = Operation.Nothing
        updateUILabel(currValue)
    }
    @IBAction func operationButton(_ sender: UIButton) {
        switch sender.currentTitle! {
        case "÷":
            operation = Operation.Divide
        case "x":
            operation = Operation.Multiply
        case "+":
            operation = Operation.Summarize
        case "-":
            operation = Operation.Substract
        case "%":
            operation = Operation.Remaind
        default:
            operation = Operation.Nothing
        }
        
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
        else if (numberLabel.text!.count < 8)
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
        var currIndex = newValue.startIndex
        while (currIteration != newValue.count)
        {
            result.append(newValue[currIndex])
            if (newValue[currIndex] == "1")
            {
                result.append(" ")
            }
            currIteration += 1
            currIndex = newValue.index(newValue.startIndex, offsetBy: currIteration)
        }
        if (result.count > 8)
        {
            result = String(result.prefix(8))
        }
        numberLabel.text = result
        
    }
    
    func basicDropShadow(button: UIButton){
        button.layer.shadowColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        button.layer.shadowRadius = 2.0
        button.layer.cornerRadius = 4.0
    }
    
    func setButtonShadows(buttons: [UIButton])
    {
        for button in buttons{
            basicDropShadow(button: button)
        }
    }
    
    func stashResult(){
        switch operation
        {
        case .Divide:
            (currValue == "0") ? clear(wasDividedByZero: true) : (oldValue = String(Double(oldValue)! / Double(currValue)!))
        case .Multiply:
            (oldValue = String(Double(oldValue)! * Double(currValue)!))
        case .Summarize:
            (oldValue = String(Double(oldValue)! + Double(currValue)!))
        case .Substract:
            (oldValue = String(Double(oldValue)! - Double(currValue)!))
        case .Remaind:
            (oldValue = String(Double(oldValue)!.truncatingRemainder(dividingBy: Double(currValue)!)))
        case .Nothing:
            return
        }
        currValue = "0"
        updateUILabel(oldValue)    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonShadows(buttons: buttonCollection)
        
        
    }


}

