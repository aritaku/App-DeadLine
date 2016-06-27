//
//  ViewController.swift
//  Deadline
//
//  Created by x16069xx on 2016/06/24.
//  Copyright © 2016年 Shimon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var repeatPicker: UIPickerView!
    
    
    let dataList = [["通知しない","1回","5分","10分","20分","1時間","2時間","3時間","4時間","毎日","毎週","毎月"]]
    var date: String!
    var saveDate = NSUserDefaults.standardUserDefaults()
    var listArray = [AnyObject]()
    var pickerData: String = ""
    
    @IBAction func changeDate(sender: UIDatePicker) {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        date = formatter.stringFromDate(sender.date)
    }
    
    
    var wordArray: [AnyObject] = []
    let saveData = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repeatPicker.dataSource = self
        repeatPicker.delegate = self

    }
    
    @IBAction func saveButton(){
        let alert = UIAlertController(
            title: "保存完了",
            message: "登録が完了しました",
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Default,
                handler:nil
            )
        )
        self.presentViewController(alert, animated: true, completion: nil)
        
        let myDateFormatter: NSDateFormatter = NSDateFormatter()
        myDateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        let mySelectedDate: String = myDateFormatter.stringFromDate(datePicker.date)
        var name = textField.text
        
        var listDictionary = ["date": mySelectedDate, "repeat": pickerData, "name": name!]
        listArray.append(listDictionary)
        saveData.setObject(listArray, forKey: "List")
        saveData.synchronize()
        

    }
    
   
    
    //コンポーネントの個数を返すメソッド
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        
        return dataList.count
    }
    
    
    //コンポーネントに含まれるデータの個数を返すメソッド
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList[component].count
    }
    
    
    //データを返すメソッド
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[component][row]
    }
    
    
    //データ選択時の呼び出しメソッド
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //コンポーネントごとに現在選択されているデータを取得する。
//        let data1 = self.pickerView(pickerView, titleForRow: pickerView.selectedRowInComponent(0), forComponent: 0)
//        repeatpicker = data1
        pickerData = dataList[component][row]
    }
    

 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

