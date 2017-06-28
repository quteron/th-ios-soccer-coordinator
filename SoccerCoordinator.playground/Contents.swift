/***************************************************************************************************
 * PART 0: Imports, extensions.
 ***************************************************************************************************/
 
/*
 * Import 'padding' function for String instances
 */
import Foundation

/*
 * Extensions for String functions
 */
extension String {
    /*
     * Add spaces on the right to meet the required length of the string
     */
    func padding(length: Int) -> String {
        return self.padding(toLength: length, withPad: " ", startingAt: 0)
    }
}

/***************************************************************************************************
 * PART 1: Сhoose an appropriate data type to store the information for each player.
 ***************************************************************************************************/

/*
 * Constant to store all available players
 */
var players: [[String : Any]] = []

/*
 * Keys to retrieve values from the dictionary with player's properties
 */
let kId = "id"
let kName = "name"
let kHeight = "height"
let kExperience = "experience"
let kGuardians = "guardians"
let kTeam = "team"
let kTeamPractice = "teamPractice"

/*
 * Getter functions to retrieve correctly typed values from the dictionary with player's properties
 */

func getId(of player: [String : Any]) -> Int {
    return player[kId] as! Int
}

func getName(of player: [String : Any]) -> String {
    return player[kName] as! String
}

func getHeight(of player: [String : Any]) -> Int {
    return player[kHeight] as! Int
}

func getExperience(of player: [String : Any]) -> Bool {
    return player[kExperience] as! Bool
}

func getGuardians(of player: [String : Any]) -> String {
    return player[kGuardians] as! String
}

func getTeam(of player: [String : Any]) -> String {
    return player[kTeam] as! String
}

func getteamPractice(of player: [String : Any]) -> String {
    return player[kTeamPractice] as! String
}

/*
 * Add player's data to the array with players
 */
func add(player data: (name: String, height: Int, experienced: Bool, guardians: String), to players: inout [[String : Any]]) {
    let nextId = players.count
    
    var player: [String : Any] = [:]
    player[kId] = nextId
    player[kName] = data.name
    player[kHeight] = data.height
    player[kExperience] = data.experienced
    player[kGuardians] = data.guardians
    players.append(player)
}

/*
 * Initialize the array with players
 */
func initialize(players: inout [[String : Any]]) {
    add(player: ("Joe Smith", 42, true, "Jim and Jan Smith"), to: &players)
    add(player: ("Jill Tanner", 36, true, "Clara Tanner"), to: &players)
    add(player: ("Bill Bon", 43, true, "Sara and Jenny Bon"), to: &players)
    add(player: ("Eva Gordon", 45, false, "Wendy and Mike Gordon"), to: &players)
    add(player: ("Matt Gill", 40, false, "Charles and Sylvia Gill"), to: &players)
    add(player: ("Kimmy Stein", 41, false, "Bill and Hillary Stein"), to: &players)
    add(player: ("Sammy Adams", 45, false, "Jeff Adams"), to: &players)
    add(player: ("Karl Saygan", 42, true, "Heather Bledsoe"), to: &players)
    add(player: ("Suzane Greenberg", 44, true, "Henrietta Dumas"), to: &players)
    add(player: ("Sal Dali", 41, false, "Gala Dali"), to: &players)
    add(player: ("Joe Kavalier", 39, false, "Sam and Elaine Kavalier"), to: &players)
    add(player: ("Ben Finkelstein", 44, false, "Aaron and Jill Finkelstein"), to: &players)
    add(player: ("Diego Soto", 41, true, "Robin and Sarika Soto"), to: &players)
    add(player: ("Chloe Alaska", 47, false, "David and Jamie Alaska"), to: &players)
    add(player: ("Arnold Willis", 43, false, "Claire Willis"), to: &players)
    add(player: ("Phillip Helm", 44, true, "Thomas Helm and Eva Jones"), to: &players)
    add(player: ("Les Clay", 42, true, "Wynonna Brown"), to: &players)
    add(player: ("Herschel Krustofski", 45, true, "Hyman and Rachel Krustofski"), to: &players)
}

/*
 * Initialize 'players' array with data
 */
initialize(players: &players)

/***************************************************************************************************
 * PART 2: Iterate through all players and assign them to teams such that the number of experienced 
 *         players on each team are the same.
 *         Ensure that each team's average height is within 1.5 inch of the others as well as having 
 *         each team contain the same number of experienced players.
 ***************************************************************************************************/
let teamCount = 3

let teamNameSharks = "Sharks"
let teamNameDragons = "Dragons"
let teamNameRaptors = "Raptors"

let teamPracticeSharks = "March 17, 3pm"
let teamPracticeDragons = "March 17, 1pm"
let teamPracticeRaptors = "March 18, 1pm"

var teamSharks: [[String : Any]] = []
var teamDragons: [[String : Any]] = []
var teamRaptors: [[String : Any]] = []

/*
 * Calculate the average height of passed players in the array
 */
func calculatePlayerAverageHeight(for players: [[String : Any]]) -> Double {
    var totalHieght: Double = 0.0
    
    for player in players {
        let height = getHeight(of: player)
        totalHieght += Double(height)
    }
    
    return totalHieght / Double(players.count)
}

/*
 * Calculate height deviation from the average height for each player
 */
func calculatePlayerHeightDeviations(for players: [[String : Any]]) -> [Int : Double] {
    let playerAvgHeight = calculatePlayerAverageHeight(for: players)
    
    var deviations: [Int : Double] = [:]
    
    for player in players {
        let id = getId(of: player)
        let height = getHeight(of: player)
        let deviation = Double(height) - playerAvgHeight
        deviations.updateValue(deviation, forKey: id)
    }
    
    return deviations
}

/*
 * Add the passed player to the specified team, update player's property to store team name and first practice date/time
 */
func add(player: inout [String : Any], toTeam teamName: String, teamPractice: String, players: inout [[String : Any]]) {
    player[kTeam] = teamName
    player[kTeamPractice] = teamPractice
    players.append(player)
}

/*
* Sort players based on the experience and height deviation
*/
func sortPlayers(p1: [String : Any], p2: [String : Any]) -> Bool {
    let e1 = getExperience(of: p1)
    let e2 = getExperience(of: p2)
    
    if e1 && !e2 {
        return true
    } else if !e1 && e2 {
        return false
    } else if e1 == e2 {
        let i1 = getId(of: p1)
        let i2 = getId(of: p2)
        
        let d1 = playerHeightDeviations[i1]!
        let d2 = playerHeightDeviations[i2]!
        
        return d1 > d2
    }
    
    return false
}

/*
 * Calculate team index for the passed player id
 */
func calculateTeamIndex(forPlayer index: Int, teamCount: Int) -> Int {
    let remainder = (index + 1) % teamCount
    let back = (index / 3) % 2 == 1
    
    if back && remainder != 2 {
        return (remainder + 1) % 2
    } else {
        return remainder;
    }
}

/*
 * Calculate height deviations from the average player height
 */
let playerHeightDeviations = calculatePlayerHeightDeviations(for: players)

/*
 * Sort players based on the experience and height deviation
 */
players.sort(by: sortPlayers)

/*
 * Divide players between teams
 */
for index in 0..<players.count {
    var player = players[index]
    
    let teamIndex = calculateTeamIndex(forPlayer: index, teamCount: teamCount)
    switch teamIndex {
        case 1:
            add(player: &player, toTeam: teamNameSharks, teamPractice: teamPracticeSharks, players: &teamSharks)
        case 2:
            add(player: &player, toTeam: teamNameDragons, teamPractice: teamPracticeDragons, players: &teamDragons)
        default:
            add(player: &player, toTeam: teamNameRaptors, teamPractice: teamPracticeRaptors, players: &teamRaptors)
    }
}

/***************************************************************************************************
 * PART 3: Iterate through all three teams of players and generates a personalized letter to the
 *         guardians, letting them know which team the child has been placed on and when they should 
 *         attend their first team team practice.
***************************************************************************************************/

/*
 * Constant to store letters to the guardians
 */
var letters: [String] = []


/*
 * Generate letters to the guardians of the passed team players
 */
func generate(letters: inout [String], forTeam players: [[String: Any]]) {
    for player in players {
        let letter = generateLetter(forPlayer: player)
        letters.append(letter)
    }
}

/*
 * Generate letters to the guardians of the passed player
 */
func generateLetter(forPlayer player: [String: Any]) -> String {
    return "Dear \(getGuardians(of: player)), \n" +
        "Welcome to the Meverick School Soccer League. " +
        "Your child, \(getName(of: player)), has been accepted to the \(getTeam(of: player)) team. " +
        "The first team practice is on \(getteamPractice(of: player)). "  +
        "Any parents who are interested in coaching assistant should contact the League Coordinator Peter Peters at pp@ms.com. \n\n" +
        "Peter Peters, the Meverick School Soccer League Coordinator"
}

/*
 * Generate letters to the guardians
 */
generate(letters: &letters, forTeam: teamSharks)
generate(letters: &letters, forTeam: teamDragons)
generate(letters: &letters, forTeam: teamRaptors)

/***************************************************************************************************
* PART 4: Print all teams with players information and generated letters to the guardians.
 ***************************************************************************************************/

/*
 * Print each team player information
 */
func print(team players: [[String : Any]], name: String) {
    print("-------------------- \(name) --------------------")
    printColumns("NAME", "HEIGHT", "EXPERIENCE")
    for player in players {
        print(player: player)
    }
    print("-------------------------------------------------")
}

/*
 * Print player information
 */
func print(player: [String : Any]) {
    let name = getName(of: player)
    let height = getHeight(of: player)
    let experience = getExperience(of: player)
    printColumns(name, height, experience)
}

/*
 * Print name, height and experience of the player in columns
 */
func printColumns(_ name: String, _ height: Int, _ experience: Bool) {
    printColumns(name, "\(height)", "\(experience)")
}

/*
 * Print name, height and experience of the player in columns
 */
func printColumns(_ name: String, _ height: String, _ experience: String) {
    print("\(name.padding(length: 20))\(height.padding(length: 10))\(experience.padding(length: 10))")
}

/*
 * Print passed letters
 */
func print(letters: [String]) {
    for index in 0..<letters.count {
        let letter = letters[index]
        print("#\(index + 1):")
        print(letter)
        print("-------------------------------------------------")
    }
}

/*
 * Print team players
 */

print("\n===================== TEAMS =====================\n")

print(team: teamSharks, name: teamNameSharks)
print(team: teamDragons, name: teamNameDragons)
print(team: teamRaptors, name: teamNameRaptors)

/*
 * Print letters to the guardians
 */

print("\n==================== LETTERS ====================\n")

print(letters: letters)

