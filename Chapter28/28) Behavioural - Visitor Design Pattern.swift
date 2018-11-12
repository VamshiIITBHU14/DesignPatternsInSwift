import Foundation
import UIKit

protocol CricketAccessory{
    func accept(counter : CheckoutCounter) -> Int
}

class CricketBat : CricketAccessory{
    private var price : Double
    private var brand : String
    
    init(_ price : Double, _ brand:String) {
        self.price = price
        self.brand = brand
    }
    
    public func getPrice() -> Double{
        return price
    }
    
    public func getBrand() -> String{
        return brand
    }
    func accept(counter : CheckoutCounter) -> Int {
        return counter.moveToCounter(bat: self)
    }
}

class CricketBall : CricketAccessory{
    
    private var type : String
    private var price : Double
    
    init(_ type : String, _ price : Double){
        self.type = type
        self.price = price
        
    }
    
    public func getType() -> String{
        return type
    }
    
    public func getPrice() -> Double{
        return price
    }
    
    func accept(counter : CheckoutCounter) -> Int {
        return counter.moveToCounter(ball: self)
    }
    
}

protocol CheckoutCounter {
    func moveToCounter(bat : CricketBat) -> Int
    func moveToCounter(ball : CricketBall) -> Int
}

class CashCounter :CheckoutCounter{
    func moveToCounter(bat: CricketBat) -> Int {
        var cost : Int = 0
        if bat.getBrand() == "Brittania"{
            cost = Int(0.8 * bat.getPrice())
        } else{
            cost = Int(bat.getPrice())
        }
        print("Bat brand : \(bat.getBrand()) and price is : \(cost) ")
        return cost
    }
    
    func moveToCounter(ball: CricketBall) -> Int {
        
        print("Ball Type : \(ball.getType()) and price is : \(ball.getPrice()) ")
        return Int(ball.getPrice())
    }
}


func main(){
    print("Main")
    func finalPriceCalculation(accessories : [CricketAccessory]) -> Int{
        var checkout = CashCounter()
        var cost = 0
        for item in accessories{
            cost += item.accept(counter: checkout)
        }
        print("Toal cart value : \(cost)")
        return cost
    }
    
    var cartItems = [CricketAccessory]()
    let mrfBat = CricketBat(2000, "MRF")
    let brittaniaBat = CricketBat(1500, "Brittania")
    let tennisBall = CricketBall("Tennis", 120)
    let leatherBall = CricketBall("Leather", 200)
    cartItems.append(mrfBat)
    cartItems.append(brittaniaBat)
    cartItems.append(tennisBall)
    cartItems.append(leatherBall)
    
    var cost = finalPriceCalculation(accessories: cartItems)
    print("Checked Out with Bill Amount : \(cost)")
}

main()

