//
//  ItemStore.swift
//  Homepwner
//
//  Created by bmiit on 20/04/22.
//

import UIKit

class ItemStore
{
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item
    {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item)
    {
        if let index = allItems.index(of: item){
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }

    
    //    init() {
//        for _ in 0..<5
//        {
//            createItem()
//            print(allItems)
//        }
//    }
}

