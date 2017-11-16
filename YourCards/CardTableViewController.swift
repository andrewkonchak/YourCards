//
//  CardTableViewController.swift
//  YourCards
//
//  Created by Andrew on 11/6/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit
import CoreData


class CardTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var cardTableView: UITableView!
    
    @IBAction func searchBarItem(_ sender: UIBarButtonItem) {
        createSearchBar()
    }
    
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    var cardManager = CardsManager()
    var cardsArray = [Card]()
    var shareCardImage: Card?
    var userSearch = [Card]()
    var searchUserBar: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardTableView.delegate = self
        cardTableView.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // Custom search bar
    func createSearchBar(){
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search your card here!"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchUserBar = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchUserBar = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchUserBar = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchUserBar = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        userSearch = cardsArray.filter({ (card) -> Bool in
            let tmp: NSString = (card.cardName as NSString?)!
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        print(searchText)
        if (userSearch.count == 0) {
            searchUserBar = false;
        } else {
            searchUserBar = true;
        }
        cardTableView.reloadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveCards()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cardsArray.count
    }
    
    let cellId = "Cell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CardTableViewCell
        // Configure the cell...
        cell.configureCell(card:cardsArray[indexPath.row])
        return cell
    }

    func retrieveCards(){
        fetchCardsFromCoreData { (cards) in
            if let cards = cards {
                self.cardsArray = cards
                self.tableView.reloadData()
            }
        }
    }
    func fetchCardsFromCoreData(completion: ([Card]?)->Void) {
        var results = [Card]()
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        do {
            results = try  managedObjectContext!.fetch(request)
            completion(results)
            
        } catch {
            print("Could not fetch Products from CoreData:\(error.localizedDescription)")
            
        }
        
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: performSegue(withIdentifier: "cardToFullView", sender: cardsArray[IndexPath.row])
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cardToFullView", sender: cardsArray[indexPath.row])
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            self.performSegue(withIdentifier: "cellId", sender: self.cardsArray[indexPath.row])
            
        }
        editAction.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (rowAction, indexPath) in
            let shareVC = UIActivityViewController(activityItems: [self.cardManager.convertBase64ToImage(base64String: self.cardsArray[indexPath.row].cardBackImage!),self.cardsArray[indexPath.row].cardName!, self.cardsArray[indexPath.row].cardNumber!], applicationActivities: nil)
            self.present(shareVC, animated: true, completion: nil)
            
        }
        
        shareAction.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            self.cardManager.deleteCard(card: self.cardsArray[indexPath.row])
            self.cardsArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        return [editAction, shareAction, deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellId"{
            let editCell = segue.destination as! AddNewCardViewController
            editCell.editCard = sender as? Card
        }else if segue.identifier == "cardToFullView"{
            let editUserCard = segue.destination as! CardFullViewController
            editUserCard.cardFromCell = sender as? Card
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }    
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
