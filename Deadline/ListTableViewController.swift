//
//  ListTableViewController.swift
//  Deadline
//
//  Created by x16069xx on 2016/06/24.
//  Copyright © 2016年 Shimon. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var wordArray: [AnyObject] = []
    let saveData = NSUserDefaults.standardUserDefaults()

    @IBOutlet var viewTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName:"ListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if saveData.arrayForKey("List") != nil {
            wordArray = saveData.arrayForKey("List")!
        }
        tableView.reloadData()
        
        print(wordArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Table view data source
    
    //セクションの数を設定します。
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //セルの個数を指定します。
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordArray.count
    }
    
    //セルの中身の表示の仕方を設定します。
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListTableViewCell

        cell.dateLabel.text = wordArray[indexPath.row]["date"] as? String
        cell.nameLabel.text = wordArray[indexPath.row]["name"] as? String

        
        return cell
    }
    
    //ボタン押下時に呼ばれるメソッド
    @IBAction func changeMode(sender: AnyObject) {
        //通常モードと編集モードを切り替える。
        if(tableView.editing == true) {
            tableView.editing = false
        } else {
            tableView.editing = true
        }
    }
    
    //テーブルビュー編集時に呼ばれるメソッド
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //削除の場合、配列からデータを削除する。
        if( editingStyle == UITableViewCellEditingStyle.Delete) {
            wordArray.removeAtIndex(indexPath.row)
            saveData.removeObjectForKey("List")
            saveData.setObject(wordArray, forKey: "List")

        }
        
        //テーブルの再読み込み
        tableView.reloadData()
    }
    //並び替え時に呼ばれるメソッド
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath){
        
        //移動されたデータを取得する。
        let moveData = tableView.cellForRowAtIndexPath(sourceIndexPath)?.textLabel!.text
        
        //元の位置のデータを配列から削除する。
        wordArray.removeAtIndex(sourceIndexPath.row)
        
        //移動先の位置にデータを配列に挿入する。
        wordArray.insert(moveData!, atIndex:destinationIndexPath.row)
        
        //テーブルの再読み込み
        tableView.reloadData()
    }
}
