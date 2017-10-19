//
//  main.swift
//  ext-domain-model
//
//  Created by iGuest on 10/18/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//

protocol CustomStringConvertible {
    func description<anyType> (x: anyType) -> String
}

protocol Mathematics {
    func add(_to: Money) -> Money
    func subtract(_from: Money) -> Money
}

public struct Money: CustomStringConvertible, Mathematics {
    public var amount : Double
    public var currency : String
    
    public init(amount: Int, currency: String) {
        self.amount = Double(amount)
        self.currency = String(currency)
    }
    
    func description<anyType>(x: anyType) -> String {
        return ("\(self.currency)\(self.amount)")
    }
    
    public func convert(_ to: String) -> Money {
        var currentCurrency = currency
        var currentAmount = amount
        switch (currency, to) {
        case("USD", "GBP"):
            currentAmount *= 0.5
            currentCurrency = "GBP"
        case("USD", "EUR"):
            currentAmount *= 1.5
            currentCurrency = "EUR"
        case("USD", "CAN"):
            currentAmount *= 1.25
            currentCurrency = "CAN"
        case("EUR", "USD"):
            currentAmount /= 1.5
            currentCurrency = "USD"
        case("EUR", "CAN"):
            currentAmount *= 1.48
            currentCurrency = "CAN"
        case("EUR", "GBP"):
            currentAmount *= 0.89
            currentCurrency = "GBP"
        case("CAN", "USD"):
            currentAmount *= 0.8
            currentCurrency = "USD"
        case("CAN", "GBP"):
            currentAmount *= 0.6
            currentCurrency = "GBP"
        case("CAN", "EUR"):
            currentAmount *= 0.68
            currentCurrency = "EUR"
        case("GBP", "USD"):
            currentAmount *= 2
            currentCurrency = "USD"
        case("GBP", "CAN"):
            currentAmount *= 1.66
            currentCurrency = "CAN"
        case("GBP", "EUR"):
            currentAmount *= 1.12
            currentCurrency = "EUR"
        default:
            print("Please enter a valid case of either GBP, EUR or CAN")
        }
        return Money(amount: Int(currentAmount), currency: String(currentCurrency))
    }
    
    public func add(_to: Money) -> Money {
        let newCurr = self.convert(_to.currency)
        let newMoney = newCurr.amount + _to.amount
        return Money(amount: Int(newMoney), currency: newCurr.currency)
    }
    
    public func subtract(_from: Money) -> Money {
        let newCurr = self.convert(_from.currency)
        let newMoney = newCurr.amount - _from.amount
        return Money(amount: Int(newMoney), currency: newCurr.currency)
    }
}

let test1 = Money(amount: 10, currency: "USD")
let test2 = Money(amount: 5, currency: "CAN")

extension Double {
    var USD: Money {
        return Money(amount: Int(self), currency: "USD")
    }
    var EUR: Money {
        return Money(amount: Int(self), currency: "EUR")
    }
    var GBP: Money {
        return Money(amount: Int(self), currency: "GBP")
    }
    var YEN: Money {
        return Money(amount: Int(self), currency: "YEN")
    }
}


//////////////////////////////////

open class Job: CustomStringConvertible {
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    func description<anyType>(x: anyType) -> String {
        return ("\(self.title) \(self.type)")
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch type {
        case .Hourly(let totHours):
            return Int(totHours * Double(hours))
        case .Salary(let totSal):
            return totSal
        }
    }
    
    open func raise(_ amt : Double) {
        switch type {
        case .Salary(let totSal):
            self.type = .Salary(totSal + Int(amt))
        case .Hourly(let totHour):
            self.type = .Hourly(totHour + amt)
        }
    }
    
}

////////////////////////////////////
// Person
//
open class Person: CustomStringConvertible {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    func description<anyType>(x: anyType) -> String {
        return ("\(self.firstName) \(self.lastName) \(self.age)")
    }
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get { return _job }
        set(value) {
            if age >= 16{
                _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get { return _spouse}
        set(value) {
            if age >= 18{
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
}

//////////////////////////////////
//Family
//
open class Family: CustomStringConvertible {
    fileprivate var members : [Person] = []
    
    func description<anyType>(x: anyType) -> String {
        var allPeople = ""
        for person in members {
            allPeople += "\(person.firstName) \(person.lastName) "
        }
        return allPeople
    }
    
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
    
    open func haveChild(_ child: Person) -> Bool {
        for person in members {
            if person.age > 20 {
                members.append(child)
                return true
            }
        }
        return false
    }
    
    open func householdIncome() -> Int {
        var totIncome = 0;
        for person in members {
            if person.job != nil {
                totIncome += person.job!.calculateIncome(2000)
            }
        }
        return totIncome
    }
}


