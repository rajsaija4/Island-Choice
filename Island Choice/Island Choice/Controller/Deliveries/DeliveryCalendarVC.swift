//
//  DeliveryCalanderVC.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit
import FSCalendar

class DeliveryCalendarVC: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var calendarView: FSCalendar!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Delivery Calendar"
        setupCartBtn()
        // Do any additional setup after loading the view.
    }


}


extension DeliveryCalendarVC: FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        if dateFormatter.string(from: date) == dateFormatter.string(from: Date()) {
            return "Today"
        }
        return nil
    }
    
}


extension DeliveryCalendarVC: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return date.toDate >= Date().toDate
    }

}



extension DeliveryCalendarVC: FSCalendarDelegateAppearance {
    
    
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
