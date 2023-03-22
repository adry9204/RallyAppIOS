//
//  ViewController.swift
//  RallyAppIOS
//
//  Created by Adriana Diaz Torres on 3/21/23.
//

import UIKit

class HomeViewController: UIViewController, HomeTableViewDelegate{
   
    
    
    @IBOutlet weak var rallyTableView: UITableView!
    let homeTableViewAdapter = HomeTableViewAdapter()
    
    @IBOutlet weak var helloLabel: UILabel!
    var username = ""
    var rallyDataSource: RallyDataSource? = RallyDataSource()
    
    var selectedMenu: Menu? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        homeTableViewAdapter.tableView = rallyTableView
        homeTableViewAdapter.delegate = self
        //reading the username from Defaults
        let defaults = UserDefaults.standard
        username = defaults.string(forKey: "Username")!
        helloLabel.text = "Hello " + username + " 👋"
        
        
       
        rallyTableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        
        rallyTableView.delegate = homeTableViewAdapter
        rallyTableView.dataSource = homeTableViewAdapter
        
        homeTableViewAdapter.getMenuFromApi()
        
        rallyDataSource?.loadData()
        print(rallyDataSource!.dataSource)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedMenu = nil
    }
    
    func tableItemSelected(dataAtCell: Menu, indexPath: IndexPath) {
        selectedMenu = dataAtCell
        performSegue(withIdentifier: PlateDetailsViewController.segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PlateDetailsViewController.segueIdentifier {
            let destinationVC = segue.destination as? PlateDetailsViewController
            destinationVC?.menuItem = selectedMenu
        }
    }

}

