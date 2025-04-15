//
//  ActivityController.swift
//  Shopping List
//
//  Created by Gustavo Yud on 03/04/25.
//

import ActivityKit
import Foundation

class ActivityHelper {
    /**
        Singleton instance of the ActivityHelper class.
     */
    static let shared = ActivityHelper()
    
    /**
        The list view model for the live activity.
     */
    private var listView: ListModel?
    
    /**
        The activity instance for the live activity.
     */
    public var activity: Activity<LiveActivityAttributes>?
    
    /**
        Private initializer to prevent instantiation from outside.
     */
    init() {}
    
    /**
        Sets the list view for the live activity.
     */
    func setListView(_ listView: ListModel?) {
        self.listView = listView
    }

    /**
        Starts a live activity with the given parameters.
     */
    func startActivity()  {
        guard let listView else { return }
        let selectedItems = listView.products?.filter { $0.isChecked == true } ?? []
        let unselectedItems = listView.products?.filter { $0.isChecked == false } ?? [] 
        
        let attributes = LiveActivityAttributes(listName: listView.title, icon: listView.icon)
        let contentState = LiveActivityAttributes.ContentState(itemsCompleted: selectedItems.count, listLength: listView.products?.count ?? 0, nextItem: unselectedItems.first?.name)

        do {
            activity = try Activity.request(
                attributes: attributes,
                content: ActivityContent(state: contentState, staleDate: nil),
                pushType: nil
            )
        } catch {
            print("Error starting activity: \(error)")
        }
    }

    /**
        Updates the live activity with the current state of the list view.
     */
    func updateActivity() {
        guard let listView else { return }
        guard let activity else { return }

        Task { @MainActor in
            let selectedItems = listView.products?.filter { $0.isChecked == true } ?? []
            let unselectedItems = listView.products?.filter { $0.isChecked == false } ?? []
            
            let newState = LiveActivityAttributes.ContentState(
                itemsCompleted: selectedItems.count,
                listLength: listView.products?.count ?? 0,
                nextItem: unselectedItems.first?.name)
            let content = ActivityContent(state: newState, staleDate: nil)
            await activity.update(
                content,
                alertConfiguration: .none)
        }
    }

    /**
        Ends the live activity.
     */
    func endLiveActivity() async {
        let dismissalPolicy: ActivityUIDismissalPolicy = .immediate

        if let activity {
            await activity.end(
                ActivityContent(state:
                    LiveActivityAttributes.ContentState(
                        itemsCompleted: 0,
                        listLength: 0,
                        nextItem: ""
                    ), staleDate: nil),
                dismissalPolicy: dismissalPolicy
            )
        }

        self.activity = nil
    }
}
