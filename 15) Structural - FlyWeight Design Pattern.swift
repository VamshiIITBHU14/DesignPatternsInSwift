import UIKit
import Foundation

class PlayerProfile{
    var fullName : String
    var teamsPlayedFor : [String]
    
    init(_ fullName : String, _ teamsPlayedFor : [String]) {
        self.fullName = fullName
        self.teamsPlayedFor = teamsPlayedFor
    }
    
    var charCount: Int
    {
        var count = 0
        for team in teamsPlayedFor{
            count += team.utf8.count
        }
        count += fullName.utf8.count
        return count
    }
}

class PlayerProfileOptimised{
    static var stringsArray = [String]()
    private var genericNames = [Int]()
    
    init(_ fullName: String, _ teamsPlayedFor : [String])
    {
        func getOrAdd(_ s: String) -> Int
        {
            if let idx = type(of: self).stringsArray.index(of: s)
            {
                return idx
            }
            else
            {
                type(of: self).stringsArray.append(s)
                return type(of: self).stringsArray.count - 1
            }
        }
        genericNames = fullName.components(separatedBy: " ").map { getOrAdd($0) }
        for team in teamsPlayedFor{
            genericNames = team.components(separatedBy: " ").map {getOrAdd($0) }
        }
    }
    
    static var charCount: Int
    {
        return stringsArray.map{ $0.utf8.count }.reduce(0, +)
    }
}

//let dhoni = PlayerProfile("Mahendra Dhoni",["India ,Chennai"])
//let kohli = PlayerProfile("Virat Kohli",["India , Bangalore"])
//let yuvi = PlayerProfile("Yuvraj Singh",["India , Punjab"])
//print("Total number of chars used:"  ,dhoni.charCount + kohli.charCount + yuvi.charCount)


func main()
{
    let dhoni1 = PlayerProfileOptimised("Mahendra Dhoni",["India ,Chennai"])
    let kohli1 = PlayerProfileOptimised("Virat Kohli",["India , Bangalore"])
    let yuvi1 = PlayerProfileOptimised("Yuvraj Singh",["India , Punjab"])
    print("Total number of chars used:"  ,PlayerProfileOptimised.charCount)
}

main()

