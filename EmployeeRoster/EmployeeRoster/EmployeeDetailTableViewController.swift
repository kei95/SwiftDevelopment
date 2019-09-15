
import UIKit

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, EmployeeDelegate {

    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var dobDatePicker: UIDatePicker!
    
    var employee: Employee?
    var employeeType: EmployeeType?
    
    var isEditingBirthday: Bool = false {
        didSet {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    let dobPickerCellIndexPath = IndexPath(row: 2, section: 0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "KeyForEmployeeType" {
            if let destinationVC = segue.destination as? EmployeeTypeTableViewController {
                destinationVC.delegate = self
                destinationVC.employeeType = self.employee?.employeeType
            }
        }
    }
    
    @IBAction func dobDatePickerValueChanged(_ sender: UIDatePicker) {
        updateDateView()
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employee.employeeType.description()
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text, let employeeType = self.employeeType {
            employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: employeeType)
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    private func updateDateView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dobLabel.textColor = .black
        
        dobLabel.text = dateFormatter.string(from: dobDatePicker.date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case dobPickerCellIndexPath:
            if isEditingBirthday {
                return dobDatePicker.frame.height
            } else {
                return 0
            }
        default:
            return UITableView.automaticDimension
        }
    }
    
    func didSelect(employeeType: EmployeeType) {
        self.employeeType = employeeType
        self.employee?.employeeType = employeeType
        updateEmployeeType()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case IndexPath(row: 1, section: 0):
            isEditingBirthday = !isEditingBirthday
        default:
            break
        }
    }
    
    fileprivate func updateEmployeeType() {
        if let employeeType = self.employeeType {
            employeeTypeLabel.text = employeeType.description()
            employeeTypeLabel.textColor = .black
        }
    }
    
}
