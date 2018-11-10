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

**3) SOLID - Liskov Substitution Principle (LSP):**

Definition: 

Liskov substitution principle named after Barbara Liskov states that one should always be able to substitute a base type for a subtype. LSP is a way of ensuring that inheritance is used correctly. If a module is using a base class, then the reference to the base class can be replaced with a derived class without affecting the functionality of the module.

Usage:

Let us understand LSP’s usage with a simple example. 

```
import UIKit
import Foundation
 
protocol Cricketer {
    func canBat()
    func canBowl()
    func canField()
}
```

We define a protocol called Cricketer which implements three methods of canBat, canBowl, canField.

```
class AllRounder : Cricketer{
    func canBat() {
        print("I can bat")
    }
    
    func canBowl() {
        print("I can bowl")
    }
    
    func canField() {
        print("I can field")
    }
}
```
We then define a class called AllRounder conforming to Cricketer protocol. An all-rounder in cricket is someone who can bat, bowl and field.

```
class Batsman : Cricketer{
    func canBat() {
        print("I can bat")
    }
    
    func canBowl() {
        print("I cannot bowl")
    }
    
    func canField() {
        print("I can field")
    }
}

```

We then define a class called Batsman conforming to Cricketer protocol. This is violation of LSP as a batsman is a cricketer but cannot use Cricketer protocol because he cannot bowl. Let us now see how we can use LSP in this scenario:

```
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
```
We change the Cricketer protocol and now make the Batsman class conform to Cricketer protocol.

```
class BatsmanWhoCanBowl : Cricketer{
 
    func canBat() {
        print("I can bat")
    }
    
    func canField() {
        print("I can field")
    }
    
    func canBowl() {
        print("I can bowl")
    }
 
}
 
class AllRounder : BatsmanWhoCanBowl{
    
}

```

We then define a new class named BatsmanWhoCanBowl with super class as Cricketer and define the extra method of  canBowl in this class.

**4) SOLID - Interface Segregation Principle (ISP):**

Definition:
 
The only motto of Interface segregation principle is that the clients should not be forced to implement interfaces they don’t use. Client should not have the dependency on the interfaces that they do not use.
 
Usage:
 
Let us assume we are building a screen display for mobile, tablet, desktop interfaces of an app which is used to display live scores of a cricket match.
We will see how this can be achieved without using ISP and then using ISP.
 

```
import UIKit
import Foundation
 
// Before ISP
protocol MatchSummaryDisplay{
    func showLiveScore()
    func showCommentary()
    func showLiveTwitterFeed()
    func showSmartStats()
}
 
```


We define a protocol named MatchSummaryDisplay which has four methods to show live score, commentary, twitter feed about the match and statistics of the players.

```
enum NoScreenEstate : Error
{
    case doesNotShowLiveTwitterFeed
    case doesNotShowSmartStats
}
 
extension NoScreenEstate: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .doesNotShowLiveTwitterFeed:
            return NSLocalizedString("No Screen Estate to show Live Twitter Feed", comment: "Error")
        case .doesNotShowSmartStats:
            return NSLocalizedString("No Screen Estate to show Smart Stats", comment: "Error")
        }
    }
}

```

By default, we want to show live score and commentary on the all types of devices like mobile, tablet, desktop. Showing twitter feed and statistics are optional, depending on the screen estate available on the device. So, we define an enum called NoScreenEstate with two possible cases. We also write an extension to it just to make the error descriptions more clear.

```
class DesktopDisplay:MatchSummaryDisplay{
    func showLiveScore() {
        print("Showing Live Score On Desktop")
    }
    
    func showCommentary() {
        print("Showing Commentary On Desktop")
    }
    
    func showLiveTwitterFeed() {
        print("Showing Live Twitter Feed On Desktop")
    }
    
    func showSmartStats() {
        print("Showing Smart Stats On Desktop")
    }
}
```

We start the interface design by defining a class called DesktopDisplay conforming to MatchSummaryDisplay. A desktop has enough screen space available and we show all the available data to the user.

```
class TabletDisplay:MatchSummaryDisplay{
    func showLiveScore() {
        print("Showing Live Score On Tablet")
    }
    
    func showCommentary() {
        print("Showing Commentary On Tablet")
    }
    
    func showLiveTwitterFeed() {
        print("Showing Live Twitter Feed On Tablet")
    }
    
    func showSmartStats() {
        do{
            let error: Error = NoScreenEstate.doesNotShowSmartStats
            print(error.localizedDescription)
            throw error
        } catch{
            
        }
    }
}
```

 
We then define another class called called TabletDisplay conforming to MatchSummaryDisplay. As the screen size of tablet is less when compared to desktop, we do not show smart stats on iPad display. We throw an error in showSmartStats method.

```
class MobileDisplay:MatchSummaryDisplay{
    func showLiveScore() {
        print("Showing Live Score On Mobile")
    }
    
    func showCommentary() {
        print("Showing Commentary On Mobile")
    }
    
    func showLiveTwitterFeed() {
        do{
            let error: Error = NoScreenEstate.doesNotShowLiveTwitterFeed
            print(error.localizedDescription)
            throw error
        } catch{
            
        }
    }
    
    func showSmartStats() {
        do{
            let error: Error = NoScreenEstate.doesNotShowSmartStats
            print(error.localizedDescription)
            throw error
        } catch{
            
        }
    }
}
```

We then define another class called called MobileDisplay conforming to MatchSummaryDisplay. As the screen size of mobile is small when compared to desktop and tablet, we do not show smart stats and twitter feed on mobile display. We throw an error in showLiveTwitterFeed and showSmartStats methods.
 
As you can see, this approach violates ISP because TabletDisplay and MobileDisplay are forced to implement methods they are not using. Let’s see how we can use ISP in this scenario.

```
//Following ISP
 
protocol LiveScoreDisplay{
    func showLiveScore()
    func showCommentary()
}
 
protocol TwitterFeedDisplay{
    func showLiveTwitterFeed()
}
 
protocol SmartStatsDisplay{
    func showSmartStats()
}
```

Here we define a protocol named LiveScoreDisplay which is mandatory for all the screen sizes of the devices. Then we define different protocols called TwitterFeedDisplay and SmartStatsDisplay so that only the devices with enough screen sizes can conform to required protocols.

```
class ISPMobileDisplay:LiveScoreDisplay{
    func showLiveScore() {
        print("Showing Live Score On Mobile")
    }
    
    func showCommentary() {
        print("Showing Commentary On Mobile")
    }
}
 
```

 
We define a class called ISPMobileDisplay which conforms only to LiveScoreDisplay and we don’t have to force the class to implement any unwanted methods. 

```
class ISPTabletDisplay:LiveScoreDisplay, TwitterFeedDisplay{
    
    func showLiveScore() {
        print("Showing Live Score On Tablet")
    }
    
    func showCommentary() {
        print("Showing Commentary On Tablet")
    }
    
    func showLiveTwitterFeed() {
        print("Showing Live Twitter Feed On Tablet")
    }
    
}
```

We then define a class called ISPTabletDisplay which conforms to TwitterFeedDisplay along with LiveScoreDisplay.
 
We can define desktop interface as follows.

```
class ISPDesktopDisplay:LiveScoreDisplay, TwitterFeedDisplay, SmartStatsDisplay{
    
    func showLiveScore() {
        print("Showing Live Score On Desktop")
    }
    
    func showCommentary() {
        print("Showing Commentary On Desktop")
    }
    
    func showLiveTwitterFeed() {
        print("Showing Live Twitter Feed On Desktop")
    }
    
    func showSmartStats() {
        print("Showing Smart Stats On Desktop")
    }
}
```

We can observe that, in all the above three classes, we are not forcing any class to implement a method that they do not use. We achieved ISP by defining multiple protocols.

**5) SOLID - Dependency Inversion Principle (DIP):**

Definition:
 
In short, Dependency inversion principle says, depend on abstractions, not on concretions. High level modules should not depend upon low level modules. Both should depend upon abstractions.
 
Abstractions should not depend upon details. Details should depend upon abstractions. By depending on higher-level abstractions, we can easily change one instance with another instance in order to change the behavior. DIP increases the reusability and flexibility of our code.
 
Usage:
 
Let us assume we are designing a small system where we want to list all the wickets taken by a bowler in his cricketing career from the database.

```
import Foundation
import UIKit
 
enum WicketsColumn{
    case wicketTakenBy
    case wicketGivenTo
}
 
class Cricketer{
    var name = ""
    
    init(_ name:String){
        self.name = name
    }
    
}
```
We define an enum called WicketsColumn with a list of two possible cases. We then define a class called Cricketer which takes the parameter of name of type String for its initialisation.

```
protocol WicketsTallyBrowser{
    func returnAllWicketsTakenByBowler(_ name:String) -> [Cricketer]
}
```

We define a protocol named WicketsTallyBrowser which has a function to return all the wickets taken by a given bowler as array of type Cricketer.
 
We will now define a class/ a storage which stores relationship between bowlers and batsmen.

```
class WicketsTally : WicketsTallyBrowser { //Low Level
     var wickets = [(Cricketer, WicketsColumn, Cricketer)]()
    
    func addToTally(_ bowler : Cricketer,_ batsman : Cricketer){
        wickets.append((bowler, .wicketTakenBy, batsman))
        wickets.append((batsman, .wicketGivenTo, bowler))
    }
    
    func returnAllWicketsTakenByBowler(_ name: String) -> [Cricketer] {
        return wickets.filter({$0.name == name && $1 == WicketsColumn.wicketTakenBy && $2 != nil})
            .map({$2})
    }
    
}
```

We define a class called WicketsTally conforming to WicketsTallyBrowser protocol. It has a variable called wickets which is an array of tuples where each of the tuples has three attributes, one each of type Cricketer, WicketsColumn and Cricketer in the order.
 
Then we define a method called addToTally which takes parameters of bowler and batsman of type Cricketer. It appends the same to wickets array but with different relationships available from WicketsColumn enum.
 
In the definition of protocol method returnAllWicketsTakenByBowler, we filter the wickets array by comparing first attribute of tuple to the name of given bowler.

```
class PlayerStats{ //High Level
    init(_ wicketsTally : WicketsTally){
        let wickets = wicketsTally.wickets
        for w in wickets where w.0.name == "BrettLee" && w.1 == .wicketTakenBy{
            print("Brett Lee has a wicket of \(w.2.name)")
        }
    }
}
```
We now define a class called PlayerStats where we use the logic written in WicketsTally class to return all the wickets taken by a particular bowler.
 
Let us now write a main method to see this code in action:

```
func main(){
    let bowler = Cricketer("BrettLee")
    let batsman1 = Cricketer("Sachin")
    let batsman2 = Cricketer("Dhoni")
    let batsman3 = Cricketer("Dravid")
    
    let wicketsTally = WicketsTally()
    wicketsTally.addToTally(bowler, batsman1)
    wicketsTally.addToTally(bowler, batsman2)
    wicketsTally.addToTally(bowler, batsman3)
    
    let _ = PlayerStats(wicketsTally)
    
}
```

Output in the Xcode console:
 
Brett Lee has a wicket of Sachin
Brett Lee has a wicket of Dhoni
Brett Lee has a wicket of Dravid

The issue with the above approach is its violation of DIP (it states that the high level modules should not directly depend on low level modules) as our PlayerStats class depends upon wickets array of WicketsTally class. It should be declared as a private variable so that no other class can manipulate the data directly.
 
Let us now change the WicketsTally class this way:

```
class WicketsTally : WicketsTallyBrowser { //Low Level
     private var wickets = [(Cricketer, WicketsColumn, Cricketer)]()
    
    func addToTally(_ bowler : Cricketer,_ batsman : Cricketer){
        wickets.append((bowler, .wicketTakenBy, batsman))
        wickets.append((batsman, .wicketGivenTo, bowler))
    }
    
    func returnAllWicketsTakenByBowler(_ name: String) -> [Cricketer] {
        return wickets.filter({$0.name == name && $1 == WicketsColumn.wicketTakenBy && $2 != nil})
            .map({$2})
    }
    
}
```
Now change the PlayerStats class to:

```
class PlayerStats{ //High Level
    init(_ browser : WicketsTallyBrowser){
        for w in browser.returnAllWicketsTakenByBowler("BrettLee"){
            print("Brett Lee has a wicket of \(w.name)")
        }
    }
}
```
Here we can observe that, instead of directly depending on wickets array from WicketsTally, PlayerStats is dependent on abstraction from WicketsTallyBrowser. Output in the Xcode console remains same but we are now adhering to DIP.

Output in the Xcode console:
 
Brett Lee has a wicket of Sachin
Brett Lee has a wicket of Dhoni
Brett Lee has a wicket of Dravid

**6) Creational - Factories Design Pattern:**

Definition:

Factory Method Pattern is also known as Virtual Constructor. It is a creational design pattern that defines an abstract class for creating objects in super class but allows the subclasses decide which class to instantiate.

Usage:

Assume there is a BowlingMachine which delivers Red Cricket Balls (used for Test Cricket) and White Crikcet Balls (used for Limited Overs Cricket) based on user input.

```
import UIKit
 
protocol CricketBall{
    func hitMe()
}

Any class conforming to CricketBall must implement hitMe method.

class RedBall : CricketBall{
    func hitMe() {
        print("This ball is good for Test Cricket")
    }
}
 
class WhiteBall : CricketBall{
    func hitMe() {
        print("This ball is good for Limited Overs Cricket")
    }
}

```

Let us start defining factories now.

```
protocol CricketBallFactory{
 
    init()
    func deliverTheBall (_ speed : Int) -> CricketBall
}
```
Factories conforming to CricketBallFactory must implement deliverTheBall. We should also give some input like the speed at which we want the ball to be delivered.

Now, moving out of abstract classes creating objects, we start defining subclasses for object creation.

```
class RedBallFactory{
    func deliverTheBall (_ speed : Int) -> CricketBall{
          print("Releasing Red Ball at \(speed) speed")
          return RedBall()
    }
}
 
class WhiteBallFactory{
    func deliverTheBall (_ speed : Int) -> CricketBall{
        print("Releasing White Ball at \(speed) speed")
        return WhiteBall()
    }
}
```
Here we are defining two factories to deliver different colours of balls. We input the speed of the ball and get a red/ white ball in return.

It’s time we go to the machine and give an input to deliver the balls.

```
class BowlingMachine{
    enum AvailableBall : String{ 
        case redBall = "RedBall"
        case whiteBall = "WhiteBall"
        
        static let all = [redBall, whiteBall]
    }
    
    internal var factories = [AvailableBall : CricketBallFactory]()
    internal var namedFactories = [(String, CricketBallFactory)] ()
    
    init() {
        for ball in AvailableBall.all{
            let type = NSClassFromString("FactoryDesignPattern.\(ball.rawValue)Factory")
            let factory = (type as! CricketBallFactory.Type).init()
            factories[ball] = factory
            namedFactories.append((ball.rawValue, factory))
        }
    }
    
    func setTheBall () -> CricketBall{
        for i in 0..<namedFactories.count{
            let tuple = namedFactories[i]
            print("\(i) : \(tuple.0)")
        }
        
        let input = Int(readLine()!)!
        return namedFactories[input].1.deliverTheBall(120)
        
    }
}
```
We define a class called BowlingMachine. We have an enum of available balls with redBall and whiteBall as the options. Then we have an array of all the available balls.
 
We have an internal variable called factories which is a dictionary with key as the AvailableDrink and value as CricketBallFactory. Then we define a variable called namedFactories which is a list of tuples where each entry has the name of the factory and the instance of the factory.

In the initialiser method, we initialise the factory. For each ball in available balls, we get the type from actual class. Then we construct the factory by taking the type and casting it as a CricketBallFactory and initialising it. Then we append each factory to the array of factories.
 
We then define a function which asks us to set the ball and returns a cricket ball. For each factory , we print out the index and the name of the factory. Then based on the input entered by the user, we return cricketBall at given speed.
 
Let’s now define a function called main and see the code in action.

```
func main(){
    let bowlingMachine = BowlingMachine()
    print(bowlingMachine.namedFactories.count)
    let ball = bowlingMachine.setTheBall()
    ball.hitMe()
}
 
main()
```

Here we initialise the BowlingMachine and set the ball. Then we call the hitMe method on the instance of each ball the user inputs.

Output in the Xcode console:
 
2
AvailableBalls
0 : RedBall
1: WhiteBall
 
If we choose 0, we print ‘Releasing Red Ball at 20 speed’.
If we choose 1, we print ‘Releasing White Ball at 20 speed’. 
 
Summary:
 
When you are in a situation where a class does not know what subclasses will be required to create or when a class wants its subclasses specify the objects to be created, go for Factory design pattern.

**7) Creational - Builder Design Pattern :**

Definition:
 
Builder is a creational design pattern that helps in piecewise construction of  complex objects avoiding too many initializer arguments. It lets us produce different types and representations of an object using the same process of building.
 
This pattern majorly involves three types. 
 
Product - complex object to be created
Builder - handles the creation of product
Director - accepts inputs and coordinates with the builder
 
Usage:

Let us assume we are creating a cricket team which consists of a captain, batsmen and bowlers. We will see how we can use builder pattern in this context. 

We start with the Product part first.

```
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
```
We first define CricketTeam, which has properties for captain, batsmen and bowlers. Once a team is set, we shouldn’t be able to change its composition. We also make CricketTeam conform to CustomStringConvertible.

```
public enum Captain : String{
    case Dhoni
    case Kohli
    case Rahane
}
```
We declare Captain as enum. Each team can have only one captain.

```
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
```

We define Batsmen and Bowlers as OptionSet. This allows us to try different combination of batsmen together. Like a team with two topOrderBatsman, one middleOrderBatsman. Same with Bowlers where we can choose a combination of fastBowler, mediumPaceBowler and a spin bowler for the team.

Add the following code to make Builder.

```
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
```

We declare properties for captain, batsmen, bowlers. These are declared as var so that we can change the team’s composition based on the requirement. We are using private(set) for each to ensure only CricketTeamBuilder can set them directly. 

Since each property is declared private, we need to provide public methods to change them. We defined methods like addBatsman, removeBatsman, addBowler, removeBowler etc for the purpose of building team.

We have an interesting thing to note here. Every team by default should have a captain. Assume, you are starting a team with Dhoni as captain. What if some other team tries to choose Dhoni as captain too? We should throw some error using the array of soldOutCaptains. We check the availability of the captains via isAvailable method.

We are done with the Builder. Now, let’s build our Director.

```
//MARK: -Director/ Maker
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
```

We have a class called TeamOwner who builds their teams from the available options. Each team is built taking an instance of CricketTeamBuilder, picking up a captain and arrays of different types of batsman and bowlers.

Now, let’s define a function called main to see the code in action.

```
func main(){
    let owner = TeamOwner()
    if let team = try? owner.createTeam1(){
        print("Hello! " + team.description)
    }
  
}
 
main()
```

We try to use method createTeam1 with captain as Kohli. 

Output in the Xcode console:

Hello! Team with captain Kohli

Now, change the main() to following:

```
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

```

After Team1, we are trying to create  a Team2 with the help of createTeam2() with Dhoni as captain. But Dhoni is already taken and we throw the error. 

Output in the Xcode console:

Hello! Team with captain Kohli
Sorry! Captain already taken


Summary:

If you are trying to use the same code for building different products to isolate the complex construction code from business logic ,Builder design pattern fits the best.

Also be careful that when your product does not require multiple parameters for initialisation or construction, it’s advised to stay away from Builder pattern.

**8) Creational - Prototype Design Pattern:**

Definition:

Prototype is a creational design pattern used in situations which lets us produce new objects, that are almost similar state or differs little. A prototype is basically a template of any object before the actual object is constructed. The Prototype pattern delegates cloning process to objects themselves.

Usage:

Let us consider a simple use case where we want to create the profile of two cricketers which includes their name, and a custom profile which includes runs scored and wickets taken. 

```
import UIKit
 
class Profile : CustomStringConvertible{
    var runsScored : Int
    var wicketsTaken : Int
    
    init(_ runsScored : Int, _ wicketsTaken : Int) {
        self.runsScored = runsScored
        self.wicketsTaken = wicketsTaken
    }
    
    var description: String{
        return "\(runsScored) Runs Scored & \(wicketsTaken) Wickets Taken"
    }
}

```

First, we create a Profile class which conforms to CustomStringConvertible. It has two properties runsScored and wicketsTaken of type int. It takes the same parameters during its initialisation.

Then we define a Cricketer class conforms to CustomStringConvertible. It has two properties, name of type String and profile of custom type Profile which we just created.

```
class Cricketer : CustomStringConvertible {
    var name : String
    var profile : Profile
    
    init(_ name :String , _ profile : Profile) {
        self.name = name
        self.profile = profile
    }
    var description: String{
        return "\(name) : Profile : \(profile)"
    }
    
}
```

Let us now write a function called main to see the things in action.

```
func main (){
    let profile = Profile(1200, 123)
    let bhuvi = Cricketer("Bhuvi", profile)
    print(bhuvi.description)
}
 
main()
```

It prints 

Bhuvi : Profile : 1200 Runs Scored & 123 Wickets Taken in the Xcode console.

Now we need to talk about copying the objects.

Just before print statement in the main function, add the following lines .

```
var ishant = bhuvi
ishant.name = "Ishant"
print(ishant.description)
 ```
 It prints
Ishant : Profile : 1200 Runs Scored & 123 Wickets Taken
Ishant : Profile : 1200 Runs Scored & 123 Wickets Taken
 
in the Xcode console.
 
This is because we are only copying the references. 
 
Now add this line just before printing ishant’s description.

```ishant.profile.runsScored = 600```

It prints
Ishant : Profile : 600 Runs Scored & 123 Wickets Taken
Ishant : Profile : 600 Runs Scored & 123 Wickets Taken
 
in the Xcode console.
 
Now, we need to make sure bhuvi and ishant actually refer to different objects. 
 
Here, we use the concept of Deep Copy. When we deep copy objects, the system will copy references and each copied reference will be pointing to its own copied memory object. Let us now see how to implement Deep Copy interface for our use case.

```
protocol DeepCopy{
    func createDeepCopy () -> Self
}

```

First, we create a DeepCopy protocol which defines a function called createDeepCopy returning self.
 
Then make the classes Profile and Cricketer conform to DeepCopy protocol. Classes now look like:

```
class Profile : CustomStringConvertible, DeepCopy{
    var runsScored : Int
    var wicketsTaken : Int
    
    init(_ runsScored : Int, _ wicketsTaken : Int) {
        self.runsScored = runsScored
        self.wicketsTaken = wicketsTaken
    }
    
    var description: String{
        return "\(runsScored) Runs Scored & \(wicketsTaken) Wickets Taken"
    }
    
    func createDeepCopy() -> Self {
        return deepCopyImplementation()
    }
    
    private func deepCopyImplementation <T> () -> T{
        return Profile(runsScored, wicketsTaken) as! T
    }
}
```

We have a private method called deepCopyImplementation which is generic and and able to figure out the type correctly. It has a type parameter ‘T’ which is actually going to be inferred (we don’t provide this type parameter anywhere) and a return type of ‘T’. We return a Profile objects and force cast it to T.
 
Cricketer class now looks like:

```
class Cricketer : CustomStringConvertible ,DeepCopy{
    var name : String
    var profile : Profile
    
    init(_ name :String , _ profile : Profile) {
        self.name = name
        self.profile = profile
    }
    
    var description: String{
        return "\(name) : Profile : \(profile)"
    }
    
    func createDeepCopy() -> Self {
        return deepCopyImplementation()
    }
    
    private func deepCopyImplementation <T> () -> T{
        return Cricketer(name, profile) as! T
    }
    
}
```
Let us define our main method as below and see the results:

```
func main(){
    let profile = Profile(1200, 123)
    let bhuvi = Cricketer("Bhuvi", profile)
    let ishant = bhuvi.createDeepCopy()
    ishant.name = "Ishant"
    ishant.profile = bhuvi.profile.createDeepCopy()
    ishant.profile.wicketsTaken = 140
    print(bhuvi.description)
    print(ishant.description)
}
 
main()
```

Output in the Xcode console:
 
Bhuvi : Profile : 1200 Runs Scored & 123 Wickets Taken
Ishant : Profile : 1200 Runs Scored & 140 Wickets Taken
 
We can see that bhuvi and ishant are two different objects now and this is how deep copy is implemented.
 
Summary:
 
When you are in a situation to clone objects without coupling to their concrete classes, you can opt for Prototype design pattern which also helps in reducing repetitive initialization code.

**9) Creational - Singleton Design Pattern:**

When discussing which patterns to drop, we found that we still love them all (Not really - I am in favour of dropping Singleton. Its usage is almost always a design smell) - Erich Gamma (one of the Gang Four)

Design pattern everyone loves to hate. Is it because it is actually bad or is it because of its abuse by the developers? Let’s see.

Definition:

Singleton is a creational design pattern that provides us with one of the best ways to create an object. This pattern ensures a class has only one instance and provides a global access to it so that the object can be used by all the other classes.

Usage:

Let us take the case of an API which returns some JSON response which when parsed looks like this:

["Sachin" : 1, "Sehwag" : 2 , "Dravid" : 3, "Kohli" : 4, "Yuvraj" : 5 ,"Dhoni" : 6 ,"Jadeja" : 7 ,"Ashwin" : 8, "Zaheer" : 9 ,"Bhuvi" : 10, "Bumrah" : 11]

This data-structure is an Array where each object is a key-value pair. Key represents the name of Indian Cricketer and Value represents the position at which the cricketer bats.

We would need only one instance of the SingletonDatabase class in order to save this data to our database. There is no point in initialising database class more than once as it would just waste memory. Our code looks like this:

```
import UIKit
class SingletonDatabase{
    var dataSource = ["Sachin" : 1, "Sehwag" : 2 , "Dravid" : 3, "Kohli" : 4, "Yuvraj" : 5   ,"Dhoni" : 6 ,"Jadeja" : 7 ,"Ashwin" : 8, "Zaheer" : 9 ,"Bhuvi" : 10, "Bumrah" : 11]
 
    var cricketers = [String:Int]()
 
    static let instance = SingletonDatabase()
    static var instanceCount = 0
 
    private init(){
        print("Initialising the singleton")
        type(of: self).instanceCount += 1
        for dataElement in dataSource{
             cricketers[dataElement.key] = dataElement.value
        }
    }
 
}
```

We first make a private initialiser which does not take any arguments. And that’s the like the simplest way to create on object. As it is private, no one can make another instance of the class.
 
But how do we let someone access the SingletonDatabase? That’s where the Singleton pattern comes to play.
 
We initialise a static variable with the only instance of SingletonDatabase class. Making it static restricts the ability to create multiple instances of class. 
 
Now we add the data coming from API call to our array of cricketers. That’s it! We have our database ready.
 
Now, how does someone have access to this database? Assume we want to know the position at which a cricketer bats. We write a function for that just after the private init() method in SingletonDatabase class.

```
func getRunsScoredByCricketer(name:String) -> Int{
        if let position = cricketers[name]{
            print("\(name) bats at number \(position) for Indian Crikcet Team")
            return cricketers[name]!
        }
 
       print("Cricketer with name \(name) not found")
       return 0
}
```
This method is straightforward which takes name of the cricketer as an argument and returns his position in the line-up.
 
Inorder for us to access this class at some point in our code, we write it this way:

```
func main(){
    let singleton = SingletonDatabase.instance
    singleton.getRunsScoredByCricketer(name: "Sachin")
}
```

Very simple and short. We create a variable named singleton which helps us in accessing all the functions in our SingletonDatabase class. 
 
Now run the main() method.

```main()```

Output in the Xcode console:

Initialising the singleton
Sachin bats at number 1 for Indian Cricket Team

Change the name parameter to “Sach” and the output is:

Initialising the singleton
Cricketer with name Sach not found

We missed out discussing variable named instanceCount in our private init() method. We can use this variable to show that there is only one instance of the SingletonDatabase class.
 
 
Change the main method this way.

```
func main(){
    let singleton1 = SingletonDatabase.instance
    print(SingletonDatabase.instanceCount)
    
    let singleton2 = SingletonDatabase.instance
    print(SingletonDatabase.instanceCount)
 
}
```

Output in the Xcode console:

Initialising the singleton
1
1

Instance count remains 1 even though we initialised the class more than once. 

Adding the code snippet for another self explanatory example here which would enhance your understanding:

```
import UIKit
 
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
 
```

Output in the Xcode console:
 
Dhoni has got a rating of 7
Dhoni has got a rating of 7

Summary:
 
We should use Singleton pattern only when we have a scenario forcing us to use a single instance of an object at multiple places. 


**10) Structural - Adapter Design Pattern:**
Definition:
 
Adapter is a structural design pattern converts the interface of a class into another interface clients expect. This lets classes with incompatible interfaces to collaborate.
 
Usage:

Suppose you have a TestBatsman class with fieldWell() and makeRuns()methods. And also a T20Batsman class with batAggressively() method.

Let’s assume that you are short on T20Batsman objects and you would like to use TestBatsman objects in their place. TestBatsmen have some similar functionality but implement a different interface (they can bat but cannot bat in the way needed for a T20 match), so we can’t use them directly. 

So we will use adapter pattern. Here our client would be T20Batsman and adaptee would be TestBatsman. 

Let us now write code:

```
import UIKit
 
protocol TestBatsman {
    func makeRuns()
    func fieldWell()
}
```

A simple protocol named TestBatsman defining two methods, makeRuns and fieldWell.

```
class Batsman1 : TestBatsman{
    func makeRuns() {
        print("I can bat well but only at StrikeRate of 80")
    }
    
    func fieldWell() {
        print("I can field well")
    }
}
```

We define a Batsman1 class conforming to TestBatsman protocol. This type of batsman can make runs at a strike rate of 80.
```
protocol T20Batsman{
    func batAggressively()
}
```

We have one more protocol named T20Batsman which defines batAggressively method.
```
class Batsman2 : T20Batsman{
    func batAggressively() {
         print("I need to bat well at a StrikeRate of more than 130")
    }
}
```

We define a Batsman2 class conforming to T20Batsman protocol. This type of batsman can make runs at a strike rate of 130.
 
Now considering our situation, we need to make an adapter in such a way that TestBatsman can fit to be a T20Batsman.

```
class TestBatsmanAdapter : T20Batsman{
    let testBatsman : TestBatsman
    init (_ testBatsman : TestBatsman){
        self.testBatsman = testBatsman
    }
    
    func batAggressively() {
        testBatsman.makeRuns()
    }
}
```
 
We write a class named TestBatsmanAdapter whose superclass is T20Batsman. It has a property of type TestBatsman and it takes an object of type TestBatsman for its initialisation. It is this object which we make adaptable to batAggressively method by calling makeRuns method.
 
 
Output in the Xcode console:
 
Test Batsman
I can field well
I can bat well but only at StrikeRate of 80
T20 Batsman
I need to bat well at a StrikeRate of more than 130
TestBatsmanAdapter
I can bat well but only at StrikeRate of 80
 
Summary:
 
When you are in a situation where you have an object that should be able to do the same task but in lots of different ways and you do not want to expose algorithm's implementation details to other classes, opt for Adapter design pattern.
 
  
**11) Structural - Bridge Design Pattern:**

Definition:
Bridge is a structural design pattern which lets us connect components together through abstraction.It enables the separation of implementation hierarchy from interface hierarchy and improves the extensibility.
Usage:
Let us suppose that we have a protocol named Batsman whose main function is to make runs for his team.

```
import Foundation
import UIKit
 
protocol Batsman
{
    func makeRuns(_ numberOfBalls: Int)
}
```

makeRuns takes a parameter named numberOfBalls of type Int. 
Let us now define three different classes of batsmen conforming to Batsman protocol.

```
class TestBatsman : Batsman
{
    func makeRuns(_ numberOfBalls: Int) {
        print("I am a Test Batsman and I score \(0.6 * Double(numberOfBalls)) runs in \(numberOfBalls) balls")
    }
}
 
class ODIBatsman : Batsman
{
    func makeRuns(_ numberOfBalls: Int) {
        print("I am a ODI Batsman and I score \(1 * Double(numberOfBalls)) runs in \(numberOfBalls) balls")
    }
}
 
class T20IBatsman : Batsman
{
    func makeRuns(_ numberOfBalls: Int) {
        print("I am a T20 Batsman and I score \(1.4 * Double(numberOfBalls)) runs in \(numberOfBalls) balls")
    }
}

```

We have three types of batsmen with the only difference between them being the number of runs they score in a given number of balls.

Let us now define a protocol Player whose main function is to play.

```
protocol Player
{
    func play()
}
```
We now define a Cricketer class conforming to Player protocol.
```
class Cricketer : Player
{
    var numberOfBalls: Int
    var batsman: Batsman
    
    init(_ batsman: Batsman, _ numberOfBalls: Int)
    {
        self.batsman = batsman
        self.numberOfBalls = numberOfBalls
    }
    
    func play() {
        batsman.makeRuns(numberOfBalls)
    }
   
}
```

Cricketer class takes two parameters, one of type Batsman and the other of type Int during its initialisation. This is where we are bridging between Batsman class and Player class by calling makeRuns method of batsman in the play method.

Let us now define our main function and see how this design pattern works.

```
func main()
{
    let testBatsman = TestBatsman()
    let odiBatsman = ODIBatsman()
    let t20Batsman = T20IBatsman()
    
    let cricketer1 = Cricketer(testBatsman, 20)
    let cricketer2 = Cricketer(odiBatsman, 20)
    let cricketer3 = Cricketer(t20Batsman, 20)
    
    cricketer1.play()
    cricketer2.play()
    cricketer3.play()
    
}
 
main()
```

Output in the Xcode console:

I am a Test Batsman and I score 12.0 runs in 20 balls
I am a ODI Batsman and I score 20.0 runs in 20 balls
I am a T20 Batsman and I score 28.0 runs in 20 balls

Summary:

When you are in a situation where you have to change the implementation object inside the abstraction and when you need to extend a class in several independent dimensions, Bridge design pattern serves the best.

**12) Structural - Composite Design Pattern:**

Definition:

Composite is a structural design pattern that lets us compose objects into tree structures and allows clients to work with these structures as if they were individual objects. Composition lets us make compound objects.

Usage:

Assume we are building a tree structure of a cricket team where each entity contains name, role, grade of contract as attributes. Let’s see how we can use composite design pattern to build such system.

```
import UIKit
import Foundation
 
class CricketTeamMember : CustomStringConvertible{
    
    var name : String
    var role : String
    var grade : String
    var teamMembers : [CricketTeamMember]
    
    init(name:String, role : String, grade : String) {
        self.name = name
        self.role = role
        self.grade = grade
        self.teamMembers = [CricketTeamMember]()
    }
    
    func addMember(member : CricketTeamMember){
        teamMembers.append(member)
    }
    
    func removeMember(member : CricketTeamMember){
        teamMembers.append(member)
    }
    
    func getListOfTeamMembers() -> [CricketTeamMember]{
        return teamMembers
    }
    var description: String
    {
        let demo = "\(name)  \(role) \(grade)"
        return demo
        
    }
}
```
Let’s start with defining a class called CricketTeamMember conforming to CustomStringConvertible. It has got four properties like name of type string, role of type string, grade of type string and an array of teamMembers of type CricketTeamMember. It takes three parameters, namely name, role, grade of type String for its initialisation.

We define a function called addMember which takes a CricketTeamMember object as parameter and appends it to the teamMembers array.

We have a function named removeMember which takes a CricketTeamMember object as parameter and removes it from  teamMembers array.

We have another function called getListOfTeamMembers which returns list of team members.

Let us now define main function and see how the composite pattern can be used to define a tree structure.

```
func main(){
 
//1
 
    let headCoach = CricketTeamMember(name: "HeadCoach", role: "HeadCoach", grade: "A")
    let captain = CricketTeamMember(name: "TeamCaptain", role: "Captain", grade: "B")
    let bowlingCoach = CricketTeamMember(name: "BowlingCoach", role: "Coach", grade: "B")
    let battingCoach = CricketTeamMember(name: "BattingCoach", role: "Coach", grade: "B")
    let fieldingCoach = CricketTeamMember(name: "FieldingCoach", role: "Coach", grade: "B")
    let asstBowlingCoach = CricketTeamMember(name: "ABoC1", role: "AsstCoach", grade: "C")
    let asstBattingCoach = CricketTeamMember(name: "ABaC1", role: "AsstCoach", grade: "C")
    let asstFieldingCoach = CricketTeamMember(name: "ABfC1", role: "AsstCoach", grade: "C")
    let teamMember1 = CricketTeamMember(name: "TM1", role: "Player", grade: "B")
    let teamMember2 = CricketTeamMember(name: "TM2", role: "Player", grade: "B")
    
  //2
 
    headCoach.addMember(member: captain)
    headCoach.addMember(member: bowlingCoach)
    headCoach.addMember(member: battingCoach)
    headCoach.addMember(member: fieldingCoach)
    
    captain.addMember(member: teamMember1)
    captain.addMember(member: teamMember2)
    
    bowlingCoach.addMember(member: asstBowlingCoach)
    battingCoach.addMember(member: asstBattingCoach)
    fieldingCoach.addMember(member: asstFieldingCoach)
 
//3
 
    print(headCoach.description)
    for member in headCoach.getListOfTeamMembers(){
        print(member.description)
        for member in member.getListOfTeamMembers(){
             print(member.description)
        }
    }
}
 
main()
```

Let’s read this method step by step now.
 
Here we define different team members using the instance of CricketTeamMember. We can see different roles like HeadCoach, TeamCaptain, BowlingCoach etc.
 
We then start forming trees by adding all the captains and coaches under head coach. Adding team members under team captain etc.
 
Here we start printing the trees. Initially we print the description of HeadCoach and then we loop through all the team members added under him and print their descriptions too.
 
    
Output in the Xcode console:
 
HeadCoach  HeadCoach A
TeamCaptain  Captain B
TM1  Player B
TM2  Player B
BowlingCoach  Coach B
ABoC1  AsstCoach C
BattingCoach  Coach B
ABaC1  AsstCoach C
FieldingCoach  Coach B
ABfC1  AsstCoach C
 
Summary:
 
When you are in a situation to simplify the code at client’s end that has to interact with a complex tree structure, then go for Composite design pattern. In other words, it should be used when clients need to ignore the difference between compositions of objects and individual objects.

**13) Structural - Decorator Design Pattern:**

Definition:

Decorator is a structural design pattern lets us add new behavior to the objects without altering the class itself. It helps us in keeping the new functionalities separate without having to rewrite existing code.

Usage:

Assume we are checking if a player is fit for playing T20 game of cricket as a bowler or batsman or both or none based on his batting and bowling statistics. Let us see how Decorator design pattern can help us here.
```
import UIKit
import Foundation
 
class T20Batsman{
    
    var strikeRate : Int = 0
    
    func makeRuns() -> String{
        return (strikeRate > 130) ? "Fit for T20 Team as Batsman" : "Too slow Batsman for T20 Team"
    }
    
}
```
We write a class called T20Batsman with a property called strikeRate of type Int. It has a function defined called makeRuns which tells us if the batsman is fit for T20 team based on his strikeRate. If the strike rate is more than 130, he is fit as T20 batsman, else he is too slow for the game.

```
class T20Bolwer{
    
    var economyRate : Float = 0
    
    func bowlEconomically () -> String{
        return (economyRate < 8.0) ? "Fit for T20 Team as Bowler" : "Too expensive as a Bowler"
    }
    
}
```

We then define a class called T20Bolwer with a property called economyRate of type Float. It has a function defined called bowlEconomically which tells us if the bowler is fit for T20 team based on his economyRate. If the economy rate is less than 8.0, he is fit as T20 bowler, else he is too expensive as a bowler for the game.
 
```
class T20AllRounder : CustomStringConvertible{
    private var _strikeRate : Int = 0
    private var _economyRate : Float = 0
    
    private let t20Batsman = T20Batsman()
    private let t20Bowler = T20Bolwer()
    
    
    func makeRuns() -> String{
        return t20Batsman.makeRuns()
    }
    
    func bowlEconomically() -> String{
        return t20Bowler.bowlEconomically()
    }
    
    var strikeRate : Int{
        get {return _strikeRate}
        set(value){
            t20Batsman.strikeRate = value
            _strikeRate = value
        }
    }
    
    var economyRate : Float{
        get {return _economyRate}
        set(value){
            t20Bowler.economyRate = value
            _economyRate = value
        }
    }
    
    var description: String{
        if t20Batsman.strikeRate > 130 && t20Bowler.economyRate < 8 {
            return "Fit as T20 AllRounder"
        }
        else{
        var buffer = ""
        buffer += t20Batsman.makeRuns()
        buffer += " & " + t20Bowler.bowlEconomically()
        return buffer
        }
    }
}
```

We now define a class for T20AllRounder conforming to CustomStringConvertible. All rounder is someone in cricket who can bat and bowl reasonably good. It has got four private variables strikeRate and economyRate of type Int and Float respectively. Two more variables of type T20Batsman and T20Bowler.
 
Now this allrounder should be able to make runs and bowl well. So it has got two functions defined:
 
makeRuns: Here we use the instance of T20Batsman variable to call the makeRuns method and see if he is fit as T20Batsman based on defined criteria for strike rate
 
bowlEconomically: Here we use the instance of T20Bowler variable to call the bowlEconomically method and see if he is fit as T20Bowler based on defined criteria for economy rate.
  
In case, in future if we want to change the conditions for batsmen or bowler or both, we do not have to disturb the code written for allrounder class. Just changing the code in T20Batsman and T20Bowler classes will be enough.
 
Let us now write a main function to see the code in action:

```
func main(){
    
    let t20AllRounder = T20AllRounder()
    t20AllRounder.strikeRate = 120
    t20AllRounder.economyRate = 7
    print(t20AllRounder.description)
 
}
 
main()
```

We take an instance of T20AllRounder class and feed in the strikeRate and economyRate and see if certain player is fit or not.
 
Output in the Xcode console:
 
Too slow Batsman for T20 Team & Fit for T20 Team as Bowler
 
Keep changing the inputs for strikeRate and economyRate and see if the player is fit for T20 game of cricket.

```t20AllRounder.strikeRate = 150
t20AllRounder.economyRate = 7
```
 
Prints : Fit as T20 AllRounder
 
```
t20AllRounder.strikeRate = 150
t20AllRounder.economyRate = 9
```
 
Prints: Fit for T20 Team as Batsman & Too expensive as a Bowler
 
```
t20AllRounder.strikeRate = 120
t20AllRounder.economyRate = 9
```
 
Prints: Too slow Batsman for T20 Team & Too expensive as a Bowler
 
Summary:
 
If you are in a situation where you are looking for something flexible than class inheritance and need to edit/ update behaviors at runtime, then Decorator design pattern serves you better.



