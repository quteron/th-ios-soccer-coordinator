import Foundation

extension String {
    func padding(length: Int) -> String {
        return self.padding(toLength: length, withPad: " ", startingAt: 0)
    }
}

/*
 * Dicnionary Keys
 */
let ID_KEY = "id"
let NAME_KEY = "name"
let HEIGHT_KEY = "height"
let EXPERIENCED_KEY = "experienced"
let GUARDIANS_KEY = "guardians"
let TEAM_KEY = "team"
let PRACTICE_TIME_KEY = "practiceTime"

/*
 * Functions
 */

func getId(of player: [String : Any]) -> Int {
    return player[ID_KEY] as! Int
}

func getName(of player: [String : Any]) -> String {
    return player[NAME_KEY] as! String
}

func getHeight(of player: [String : Any]) -> Int {
    return player[HEIGHT_KEY] as! Int
}

func getExperience(of player: [String : Any]) -> Bool {
    return player[EXPERIENCED_KEY] as! Bool
}

func getGuardians(of player: [String : Any]) -> String {
    return player[GUARDIANS_KEY] as! String
}

func getTeam(of player: [String : Any]) -> String {
    return player[TEAM_KEY] as! String
}

func getPracticeTime(of player: [String : Any]) -> String {
    return player[PRACTICE_TIME_KEY] as! String
}

func add(player data: (name: String, height: Int, experienced: Bool, guardians: String), to players: inout [[String : Any]]) {
    let nextId = players.count
    
    var player: [String : Any] = [:]
    player[ID_KEY] = nextId
    player[NAME_KEY] = data.name
    player[HEIGHT_KEY] = data.height
    player[EXPERIENCED_KEY] = data.experienced
    player[GUARDIANS_KEY] = data.guardians
    players.append(player)
}

func add(player: inout [String : Any], toTeam teamName: String, firstPractice: String, players: inout [[String : Any]]) {
    player[TEAM_KEY] = teamName
    player[PRACTICE_TIME_KEY] = firstPractice
    players.append(player)
}

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

func calculatePlayerAverageHeight(for players: [[String : Any]]) -> Double {
    var totalHieght: Double = 0.0
    
    for player in players {
        let height = getHeight(of: player)
        totalHieght += Double(height)
    }
    
    return totalHieght / Double(players.count)
}

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

func print(team players: [[String : Any]], name: String) {
    print("-------------------- \(name) --------------------")
    printColumns("NAME", "HEIGHT", "EXPERIENCE")
    for player in players {
        print(player: player)
    }
    print("-------------------------------------------------")
}

func print(player: [String : Any]) {
    let name = getName(of: player)
    let height = getHeight(of: player)
    let experience = getExperience(of: player)
    printPlayer(name, height, experience)
}

func printPlayer(_ name: String, _ height: Int, _ experience: Bool) {
    printColumns(name, "\(height)", "\(experience)")
}

func printColumns(_ name: String, _ height: String, _ experience: String) {
    print("\(name.padding(length: 20))\(height.padding(length: 10))\(experience.padding(length: 10))")
}

func generate(letters: inout [String], forTeam players: [[String: Any]]) {
    for player in players {
        let letter = generateLetter(forPlayer: player)
        letters.append(letter)
    }
}

func generateLetter(forPlayer player: [String: Any]) -> String {
    return "Dear \(getGuardians(of: player)), \n" +
        "Welcome to the Meverick School Soccer League. " +
        "Your child, \(getName(of: player)), has been accepted to the \(getTeam(of: player)) team. " +
        "The first team practice is on \(getPracticeTime(of: player)). "  +
        "Any parents who are interested in coaching assistant should contact the League Coordinator Peter Peters at pp@ms.com. \n\n" +
        "Peter Peters, the Meverick School Soccer League Coordinator"
}

func print(letters: [String]) {
    for index in 0..<letters.count {
        let letter = letters[index]
        print("#\(index + 1):")
        print(letter)
        print("-------------------------------------------------")
    }
}

/*
 * Constant to store all available players
 */
var players: [[String : Any]] = []
initialize(players: &players)

/*
 * Calculate height deviations from the average player height
 */
let playerHeightDeviations = calculatePlayerHeightDeviations(for: players)

/*
 * Sort players based on the experience and height deviation
 */
players.sort(by: { (p1, p2) -> Bool in
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
})

/*
 * Divide between teams
 */

let TEAM_COUNT = 3

let SHARKS_TEAM_NAME = "Sharks"
let DRAGONS_TEAM_NAME = "Dragons"
let RAPTORS_TEAM_NAME = "Raptors"

let SHARKS_FIRST_PRACTICE = "March 17, 3pm"
let DRAGONS_FIRST_PRACTICE = "March 17, 1pm"
let RAPTORS_FIRST_PRACTICE = "March 18, 1pm"

var teamSharks: [[String : Any]] = []
var teamDragons: [[String : Any]] = []
var teamRaptors: [[String : Any]] = []

var inversedOrder = false
for index in 0..<players.count {
    var player = players[index]
    
    var remainder = (index + 1) % TEAM_COUNT
    let teamIndex: Int
    if inversedOrder && remainder != 2 {
        teamIndex = (remainder + 1) % 2
    } else {
        teamIndex = remainder;
    }
    
    switch teamIndex {
    case 1:
        add(player: &player, toTeam: SHARKS_TEAM_NAME, firstPractice: SHARKS_FIRST_PRACTICE, players: &teamSharks)
    case 2:
        add(player: &player, toTeam: DRAGONS_TEAM_NAME, firstPractice: DRAGONS_FIRST_PRACTICE, players: &teamDragons)
    default:
        add(player: &player, toTeam: RAPTORS_TEAM_NAME, firstPractice: RAPTORS_FIRST_PRACTICE, players: &teamRaptors)
    }
    
    if(remainder == 0) {
        inversedOrder = !inversedOrder
    }
}

/*
 * Print team players
 */

print("\n===================== TEAMS =====================\n")

print(team: teamSharks, name: SHARKS_TEAM_NAME)
print(team: teamDragons, name: DRAGONS_TEAM_NAME)
print(team: teamRaptors, name: RAPTORS_TEAM_NAME)

/*
 * Generate letters to the guardians
 */
var letters: [String] = []
generate(letters: &letters, forTeam: teamSharks)
generate(letters: &letters, forTeam: teamDragons)
generate(letters: &letters, forTeam: teamRaptors)

/*
 * Print letters to the guardians
 */

print("\n==================== LETTERS ====================\n")

print(letters: letters)

