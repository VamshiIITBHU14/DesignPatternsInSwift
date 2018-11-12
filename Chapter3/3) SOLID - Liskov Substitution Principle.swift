import UIKit
import Foundation

//protocol Cricketer {
//    func canBat()
//    func canBowl()
//    func canField()
//}
//
//class AllRounder : Cricketer{
//    func canBat() {
//        print("I can bat")
//    }
//
//    func canBowl() {
//        print("I can bowl")
//    }
//
//    func canField() {
//        print("I can field")
//    }
//}
//
//class Batsman : Cricketer{
//    func canBat() {
//        print("I can bat")
//    }
//
//    func canBowl() {
//        print("I cannot bowl")
//    }
//
//    func canField() {
//        print("I can field")
//    }
//}

protocol Cricketer {
    func canBat()
    func canField()
}

class Batsman : Cricketer{
    func canBat() {
        print("I can bat")
    }
    
    func canField() {
        print("I can field")
    }
}

class BatsmanWhoCanBowl : Cricketer{
    func canBat() {
        
    }
    
    func canField() {
        
    }
    
    func canBowl() {
        
    }
}

class AllRounder : BatsmanWhoCanBowl{
    
}


