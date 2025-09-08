
import UIKit

protocol EmployeeDetailTableViewControllerDelegate: AnyObject {
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee)
}

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, EmployeeTypeTableViewControllerDelegate {
    func employeeTypeTableViewController(_ controller: EmployeeTypeTableViewController, didSelect employeeType: EmployeeType) {
        self.employeeType = employeeType
        employeeTypeLabel.text = employeeType.description
        employeeTypeLabel.textColor = .black
        updateSaveButtonState()
    }
    
    var isEditingBirthday: Bool = false {
            didSet {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    
    weak var delegate: EmployeeDetailTableViewControllerDelegate?
    var employee: Employee?
    
    var employeeType: EmployeeType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if employee == nil {
                let calendar = Calendar.current
                let currentDate = Date()
                
                if let maxDate = calendar.date(byAdding: .year, value: -16, to: currentDate),
                   let minDate = calendar.date(byAdding: .year, value: -65, to: currentDate),
                   let defaultDate = calendar.date(byAdding: .year, value: -16, to: currentDate) {
                    
                    dobDatePicker.maximumDate = maxDate
                    dobDatePicker.minimumDate = minDate
                    dobDatePicker.date = defaultDate
                }
            }
        
        updateView()
        updateSaveButtonState()
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            
            dobLabel.text = employee.dateOfBirth.formatted(date: .abbreviated, time: .omitted)
            dobLabel.textColor = .label
            employeeTypeLabel.text = employee.employeeType.description
            employeeTypeLabel.textColor = .label
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let datePickerIndexPath = IndexPath(row: 2, section: 0)
            if indexPath == datePickerIndexPath && !isEditingBirthday {
                return 0
            }
            return UITableView.automaticDimension
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//              let birthdayCellIndexPath = IndexPath(row: 1, section: 0)
//              if indexPath.row == 2 {
//                  isEditingBirthday.toggle()
//              }
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            isEditingBirthday.toggle()
            
            if isEditingBirthday {
                dobLabel.textColor = .systemBlue
            } else {
                dobLabel.textColor = .label
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    
    @IBAction func dobDatePickerValueChanged(_ sender: UIDatePicker) {
        dobLabel.text = sender.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    
    private func updateSaveButtonState() {
        let hasName = nameTextField.text?.isEmpty == false
        let hasEmployeeType = employeeType != nil
        let shouldEnableSaveButton = nameTextField.text?.isEmpty == false
        saveBarButtonItem.isEnabled = shouldEnableSaveButton
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else {
            return
        }
        
        let employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: employeeType ?? .exempt)
        delegate?.employeeDetailTableViewController(self, didSave: employee)
    }
    
//    @IBSegueAction func showEmployeeTypes(_ coder: NSCoder, sender: Any?) -> EmployeeTypeTableViewController? {
//        let employeeTypeTVC = EmployeeTypeTableViewController(coder: coder)
//            employeeTypeTVC?.delegate = self
//            return employeeTypeTVC
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmployeeTypeSegue" {
            let destination = segue.destination as! EmployeeTypeTableViewController
            destination.delegate = self
            destination.employeeType = employeeType
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
    }

    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        updateSaveButtonState()
    }

}



    
