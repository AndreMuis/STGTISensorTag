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


// hex values

var hexValue : UInt8 = 0x01
print (hexValue)

hexValue = 0xFF
print (hexValue)


// bitwise operations

// 00000001
let signed : Int8 = 1

// 10000000
signed << 7


// 00000001
let unsigned : UInt8 = 1

// 10000000
unsigned << 7


Int16(truncatingBitPattern: 0xffff)


let a = 0xff00

a is UInt64












