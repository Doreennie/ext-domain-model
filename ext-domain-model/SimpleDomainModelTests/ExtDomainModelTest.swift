//
//  ExtClass.swift
//  ext-domain-model
//
//  Created by iGuest on 10/19/17.
//  Copyright © 2017 iGuest. All rights reserved.
//

import XCTest

class ExtClass: XCTestCase {
    
    // Testing money desctroption
    func descriptionMoney() {
        let money = Money(amount: 10, currency: "USD")
        XCTAssert(money.description == "10.0USD")
    }
    // Testing person description
    func descriptionPerson() {
        let person = Person(firstName: "Ted", lastName: "Neward", age: "45")
        XCTAssert(person.description == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
    }
    // Testing family description
    func descriptionFamily() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        let family = Family(spouse1: ted, spouse2: charlotte)
        print(family.description)
    }
    // Testing job description
    func descriptionJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.description == "Guest Lecturer Salary(1000)")
    }
    // Testing Double Extension
    func doubleTest() {
        XCTAssert(10.0.USD.amount == 10.0)
        XCTAssert(10.0.YEN.currency == Money.currency.YEN)
    }
    // Testing add protocol
    func addTest() {
        let money = Money(amount: 20, currency: "USD")
        let money2 = Money(amount: 10, currency: "USD")
        let add = money.add(money2)
        XCTAssert(add == Money(amount: 30, currency: "USD"))
    }
    // Testing subtract protocol
    func subtractTest() {
        let money = Money(amount: 20, currency: "USD")
        let money2 = Money(amount: 10, currency: "USD")
        let subtract = money.subtract(money2)
        XCTAssert(subtract == Money(amount: 10, currency: "USD"))
    }
    

}
