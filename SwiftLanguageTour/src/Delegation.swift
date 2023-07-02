protocol AdvancedLifeSupport {
    func performCPR()
}

class EmergencyCallHandler {
    var delegate: AdvancedLifeSupport?

    func assessSituation() {
        print("Can you tell me what happened?")
    }

    func medicalEmergency() {
        delegate?.performCPR() ?? print("No Delegation Found Yet")
        
    }
}

// class will also work
struct Paramedic: AdvancedLifeSupport {

    let id: String = "1234" // just for comparing object

    // init binds the EmergencyCallHandler
    init(_ handler: EmergencyCallHandler) {
        handler.delegate = self // this actually bind the object with EmergencyCallHandler's delegated property, (optional) nil delegated is not nil anymore after this
    }

    // performCPR method is required by AdvancedLifeSupport protocol
    func performCPR() {
        print("The paramedic does chest compression, 30 per second")
        
    } 
}

var ECH = EmergencyCallHandler()
ECH.medicalEmergency() // will print: No Delegation Found Yet
var someParamedic = Paramedic(ECH)
ECH.medicalEmergency() // will print: The paramedic does chest compression, 30 per second

/**
* As class works by reference (on same instance), when the handler.delegate = self is called through Paramedic(ECH) Instantiation, 
* then "delegated: AdvancedLifeSupport?" optional property of the
* EmergencyCallHandler is actually updated/assigned with the someParamedic object. 
* So the ECH.medicalEmergency() will call the same someParamedic.performCPR() method.
*/

// Checking if both are same object
if ((ECH.delegate! as! Paramedic).id == someParamedic.id) {
    print("Both are same object")
} else {
    print("Not Same")
}

// print((ECH.delegate! as! Paramedic).id)
// print(someParamedic.id)