//
//  ViewController.swift
//  RallyAppIOS
//
//  Created on 2023-03-18.
//
//  Authors
//  --------------------------------------
//  Adriana Diaz Toress
//  301157161
//
//  Aurela Bala
//  301279255
//  Abraham Alfred Babu
//  Student ID : 301270598
//
//  Pia Mae Obias
//  Student ID: 301283632
//
//  Satender Yadav
//  Student ID: 301293305
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
    
    func makeAlert(title: String, message: String) {
        AlertManager.makeAlertWithOkButton(
            title: title,
            message: message,
            viewController: self
        ){}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PlateDetailsViewController.segueIdentifier {
            let destinationVC = segue.destination as? PlateDetailsViewController
            destinationVC?.menuItem = selectedMenu
        }
    }

}

