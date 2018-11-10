import UIKit
import Foundation

//Any Swift type that conforms the Hashable protocol must also conform the Equatable protocol. Because Hashable protocol is inherited from Equatable protocol
//Team represents an object that can buy a player
public struct Team {
    
    public let teamId: String
    public var teamName: String
}

extension Team: Hashable {
    
    public var hashValue : Int{
        return teamId.hashValue
    }
    
    public static func == (lhs : Team, rhs : Team) -> Bool{
        return lhs.teamId == rhs.teamId
    }
    
}

public struct Player {
    public let playerId: String
    public var primaryRole: String
    public var price: Double
}

extension Player : Hashable{
    
    public var hashValue : Int{
        return playerId.hashValue
    }
    
    public static func ==(lhs:Player, rhs:Player) ->Bool{
        return lhs.playerId == rhs.playerId
    }
}

public class AvailablePlayersList{
    public var availablePlayers : [Player : Int] = [:]
    
    public init(availablePlayers : [Player:Int]){
        self.availablePlayers = availablePlayers
    }
    
}

public class SoldPlayersList{
    public var soldPlayers : [Team:[Player]] = [:]
}

public class AuctionFacade{
    
    public let availablePlayersList : AvailablePlayersList
    public let soldPlayersList : SoldPlayersList
    
    public init(availablePlayersList:AvailablePlayersList, soldPlayersList:SoldPlayersList){
        self.availablePlayersList = availablePlayersList
        self.soldPlayersList = soldPlayersList
    }
    
    public func buyAPlayer(for player: Player,
                           by team: Team) {
        
        print("Ready to buy \(player.primaryRole) with id '\(player.playerId)' - '\(team.teamName)'")
        
        let count = availablePlayersList.availablePlayers[player, default: 0]
        guard count > 0 else {
            print("'\(player.primaryRole)' is sold out")
            return
        }
        
        availablePlayersList.availablePlayers[player] = count - 1
        
        var soldOuts =
            soldPlayersList.soldPlayers[team, default: []]
        soldOuts.append(player)
        soldPlayersList.soldPlayers[team] = soldOuts
        
        print("\(player.primaryRole) with \(player.playerId) " + "bought by '\(team.teamName)'")
    }
    
}


func main(){
    let bowler1 = Player(playerId: "12345", primaryRole: "Bowler", price: 123)
    let batsman1 = Player(playerId: "12365", primaryRole: "Batsman", price: 152)
    
    let availablePlayerList = AvailablePlayersList(availablePlayers: [bowler1 : 3, batsman1:45])
    let auctionFacade = AuctionFacade(availablePlayersList: availablePlayerList, soldPlayersList: SoldPlayersList())
    let team1 = Team(teamId: "XYZ-123", teamName: "Sydney")
    auctionFacade.buyAPlayer(for: bowler1, by: team1)
}

main()

