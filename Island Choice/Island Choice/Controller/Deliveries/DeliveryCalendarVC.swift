//
//  DeliveryCalanderVC.swift
//  Island Choice
//
//  Created by GT-Raj on 25/02/21.
//

import UIKit
import FSCalendar
import SwiftyJSON

class DeliveryCalendarVC: UIViewController {
    
    var arrDates:[String] = []
    var arrHoliday:[String] = []
//    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
//    fileprivate let datesWithCat = ["2015/05/05","2015/06/05","2015/07/05","2015/08/05","2015/09/05","2015/10/05","2015/11/05","2015/12/05","2016/01/06",
//    "2016/02/06","2016/03/06","2016/04/06","2016/05/06","2016/06/06","2016/07/06"]
//
//
    
    // MARK: - Outlets

    @IBOutlet weak var calendarView: FSCalendar!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
  
    // MARK: - Main Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        GetDeliveryDays()
        title = "Delivery Calendar"
        setupCartBtn()
        // Do any additional setup after loading the view.
    }


}


extension DeliveryCalendarVC: FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        if dateFormatter.string(from: date) == dateFormatter.string(from: Date()) {
            return "Today"
            //            print(dateFormatter.string(from: Date()))
        }
        return nil
    }
    //
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date().startDateOfYear().toDate
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date().endDateOfYear().toDate
    }
    //    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
    //        let day: Int! = self.gregorian.component(.day, from: date)
    //        return [13,24].contains(day) ? UIImage(named: "img_phone") : nil
    //    }
    
    
}


extension DeliveryCalendarVC: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
            return (Date().startDateOfYear().toDate <= date.toDate && Date().endDateOfYear().toDate >= date.toDate)
        }

}



extension DeliveryCalendarVC: FSCalendarDelegateAppearance {
    
    
    
    
}


extension Date {
    
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let strDate = dateFormatter.string(from: self)
        return dateFormatter.date(from: strDate) ?? self
    }
}



extension DeliveryCalendarVC {
    
    
   fileprivate func GetDeliveryDays() {
    
    let deliveryID = Int(OnstopDeliveryModel.details.deliveryId)
    print(deliveryID)
     let param = [
        
       
           "deliveryId":deliveryID,
           "startDate":"2021-01-01",
           "endDate":"2022-12-31",
           "ignoreCache":true,
           "descending":false
      
        ]
     as [String : Any]
    
    showHUD()
    NetworkManager.Order.GetDeliveryDays(param: param, { (json) in
        print(json)
        for json in json.arrayValue {
            let data = OnstopDeliveryModel(json: json)
            self.arrDates.append(data.calendarDate)
        }
       
//        let data = DeliveryDay(json: json)
       
        self.hideHUD()
        self.GetHolidays()
    }, { (error) in
      
        self.hideHUD()
        self.showToast(error)
    })
}
    
   fileprivate func GetHolidays() {
    
    let branchId = AccountInformation.details.branch
    print(branchId)
    
     let param = [
        
       
        "branchId":branchId,
        "startDate":"2021-01-01",
        "endDate":"2022-12-31"
      
        ]
     as [String : Any]
    
    showHUD()
    NetworkManager.Order.GetHolidays(param: param, { (json) in
        for json in json.arrayValue {
            self.arrHoliday.append(json.stringValue)
            
        }
       
      
        self.hideHUD()
    }, { (error) in
      
        self.hideHUD()
        self.showToast(error)
    })
}
        
}
    
extension DeliveryCalendarVC {
    
    
    
    
}


extension Date {
    
    func startDateOfYear() -> Date {
        var calender = Calendar.current
        calender.locale = Locale(identifier: "en_US_POSIX")
        calender.timeZone = TimeZone(identifier: "UTC")!
        return calender.date(from: calender.dateComponents([.year], from: calender.startOfDay(for: self))) ?? Date()
    }
    
    func endDateOfYear() -> Date {
        var calender = Calendar.current
        calender.locale = Locale(identifier: "en_US_POSIX")
        return calender.date(byAdding: DateComponents(year: 1, month: 0, day: -1), to: self.startDateOfYear()) ?? Date()
    }
}

