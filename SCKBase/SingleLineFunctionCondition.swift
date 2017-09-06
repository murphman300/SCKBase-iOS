//
//  SingleLineFunctionCondition.swift
//  TabBarMain
//
//  Created by Jean-Louis Murphy on 2017-09-04.
//
//  Copyright © 2017 Jean-Louis Murphy. All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//



import Foundation

/**
 
 Allows for a single line conditional statement to execute either of two Functions
 Modeled after the traditional statement : let new = ifTrue ? thenThis : otherwiseThis
 
 Syntax:
 
 conditionalVariableOrMethod ?- methodIfTrue >< methodIfFalse
 
 Think of the overal operator : ?-><
 
 Notice:
 Do not include the parenthese declaration in the left and right hand side of >?. >? can take func declared functions, but also (()->()) (executable) type variables:
 
 func someFunction()
 
 var someExecutable : (()->())?
 
 ?> is for a chained conditional line, such as if one of the initial >? methods should also be subject to a condition
 
 
 conditionalVariableOrMethod ?- (someOtherCondition ?> firstNestedMethod >< secondNestedMethod) >< methodIfFalse
 
 */

precedencegroup VoidValidation {
    associativity: left
}

precedencegroup VoidArgumentPrecedence {
    associativity: left
    higherThan: VoidValidation
}

infix operator ?- : VoidValidation

infix operator >< : VoidArgumentPrecedence

infix operator ?> : VoidValidation

public func >< <T>(lhs: @autoclosure ()->T, rhs: @autoclosure ()->T) -> (T,T) {
    return (lhs(), rhs())
}

public func ?- (_ lhs : Bool, _ rhs : @autoclosure ()->((()->()),(()->()))) {
    let either = rhs()
    (lhs ? either.0 : either.1)()
}

public func ?> (_ lhs : Bool, _ rhs : @autoclosure ()->((()->()),(()->()))) -> (()->()) {
    let either = rhs()
    return (lhs ? either.0 : either.1)
}
