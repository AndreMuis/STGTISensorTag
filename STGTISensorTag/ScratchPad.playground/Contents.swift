//: Playground - noun: a place where people can play

import UIKit


// check for existence and type at the same time

let dictionary : [String : AnyObject] = ["one" : 1, "two" : 2, "three" : 3]

if let number = dictionary["Andre"] as? Int
{
    print("success. number = \(number)")
}

if let number = dictionary["three"] as? String
{
    print("success. number = \(number)")
}

if let number = dictionary["three"] as? Int
{
    print("success. number = \(number)")
}



