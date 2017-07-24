import UIKit

//: # This is my playground


//: ## Dependency Injection
//: ### Inversion of Control

class Service {
    func doSmth() {
        print("Hello")
    }
}

class Client {
    var service: Service
    
    init(with service: Service = Service()) {
        self.service = service
    }
    
    func startSomething() {
        service.doSmth()
    }
}

class Container {
    typealias Closure = (Void) -> AnyObject
    
    var registry: [String:Closure] = [:]
    
    func register(name: String, for type: @escaping Closure) {
        registry[name] = type
    }
    
    func resolve(by name: String) -> AnyObject? {
        return registry[name]?()
    }
}

let container = Container()
container.register(name: "Service") {
    Service()
}
container.register(name: "Client") {
    Client(with: container.resolve(by: "Service") as! Service)
}

let result = container.resolve(by: "client") as? Client
result?.startSomething()




//: ## MVVM
class Model {
    var date: Date = Date()
}

class ViewModel {
    var model: Model
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    init(with model: Model) {
        self.model = model
    }
    
    var modelDate: String {
        return dateFormatter.string(from: model.date)
    }
}

class MyViewController: UIViewController {
    var viewModel: ViewModel?
    var model = Model()
   
    @IBOutlet var dateLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(with: model)
    }
    
    @IBAction func setDate() {
        dateLabel?.text = viewModel?.modelDate
    }
}


//: ## Presenter
class Presenter {
    weak var view: UIView?
    
    init(view: UIView) {
        self.view = view
    }
    
    func displayAlert(on viewController: UIViewController, title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = createAlert(with: title, message: message, actions: actions);
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func createAlert(with title: String?, message: String?, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions.forEach { alert.addAction($0) }
        
        return alert
    }
    
}



//: Tuples

func toTuple(_ address: String, number: Int) -> (address: String, number: Int) {
    return (address, number)
}

var addr = toTuple("Dacia", number: 7)
print(addr.number)
print(addr.address)