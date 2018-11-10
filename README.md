# DesignPatternsInSwift
This repository contains all the code from my book 'Design Patterns in Swift', live at https://www.amazon.com/dp/B07FYXHBKZ. All code written in Swift4. Do give a star if you like the work.

Personally, cricket is something that I understand in and out. I can almost relate anything under the sun to a situation in cricket (okay, that’s a bit of an exaggeration).
So, I decided, instead of using different contexts for each of the design pattern examples, I would be using cricketing terms for all the examples I would be coding. I believe cricket is a very simple game, and even for those who do not follow the game, it should not be a big effort to relate to the cricketing terms.

That’s when I decided instead of just letting the code reside on my Mac, I would put a little more effort to take it to book form. That’s how this book was born, and I am sure your understanding on design patterns will be enhanced by the time you finish coding these examples.

I would suggest you code the examples (not copy-paste, but type each and every line of the code) in your Xcode playground and see the results for yourself. Then imagine a
scenario where you would apply such a design pattern, and code an example for yourself.
I believe that’s how coding is learned. Happy learning!

There are **28 design patterns** divided into **SOLID, Creational, Structural, Behavioral** categories. You can take code from each of the swift files and run in Xcode playground to see the output.

**1) SOLID - Open Closed Principle : **

Definition:

Single responsibility principle says a class should have one, and only one, reason to change. Every class should be responsible for a single part of the functionality, and that responsibility should be entirely encapsulated by the class. This makes your software easier to implement and prevents unexpected side-effects of future changes.

Usage:

Let us design an imaginary operation system for a Cricket tournament. For the sake of simplicity, let us have two major operations. A TeamRegister class which helps for checking-in and checking-out cricketers. A TeamConveyance class which is used to drop the players from hotel to stadium and pick them up from stadium after the match is over.

Every class is assigned its own responsibility and they will be responsible only for that action.

```import UIKit
import Foundation
 
class TeamRegister : CustomStringConvertible{
    
    var teamMembers = [String]()
    var memberCount = 0
    
    func checkInGuest (_ name : String) -> Int{
        
        memberCount += 1
        teamMembers.append("\(memberCount) - \(name)")
        return memberCount - 1
        
    }
    
    func checkOutGuest (_ index : Int) {
        teamMembers.remove(at: index)
    }
    
    var description: String{
        return teamMembers.joined(separator: "\n")
    }
}
```

TeamRegister class conforms to CustomStringConvertible. It has two variables defined, an array named teamMembers of type String and memberCount of type Integer.

We also define two methods. checkInGuest method takes the guest name as parameter of type String and appends the guest to teamMembers array and returns array count.

checkOutGuest takes index of type Integer as parameter and removes the guest from register.

```
class TeamConveyance {
    
    func takePlayersToStadium(_ teamRegister : TeamRegister){
        print("Taking players \n \(teamRegister.description) \n to the Stadium")
    }
    
    func dropPlayersBackAtHotel(){
        print("Dropping all the players back at Hotel")
    } 
}
```

TeamConveyance class has two responsibilites majorly. takePlayersToStadium takes paramter of type TeamRegister and drops all the players at the stadium. dropPlayersBackAtHotel gets back all the players to hotel after the match is over. It is not concerned about anything else.

Let us now write a function called main and see the code in action:

```
func main(){
    let teamRegister = TeamRegister()
    let player1 = teamRegister.checkInGuest("PlayerOne")
    let player2 = teamRegister.checkInGuest("PlayerTwo")
    
    print(teamRegister)
}
 
main()
```

We take an instance of TeamRegister class and check-in few guests passing their names as parameters.
 
Output in the Xcode console:
 
1 - PlayerOne
2 - PlayerTwo

Let us now check-out a guest and add one more guest to the team. Change the main function to :

```
func main(){
    let teamRegister = TeamRegister()
    let player1 = teamRegister.checkInGuest("PlayerOne")
    let player2 = teamRegister.checkInGuest("PlayerTwo")
    
    print(teamRegister)
    
    teamRegister.checkOutGuest(1)
    print("------------------------------------")
    print(teamRegister)
    
    let player3 = teamRegister.checkInGuest("PlayerThree")
 
    print("------------------------------------")
    print(teamRegister)
}
 
main()
```

We checked-out ‘PlayerTwo’ and then checked-in another guest named ‘PlayerThree’.
 
Output in the Xcode console:
 
1 - PlayerOne
2 - PlayerTwo
------------------------------------
1 - PlayerOne
------------------------------------
1 - PlayerOne
3 - PlayerThree

Now change the main method to following:
 
```
func main(){
    let teamRegister = TeamRegister()
    let player1 = teamRegister.checkInGuest("PlayerOne")
    let player2 = teamRegister.checkInGuest("PlayerTwo")
    
    print(teamRegister)
    
    teamRegister.checkOutGuest(1)
    print("------------------------------------")
    print(teamRegister)
    
    let player3 = teamRegister.checkInGuest("PlayerThree")
 
    print("------------------------------------")
    print(teamRegister)
    
    print("------------------------------------")
    let teamBus = TeamConveyance()
    teamBus.takePlayersToStadium(teamRegister)
    
    print("-------Match Over ----------")
    teamBus.dropPlayersBackAtHotel()
}
 
main()
```

We are taking an instance of TeamConveyance to drop players at stadium and get them back at hotel after the match is over.
 
Output in the Xcode console:
 
1 - PlayerOne
2 - PlayerTwo
------------------------------------
1 - PlayerOne
------------------------------------
1 - PlayerOne
3 - PlayerThree
------------------------------------
Taking players 
 1 - PlayerOne
3 - PlayerThree 
 to the Stadium
-------Match Over ----------
Dropping all the players back at Hotel

**2) SOLID - Single Responsibility Principle : **

Definition:

Open closed principle says one should be able to extend a class behavior without modifying it. As Robert C. Martin says, this principle is the foundation for building code that is maintainable and reusable.

Any class following OCP should fulfill two criteria:

Open for extension: This ensures that the class behavior can be extended. In a real world scenario, requirements keep changing and in order for us to be able to accommodate those changes , classes should be open for extension so that they can behave in a new way.

Closed for modification: Code inside the class is written in such a way that no one is allowed to modify the existing code under any circumstances.

Usage:

Let us consider an example where we have an array of cricketers’ profiles where each entity has the name of cricketer, his team and his specialisation as the attributes. Now we want to build a system where the client can apply filters on the data based on different criteria like team , role of the player etc. Let us see how we can use OCP to build this:

```
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
 
```

Enumeration is a data type that allows us to define list of possible values. We define enums for the available names of the teams and roles of the cricketers.

```
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
```

We then define a class called Cricketer which takes three parameters during its initialisation, name of type String, team of type Team and role of type Role.
 
Now assume, one of the client requirements is to provide a filter of cricketers based on their team. 

```
class CricketerFilter{
 
     func filterByTeam(_ cricketers:[Cricketer], _ team:Team) -> [Cricketer]{
        var filteredResults = [Cricketer]()
        for item in cricketers{
            if item.team == team{
                filteredResults.append(item)
            }
        }
        return filteredResults
    }
 
}
```

We write a class called CricketerFilter and define a method filterByTeam to filter the player profiles based on their team. It takes an array of type Cricketer and team of type Team as parameters and returns a filtered array of type Cricketer. 
 
For each cricketer in the given array, we check if his team is same as that of the given team for filter, add him to the filtered array. Let us see this code in action. Add the below code after CricketerFilter class.

```
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
    print(" Indian Cricketers")
    let cricketerFilter = CricketerFilter()
    for item in cricketerFilter.filterByTeam(cricketers, .india){
        print(" \(item.name) belongs to Indian Team")
    }
}
 
main()
```

Output in the Xcode console:
 
 Indian Cricketers
 Dhoni belongs to Indian Team
 Kohli belongs to Indian Team
 
Assume, after a few days, we got a new requirement to be able to filter by role of the cricketer and then to filter by both team and role at once. Our CricketerFilter class would look something like this:

```
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
```

This logic is quite similar to filterByTeam method. Only that, for filterByRole, we check if the player’s role is same as that of given role. For filterByRoleAndTeam method, we use AND statement to check if the given condition is met.
 
But the OCP states that classes should be closed for modification and open for extension. But here we are clearly breaking this principle. Let us see how the same use-case can be served with the help of OCP.

```
//Conditions
protocol Condition{
    associatedtype T
    func isConditionMet(_ item: T) -> Bool
}
```

We begin by defining a protocol called Condition which basically checks if a particular item satisfies some criteria. We have a function called isConditionMet which takes an item of generic type T and returns a boolean indicating whether the item meets the given criteria.

```
protocol Filter
{
    associatedtype T
    func filter<Cond: Condition>(_ items: [T], _ cond: Cond) -> [T]
    where Cond.T == T;
}
```

We then define a protocol named Filter which has a function called filter which takes an array of items of generic type T and a condition of type Condition as parameters and returns the filtered array.
 
We now use the above generic type Filter to write conditions for role and team.

```
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

```

In each of the methods, we write the logic of isConditionMet protocol method to see if the item meets the criteria and return a boolean.

```
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
```

Now we define a brand new filter called OCPCricketFilter, usage of which does not violate OCP. We take items of type Cricketer, check for the condition of type Condition and return the filtered array.
 
Let us now see the code in action. Change the main method to following.

```
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
 
    print(" England Cricketers")
    for item in ocpFilter.filter(cricketers, TeamCondition(.england)){
        print(" \(item.name) belongs to English Team" )
    }
}
```

We take an instance of OCPFilter and just pass the team name parameter to TeamCondition. 
 
Output in the Xcode console:
 
 England Cricketers
 Broad belongs to English Team
 Stokes belongs to English Team
 
In the similar way, without modifying any existing classes, we can extend the OCPCricketFilter class to as many filters as we need. Now we will see how we can write a filter for AND condition ( role and team for example):

```
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
```
This is very much similar to other filters with the only change that it takes two conditions as arguments for its initialisation.
 
Change the main method to below code :

```
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

```

Output in the Xcode console:
 
 Australian Allrounders
 Maxwell belongs to Australia Team and is an Allrounder
 Symonds belongs to Australia Team and is an Allrounder
 
We can write n number of filters without modifying any existing classes but by just extending the Filter class. 


