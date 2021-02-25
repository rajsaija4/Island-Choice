//
//  DeliveryCalanderVC.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit
import FSCalendar

class DeliveryCalanderVC: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var calenderView: FSCalendar!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension DeliveryCalanderVC: FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        if dateFormatter.string(from: date) == dateFormatter.string(from: Date()) {
            return "Today"
        }
        return nil
    }
    
}


extension DeliveryCalanderVC: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return date.toDate >= Date().toDate
    }

}



extension DeliveryCalanderVC: FSCalendarDelegateAppearance {
    
    
}


extension Date {
    
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let strDate = dateFormatter.string(from: self)
        return dateFormatter.date(from: strDate) ?? self
    }
}
