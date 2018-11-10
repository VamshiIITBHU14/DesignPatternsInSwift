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

