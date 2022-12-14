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
    var arrDisableDates:[String] = []
//    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
//    fileprivate let datesWithCat = ["2015/05/05","2015/06/05","2015/07/05","2015/08/05","2015/09/05","2015/10/05","2015/11/05","2015/12/05","2016/01/06",
//    "2016/02/06","2016/03/06","2016/04/06","2016/05/06","2016/06/06","2016/07/06"]
//
//
    
    // MARK: - Outlets

    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnImportPdf: UIButton!
    @IBOutlet weak var btnViewpdf: UIButton!
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
        GetDeliveryDays()
//        GetDeliveryDays()
        title = "Delivery Calendar"
        setupCartBtn()
        // Do any additional setup after loading the view.
    }

    @IBAction func onPressEmailbtnTap(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Email Yearly Calendar", message: "Enter Your Email", preferredStyle: .alert)
            alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            guard let email = alert?.textFields?[0].text, email.count > 0  else {
                self.showToast("Please \(alert?.textFields?[0].placeholder ?? "") ")
                return
            }
            guard email.isValidEmail else {
                self.showToast("Please Enter valid email")
                return
            }
            
            self.emailYearlyCalender(email: email)
           
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func onPressViewPdfbtnTap(_ sender: UIButton) {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        let year = components.year
        
        let deliveryId = OnstopDeliveryModel.details.deliveryId
        let branch = AccountInformation.details.branch
        
        guard let url = URL(string: "https://islandchoiceguam.com/account/api/app-get-yearly-calendar/\(deliveryId)/\(year!)/\(branch)") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func onPressImportCalendarbtnTap(_ sender: UIButton) {
        
        guard let url = URL(string: "https://islandchoiceguam.com/account/api/app-get-yearly-ics/10123700/2021") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
}


extension DeliveryCalendarVC: FSCalendarDataSource {
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date().startDateOfYear()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date().endDateOfYear()
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        if arrDates.contains(date.toDate) {
            return UIImage(named: "img_truck")
        }
        
        if arrHoliday.contains(date.toDate) {
            return UIImage(named: "img_holiday")
        }
        
        return nil
    }
    
    
}


extension DeliveryCalendarVC: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
}


extension DeliveryCalendarVC: FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return arrDisableDates.contains(date.toDate) ? .lightGray : nil
    }
    
    
}

extension DeliveryCalendarVC {
    
    
   fileprivate func GetDeliveryDays() {
    
    let deliveryID = Int(OnstopDeliveryModel.details.deliveryId)
    let startDate = Date().startDateOfYear().toDate
    let endDate = Date().endDateOfYear().toDate
   
    let param = [
        
        "deliveryId":deliveryID ?? "",
        "startDate":startDate,
        "endDate":endDate,
        "ignoreCache":true,
        "descending":false
        
    ]
     as [String : Any]
    
    showHUD()
    NetworkManager.Order.GetDeliveryDays(param: param, { (json) in
        print(json)
        for json in json.arrayValue {
            let data = OnstopDeliveryModel(json: json)
            if let newDate = data.calendarDate.split(separator: "T").first {
                self.arrDates.append(String(newDate))
            }
        }
       
//        let data = DeliveryDay(json: json)
        self.GetHolidays()
        self.hideHUD()
       
    }, { (error) in
      
        self.hideHUD()
        self.showToast(error)
    })
}
    
   fileprivate func GetHolidays() {
    
    let branchId = AccountInformation.details.branch
    print(branchId)
    
    let startDate = Date().startDateOfYear().toDate
    let endDate = Date().endDateOfYear().toDate

    
     let param = [
        
       
        "branchId":branchId,
        "startDate":startDate,
        "endDate":endDate
      
        ]
     as [String : Any]
    
    showHUD()
    NetworkManager.Order.GetHolidays(param: param, { (json) in
        for jsonDate in json.arrayValue {
            if let newDate = jsonDate.stringValue.split(separator: "T").first {
                self.arrHoliday.append(String(newDate))
            }
            
        }
       
        self.GetDisabledDates()
        self.hideHUD()
      
    }, { (error) in
      
        self.hideHUD()
        self.showToast(error)
    })
}
    
    fileprivate func GetDisabledDates() {
        
        let branchId = AccountInformation.details.branch
        
        let startDate = Date().startDateOfYear().toDate
        let endDate = Date().endDateOfYear().toDate
     
     
      let param = [
         
        
            "branchId":branchId,
            "startDate":startDate,
            "endDate":endDate
       
         ]
      as [String : Any]
     
     showHUD()
     NetworkManager.Order.GetDisabledDates(param: param, { (json) in
         print(json)
         for dateDisable in json.arrayValue {
            
            if let newDate = dateDisable.stringValue.split(separator: "T").first {
                self.arrDisableDates.append(String(newDate))
            }
            
           
         }
//        print(self.arrDisableDates)
//        print(self.arrHoliday)
//        print(self.arrDates)
        
 //        let data = DeliveryDay(json: json)
        self.calendarView.reloadData()
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
    
    var toDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func startDateOfMonth() -> String {
            var calender = Calendar.current
            calender.locale = Locale(identifier: "en_US_POSIX")
            calender.timeZone = TimeZone(identifier: "UTC")!
            let startDate =  calender.date(from: calender.dateComponents([.year, .month], from: calender.startOfDay(for: self))) ?? Date()
            return startDate.toDate
        }
        
        func yesterdayDate() -> String {
            var calender = Calendar.current
            calender.locale = Locale(identifier: "en_US_POSIX")
            calender.timeZone = TimeZone(identifier: "UTC")!
            let yesterdayDate =  calender.date(byAdding: DateComponents(year: 0, month: 0, day: -1), to: Date()) ?? Date()
            return yesterdayDate.toDate
        }
}

extension DeliveryCalendarVC {
    
   
    
    fileprivate func emailYearlyCalender(email:String) {
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        let year = components.year
        
        let deliveryId = OnstopDeliveryModel.details.deliveryId
        let branch = AccountInformation.details.branch
        
       
      let param = [
        "deliveryId":deliveryId,
        "branch":branch,
        "year":String(year ?? 0),
        "email":email
         ]
      as [String : Any]
     
     showHUD()
     NetworkManager.Order.emailCalenderDate(param: param, { (json) in
         print(json)
        self.showToast("Send to your Email")
         self.hideHUD()
     }, { (error) in
       
         self.hideHUD()
         self.showToast(error)
     })
 }

    
    
}
