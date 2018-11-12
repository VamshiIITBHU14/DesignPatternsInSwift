import Foundation
import UIKit

enum Team{
    case india
    case australia
    case pakistan
    case england
}

enum Role{
    case batsman
    case bowler
    case allrounder
}

class Cricketer{
    
    var name:String
    var team:Team
    var role:Role
    
    init(_ name:String, _ team:Team, _ role:Role) {
        self.name = name
        self.team = team
        self.role = role
    }
    
}

class CricketerFilter{
    
    func filterByRole(_ cricketers:[Cricketer], _ role:Role) -> [Cricketer]{
        var filteredResults = [Cricketer]()
        for item in cricketers{
            if item.role == role{
                filteredResults.append(item)
            }
        }
        return filteredResults
    }
    
    func filterByTeam(_ cricketers:[Cricketer], _ team:Team) -> [Cricketer]{
        var filteredResults = [Cricketer]()
        for item in cricketers{
            if item.team == team{
                filteredResults.append(item)
            }
        }
        return filteredResults
    }
    
    func filterByRoleAndTeam(_ cricketers:[Cricketer], _ role:Role, _ team:Team) -> [Cricketer]{
        var filteredResults = [Cricketer]()
        for item in cricketers{
            if item.role == role && item.team == team{
                filteredResults.append(item)
            }
        }
        return filteredResults
    }
    
}

//Conditions
protocol Condition{
    associatedtype T
    func isConditionMet(_ item: T) -> Bool
}

protocol Filter
{
    associatedtype T
    func filter<Cond: Condition>(_ items: [T], _ cond: Cond) -> [T]
        where Cond.T == T;
}

class RoleCondition : Condition
{
    typealias T = Cricketer
    let role: Role
    init(_ role: Role)
    {
        self.role = role
    }
    
    func isConditionMet(_ item: Cricketer) -> Bool {
        return item.role == role
    }
}

class TeamCondition : Condition
{
    typealias T = Cricketer
    let team: Team
    init(_ team: Team)
    {
        self.team = team
    }
    
    func isConditionMet(_ item: Cricketer) -> Bool {
        return item.team == team
    }
}



class OCPCricketFilter : Filter
{
    typealias T = Cricketer
    
    func filter<Cond: Condition>(_ items: [Cricketer], _ cond: Cond)
        -> [T] where Cond.T == T
    {
        var filteredItems = [Cricketer]()
        for i in items
        {
            if cond.isConditionMet(i)
            {
                filteredItems.append(i)
            }
        }
        return filteredItems
    }
}

class AndCondition<T,
    CondA: Condition,
    CondB: Condition> : Condition
    where T == CondA.T, T == CondB.T
{
    
    let first: CondA
    let second: CondB
    init(_ first: CondA, _ second: CondB)
    {
        self.first = first
        self.second = second
    }
    
    func isConditionMet(_ item: T) -> Bool {
        return first.isConditionMet(item) && second.isConditionMet(item)
    }
}

//    print(" Indian Cricketers")
//    let cricketerFilter = CricketerFilter()
//    for item in cricketerFilter.filterByTeam(cricketers, .india){
//        print(" \(item.name) belongs to Indian Team")
//    }
//
//
//    print("-----------------------------------------")


//print(" England Cricketers")
//for item in ocpFilter.filter(cricketers, TeamCondition(.england)){
//    print(" \(item.name) belongs to English Team" )
//}
//
//print("-----------------------------------------")


func main(){
    let dhoni = Cricketer("Dhoni", .india, .batsman)
    let kohli = Cricketer("Kohli",  .india, .batsman)
    let maxi = Cricketer("Maxwell", .australia, .allrounder)
    let smith = Cricketer("Smith", .australia, .batsman)
    let symo = Cricketer("Symonds", .australia, .allrounder)
    let broad = Cricketer("Broad", .england, .bowler)
    let ali  = Cricketer("Ali", .pakistan, .batsman)
    let stokes = Cricketer("Stokes", .england, .allrounder)
    
    let cricketers = [dhoni, kohli, maxi, broad, ali, stokes ,smith, symo]
    
    let ocpFilter = OCPCricketFilter()
    
    print(" Australian Allrounders")
    
    for item in ocpFilter.filter(cricketers, AndCondition(TeamCondition(.australia), RoleCondition(.allrounder))){
        print(" \(item.name) belongs to Australia Team and is an Allrounder" )
    }
}

main()


