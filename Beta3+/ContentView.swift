//
//  ContentView.swift
//  Beta3+
//
//  Created by dominator on 06/08/20.
//

import SwiftUI

struct ContentView: View {
    
    enum Fonts: String, Identifiable, CaseIterable{
        
        var id: String {
            self.rawValue
        }
        
        case headline
        case title
        case caption
        
        var font: Font {
            switch self {
            case .headline:
                return .headline
            case .title:
                return .title
            case .caption:
                return .caption
            }
        }
    }
    
    enum Colors: String, CaseIterable, Identifiable {
        var id: String{
            self.rawValue
        }
        
        case label
        case red
        case green
        case teal
        
        var color: Color{
            switch self {
            case .label:
                return Color(UIColor.label)
            case .red:
                return Color.red
            case .green:
                return Color.green
            case .teal:
                return Color(UIColor.systemTeal)
            }
        }
    }
    
    
    let messages: [String] = Array(repeating: [
        "This projects",
        "is to demonstrate",
        "new additions to SwiftUI",
        "in beta 3",
        "auto managed keyboard handling",
        "manual scrolling for lists",
        "and. all new menus",
    ], count: 3).reduce([]) {  $0 + $1 }
    
    @State var text = ""
    @State var selectedFont: Fonts = .headline
    @State var selectedColor: Colors = .label
    
    
    var body: some View {
        NavigationView {
            ScrollViewReader{ reader in
                List {
                    ForEach(0..<messages.count) { index in
                        Text(messages[index])
                            .font(selectedFont.font)
                            .foregroundColor(selectedColor.color)
                            .id(index) // Add id to scroll with refrence to this id
                    }
                }
                .padding(.bottom, 55)
                .overlay(
                    TextField("Some fiels", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                    , alignment: .bottom
                )
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Additions in beta3")
                .toolbar(items: {
                    ToolbarItem {
                        // Menu with default text label
                        Menu("Font") {
                            ForEach(Fonts.allCases) { font in
                                Button(font.rawValue) {
                                    self.selectedFont = font
                                }
                            }
                        }
                    }
                    ToolbarItem {
                        // Menu with custom Label
                        Menu {
                            ForEach(Colors.allCases) { color in
                                Button(color.rawValue) {
                                    self.selectedColor = color
                                }
                            }
                        } label: {
                            HStack {
                                Circle()
                                    .fill(
                                        AngularGradient(
                                            gradient: Gradient(colors: [Color.red,Color.green, Color.blue, Color.red]),
                                            center: .center
                                        )
                                    )
                                    .frame(width: 25, height: 25)
                                Text("Color")
                            }
                        }

                    }
                    ToolbarItem {
                        Button(action: {
                            withAnimation {
                                reader.scrollTo(0, anchor: .top) // Scrolling to perticular assigned id while aligning it to top
                            }
                        }, label: {
                            // We can intialize Text with Image inside it
                            Text(Image(systemName: "chevron.up.circle.fill")) + Text("\tTop")
                        })
                    }
                    ToolbarItem {
                        Button(action: {
                            withAnimation {
                                reader.scrollTo(messages.count-1, anchor: .bottom) // Scrolling to perticular assigned id while aligning it to bottom
                            }
                        }, label: {
                            Text(Image(systemName: "chevron.down.circle.fill")) + Text("\tBottom")
                        })
                    }
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
