//
//  ViewController.swift
//  Remainder
//
//  Created by Mac on 17/05/17.
//
import UserNotifications
import UIKit

class ViewController: UIViewController {
    @IBOutlet var table: UITableView!
    var models = [myReminder]()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        
    }
    @IBAction func didTapAdd(){
        //show add vc
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge], completionHandler: {success,error in
//            if success{
//
//            }
//            else if let error = error{
//                print("error occured")
//            }
//        })
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "add") as? AddViewController else{
            return
    }
        vc.title = "new remainder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = {title,body,date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = myReminder(title: title, date: date, identifier: "id_\(title)")
                self.models.append(new)
                self.table.reloadData()
                
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.sound = .default
                    content.body = body
                    let targetDate = date
                    let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: targetDate),
                                                                repeats: false)
                    
                    let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request,withCompletionHandler: {error in
                        if error != nil
                        {
                            print("something went wrong")
                        }
                    })
                    
                }
            }
        navigationController?.pushViewController(vc, animated: true)

        }
    func sheduleTest(){
        let content = UNMutableNotificationContent()
        content.title = "Hello World"
        content.sound = .default
        content.body = "my long body.my long body"
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: targetDate),
                                                    repeats: false)
        
        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request,withCompletionHandler: {error in
            if error != nil
            {
                print("something went wrong")
            }
        })
        
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        let date = models[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM,dd,YYYY at hh:mm a"
        cell.detailTextLabel?.text = formatter.string(from:date)
        cell.detailTextLabel?.font = .systemFont(ofSize: 16)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
struct myReminder{
    let title: String
    let date: Date
    let identifier: String
}
