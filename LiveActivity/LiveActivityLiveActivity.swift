//
//  LiveActivityLiveActivity.swift
//  LiveActivity
//
//  Created by Gustavo Yud on 01/04/25.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct LiveActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityAttributes.self) { context in
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Image(systemName: context.attributes.icon)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.green)
                        .cornerRadius(20)
                    Text(context.attributes.listName).font(.title2)
                }

                HStack {
                    HStack {
                        Image(systemName: "cart").foregroundStyle(.green)
                        Text("\(context.state.itemsCompleted)/\(context.state.listLength)")
                    }
                    Spacer()
                    if let _ = context.state.nextItem {
                        HStack {
                            Image(systemName: "cart.fill.badge.minus").foregroundStyle(.yellow)
                            Text("\(context.state.listLength - context.state.itemsCompleted)")
                        }
                    }
                }
                


                if let nextItem = context.state.nextItem {
                    
                    let progress = Double(context.state.itemsCompleted) / Double(context.state.listLength)
                    ProgressView(value: progress)
                    HStack {
                        Image(systemName: "cart.badge.plus").foregroundStyle(.gray)
                        Text("Próximo item da lista: \(nextItem)")
                            .bold()
                    }
                } else {
                    Text("Lista concluída! 🎉")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
//                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
//                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
//                    Text("Bottom \(context.state.activeList)")
                }
            } compactLeading: {
                Text("\(context.state.itemsCompleted)")
            } compactTrailing: {
//                Text("\(context.state.activeList)")
            } minimal: {
//                Text(context.state.activeList)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

private extension LiveActivityAttributes {
    static var preview: LiveActivityAttributes {
        LiveActivityAttributes(listName: "Nome da lista", icon: "basket")
    }
}

private extension LiveActivityAttributes.ContentState {
    static var smiley: LiveActivityAttributes.ContentState {
        LiveActivityAttributes.ContentState(itemsCompleted: 10, listLength: 10, nextItem: nil)
    }

    static var starEyes: LiveActivityAttributes.ContentState {
        LiveActivityAttributes.ContentState(itemsCompleted: 0, listLength: 10, nextItem: "Pão")
    }
}

#Preview("Notification", as: .content, using: LiveActivityAttributes.preview) {
    LiveActivityLiveActivity()
} contentStates: {
    LiveActivityAttributes.ContentState.smiley
    LiveActivityAttributes.ContentState.starEyes
}

// #Preview("Minimal", as: .dynamicIsland(.minimal), using: LiveActivityAttributes.preview) {
//   LiveActivityLiveActivity()
// } contentStates: {
//    LiveActivityAttributes.ContentState.smiley
//    LiveActivityAttributes.ContentState.starEyes
// }

// #Preview("Expanded", as: .dynamicIsland(.compact), using: LiveActivityAttributes.preview) {
//   LiveActivityLiveActivity()
// } contentStates: {
//    LiveActivityAttributes.ContentState.smiley
//    LiveActivityAttributes.ContentState.starEyes
// }
