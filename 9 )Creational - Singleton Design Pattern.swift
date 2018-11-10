import UIKit

//class SingletonDatabase{
//    var dataSource = ["Sachin" : 1, "Sehwag" : 2 , "Dravid" : 3, "Kohli" : 4, "Yuvraj" : 5 ,"Dhoni" : 6 ,"Jadeja" : 7 ,"Ashwin" : 8, "Zaheer" : 9 ,"Bhuvi" : 10, "Bumrah" : 11]
//    //Assuming this dataSoruce is coming via server call and you want to save the parsed JSON to use it elsewhere in the app via Singleton
//
//    var cricketers = [String:Int]()
//
//    static var instanceCount = 0
//
//    static let instance = SingletonDatabase()
//    private init(){
//        print("Initialisng the singleton")
//        type(of: self).instanceCount += 1
//        for dataElement in dataSource{
//             cricketers[dataElement.key] = dataElement.value
//        }
//
//    }
//
//    func getRunsScoredByCricketer(name:String) -> Int{
//        if let position = cricketers[name]{
//            print("\(name) bats at number \(position) for Indian Crikcet Team")
//            return cricketers[name]!
//        }
//
//        print("Cricketer with name \(name) not found")
//        return 0
//    }
//
//
//}

//func main(){
//    let singleton1 = SingletonDatabase.instance
//    print(SingletonDatabase.instanceCount)
//
//    let singleton2 = SingletonDatabase.instance
//    print(SingletonDatabase.instanceCount)
//
//}
//
//main()

//Monostate

class PlayerRating : CustomStringConvertible{
    private static var _nameOfThePlayer = ""
    private static var _ratingForThePlayer = 0
    
    var nameOfThePlayer : String{
        get {return type(of: self)._nameOfThePlayer}
        set(value) {type(of: self)._nameOfThePlayer = value}
    }
    
    var ratingForThePlayer : Int{
        get {return type(of: self)._ratingForThePlayer}
        set(value) {type(of: self)._ratingForThePlayer = value}
    }
    
    var description: String{
        return "\(nameOfThePlayer) has got a rating of \(ratingForThePlayer)"
    }
}

func main(){
    let playerRating1 = PlayerRating()
    playerRating1.nameOfThePlayer = "Dhoni"
    playerRating1.ratingForThePlayer = 8
    
    let playerRating2 = PlayerRating()
    playerRating2.ratingForThePlayer = 7
    
    print(playerRating1)
    print(playerRating2)
}
main()

