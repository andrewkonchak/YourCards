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
    
    let cellId = "Cell"
    
    @IBOutlet weak var cardTableView: UITableView!
    
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    var cardManager = CardsManager()
    var allCards = [Card]()
    var cardsArray = [Card]()
    var shareCardImage: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardTableView.delegate = self
        cardTableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveCards()
        
    }
    
    @IBAction func searchBarItem(_ sender: UIBarButtonItem) {
        if navigationItem.titleView is UISearchBar {
            hideSearchBar()
        } else {
            createSearchBar()
        }
    }
    
    // MARK: - Custom search bar
    
    func createSearchBar(){
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search your card here!"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        cardsArray = allCards
        tableView.reloadData()
        hideSearchBar()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            hideSearchBar()
            return
        }
        
        cardsArray = allCards.filter({ (card) -> Bool in
            return card.cardName?.range(of: text) != nil
        })
        
        cardTableView.reloadData()
    }
    
    func hideSearchBar() {
        cardsArray = allCards
        tableView.reloadData()
        navigationItem.titleView = nil
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CardTableViewCell
        cell.configureCell(card:cardsArray[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cardToFullView", sender: cardsArray[indexPath.row])
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            self.performSegue(withIdentifier: "addNewCardSegue", sender: self.cardsArray[indexPath.row])
            
        }
        editAction.backgroundColor = #colorLiteral(red: 0.2497821676, green: 0.7859748018, blue: 0.7195636982, alpha: 1)
        
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (rowAction, indexPath) in
            let shareVC = UIActivityViewController(activityItems: [CardsManager.convertBase64ToImage(base64String: self.cardsArray[indexPath.row].cardBackImage!),self.cardsArray[indexPath.row].cardName!, self.cardsArray[indexPath.row].cardNumber!], applicationActivities: nil)
            self.present(shareVC, animated: true, completion: nil)
            
        }
        
        shareAction.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            self.cardManager.deleteCard(card: self.cardsArray[indexPath.row])
            self.cardsArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        return [editAction, shareAction, deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewCardSegue"{
            let editCell = segue.destination as! AddNewCardViewController
            editCell.editCard = sender as? Card
        }else if segue.identifier == "cardToFullView"{
            let editUserCard = segue.destination as! CardFullViewController
            editUserCard.cardFromCell = sender as? Card
        }
    }
    
     // MARK: - TableView animate
    
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        
        let tableViewHeigh = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeigh)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
        
        
    }
    
    
    func retrieveCards(){
        fetchCardsFromCoreData { (cards) in
            if let cards = cards {
                self.allCards = cards
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
    
}
