import UIKit

//MARK: -Product
public struct CricketTeam{
    public let captain : Captain
    public let batsmen : Batsmen
    public let bowlers : Bowlers
}

extension CricketTeam : CustomStringConvertible{
    public var description : String{
        return "Team with captain \(captain.rawValue)"
    }
}

public enum Captain : String{
    case Dhoni
    case Kohli
    case Rahane
}

public struct Batsmen : OptionSet{
    public static let topOrderBatsman = Batsmen(rawValue: 1 << 0)
    public static let middleOrderBatsman = Batsmen(rawValue: 1 << 1)
    public static let lowerOrderBatsman = Batsmen(rawValue: 1 << 2)
    
    public let rawValue : Int
    public init(rawValue : Int){
        self.rawValue = rawValue
    }
}

public struct Bowlers : OptionSet{
    public static let fastBowler = Bowlers(rawValue: 1 << 0)
    public static let mediumPaceBowler = Bowlers(rawValue: 1 << 1)
    public static let spinBowler = Bowlers(rawValue: 1 << 2)
    
    public let rawValue : Int
    public init(rawValue : Int){
        self.rawValue = rawValue
    }
}

//MARK: -Builder
public class CricketTeamBuilder{
    
    public enum Error:Swift.Error{
        case alreadyTaken
    }
    
    public private(set) var captain : Captain = .Dhoni
    public private(set) var batsmen : Batsmen = []
    public private(set) var bowlers : Bowlers = []
    private var soldOutCaptains : [Captain] = [.Dhoni]
    
    public func addBatsman(_ batsman : Batsmen){
        batsmen.insert(batsman)
    }
    
    public func removeBatsman(_ batsman: Batsmen) {
        batsmen.remove(batsman)
    }
    
    public func addBowler(_ bowler : Bowlers){
        bowlers.insert(bowler)
    }
    
    public func removeBowler(_ bowler: Bowlers) {
        bowlers.remove(bowler)
    }
    
    //    public func pickCaptain(_ captain : Captain){
    //        self.captain = captain
    //    }
    
    public func pickCaptain(_ captain: Captain) throws {
        guard isAvailable(captain) else { throw Error.alreadyTaken }
        self.captain = captain
    }
    
    public func isAvailable(_ captain: Captain) -> Bool {
        return !soldOutCaptains.contains(captain)
    }
    
    public func makeTeam() -> CricketTeam{
        return CricketTeam(captain: captain, batsmen: batsmen, bowlers: bowlers)
    }
    
    
}

//MARK: -Maker
public class TeamOwner {
    
    public func createTeam1() throws -> CricketTeam {
        let teamBuilder = CricketTeamBuilder()
        try teamBuilder.pickCaptain(.Kohli)
        teamBuilder.addBatsman(.topOrderBatsman)
        teamBuilder.addBowler([.fastBowler, .spinBowler])
        return teamBuilder.makeTeam()
    }
    
    public func createTeam2() throws -> CricketTeam {
        let teamBuilder = CricketTeamBuilder()
        try teamBuilder.pickCaptain(.Dhoni)
        teamBuilder.addBatsman([.topOrderBatsman, .lowerOrderBatsman])
        teamBuilder.addBowler([.mediumPaceBowler, .spinBowler])
        return teamBuilder.makeTeam()
    }
    
}

func main(){
    let owner = TeamOwner()
    if let team = try? owner.createTeam1(){
        print("Hello! " + team.description)
    }
    
    if let team = try? owner.createTeam2(){
        print("Hello! " + team.description)
    } else{
        print("Sorry! Captain already taken")
    }
}

main()



