import Cocoa

//: protocol(interface)
//: 1. CustomStringConvertible


class Shoe: CustomStringConvertible {
    let color: String
    let size: Int
    let hasLaces: Bool
    
    var description: String {
        return "\(color) shoe with size \(size)"
    }
    
    init(color: String, size: Int, hasLaces: Bool) {
        self.color = color
        self.size = size
        self.hasLaces = hasLaces
    }
}

let shoe1 = Shoe(color: "Black", size: 10, hasLaces: true)
print(shoe1)

//: 2. Equatable
struct Employee: Equatable, Comparable, Codable {

    var firstName: String
    var lastName: String
    var jobTitle: String
    var phoneNumber: String
    
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.phoneNumber == rhs.phoneNumber
    }
    
    static func < (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.firstName == rhs.firstName
    }
}

struct Company {
    var name: String
    var employee: [Employee]
}

let employee1 = Employee(firstName: "Sean", lastName: "Chien", jobTitle: "MobileDeveloper", phoneNumber: "1234567890")

let employee2 = Employee(firstName: "Kei", lastName: "Chien", jobTitle: "WebDeveloper", phoneNumber: "1234567890")

let employee3 = Employee(firstName: "Mona", lastName: "Chien", jobTitle: "MobileDeveloper", phoneNumber: "1234567890")

let employee4 = Employee(firstName: "Roman", lastName: "Chien", jobTitle: "WebDeveloper", phoneNumber: "1234567890")

let employee5 = Employee(firstName: "Grace", lastName: "Chien", jobTitle: "MobileDeveloper", phoneNumber: "1234567890")


print(employee1 == employee2)


//: 3. Comparable - Sort, Order
var company1 = Company(name: "Facebook", employee: [employee1, employee2, employee3, employee4, employee5])

company1.employee.sort() // Sorts elements in-place
company1.employee.sorted(by: <) // Returns sorted array
print(company1.employee)

//: 4. Cadable(Serialize-Encode or Deserialize-Decode)
let kei = Employee(firstName: "Keisuke", lastName: "Yamashita", jobTitle: "CEO", phoneNumber: "1234567890")

// 1. Create a JSON Encoder object
let jsonEncoder = JSONEncoder()
// 2. using JSON Encoder, you can encode a codable object into JSON format (this returns a Data - a bag of bits)
if let jsonKei = try? jsonEncoder.encode(kei){
    if let jsonKeiString = String(data: jsonKei, encoding: .utf8){
        print(jsonKeiString)
        
        let jsonDeoder = JSONDecoder()
        if let keiObj = try? jsonDeoder.decode(Employee.self, from: jsonKei){
            print(keiObj)
        }
    }
}

struct StarWarsCharacter: Codable,CustomStringConvertible {
    let name: String
    let height: String
    let mass: String
    let skin_color: String
    let birth_year: String
    

    var description: String {
        return "Name: \(name), Height: \(height), Mass: \(mass), SkinColor: \(skin_color), BirthYear: \(birth_year)"
    }
}

let request = URLRequest(url: URL(string: "https://swapi.co/api/people/1/")!)

let session =  URLSession.shared.dataTask(with: request) {
    (data, responce, err) in
    if let err = err {
        print(err.localizedDescription)
    }
    if let data = data {
        do {
            let starWarsObj = try JSONDecoder().decode(StarWarsCharacter.self, from: data)
            print(starWarsObj)
        } catch {
            print(error.localizedDescription)
        }
    }
}
session.resume()

//: 5. Creating your own protocol
protocol FullyNamed{
    var fullName: String { get }
    func sayFullName()
}

struct Person: FullyNamed {
    var firstName: String
    var lastName: String
    
    var fullName: String{
        return firstName + ", " + lastName
    }
    
    func sayFullName() {
        print("My fullname is \(fullName)")
    }
}

struct Employer: FullyNamed {
    var fullName: String{
        return firstName + ", " + lastName
    }
    
    func sayFullName() {
        print("Employer fullName: \(fullName)")
    }
    
    var sinNumber: String
    var firstName: String
    var lastName: String
    var position: String
    var city: String
}

var humans : [FullyNamed] = [
    Person(firstName: "", lastName: ""),
    Employer(sinNumber: "00", firstName: "01", lastName: "02", position: "03", city: "04")
]
