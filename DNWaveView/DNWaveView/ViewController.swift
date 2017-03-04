//
//  ViewController.swift
//  DNWaveView
//
//  Created by mainone on 2017/3/3.
//  Copyright © 2017年 mainone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addHeaderViewToTableView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.waveView.wave()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    // 添加tableHeaderView
    func addHeaderViewToTableView() {
        let headView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(self.view.frame.width), height: CGFloat(245)))
        headView.backgroundColor = UIColor(red: CGFloat(48 / 255.0), green: CGFloat(135 / 255.0), blue: CGFloat(242 / 255.0), alpha: CGFloat(1))
        self.tableView.tableHeaderView = headView
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
    lazy var tableView: UITableView = {
        let tableV = UITableView(frame: self.view.bounds, style: .grouped)
        tableV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableV.delegate = self
        tableV.dataSource = self
        self.view.addSubview(tableV)
        return tableV
    }()
    
    lazy var waveView: DNWaveView = {
        let waveV = DNWaveView.add(to: self.tableView.tableHeaderView!, withFrame: CGRect(x: CGFloat(0), y: CGFloat((self.tableView.tableHeaderView?.frame.height)! - 4.5), width: CGFloat(self.tableView.frame.width), height: CGFloat(5)))
        return waveV as! DNWaveView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
}


extension ViewController: UITableViewDelegate {
    
}


