//
//  Today.swift
//  AppStrore
//
//  Created by Kefan Jian on 2021/7/22.
//

import SwiftUI

struct Today: View {
    
    struct Constants {
        static let modelDuration: TimeInterval = 0.25
    }
    
    @EnvironmentObject var viewModel: TodayViewModel
    
    @Environment(\.tabBarSize) var tabBarSize
    
    @EnvironmentObject var tabViewModel: TabViewModel
    
    @State private var showDetail: Bool = false
    
    @State private var selectedCard: CardModel? = nil
    
    @Namespace var card
    @Namespace var frame
    
    @State private var scale: CGFloat = 1
    
    @State private var isAnimating = false
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd MMMM"
        return formatter
    }()
    
    var timeDescription: String {
        dateFormatter
            .string(from: Date())
            .uppercased()
    }
    
    var body: some View {
        
        ZStack {
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text(timeDescription)
                                .foregroundColor(.gray)
                                .font(.title3)
                                .bold()
                            
                            Text("Today")
                                .foregroundColor(.black)
                                .font(.largeTitle)
                                .bold()
                        }
                        
                        Spacer()
                        
                        Color.gray
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                    VStack(spacing: 25) {
                        
                        ForEach(viewModel.cards) { model in
                            
                            if selectedCard?.id == model.id, showDetail {
                                
                                Color.clear.frame(height: 400)
                                    .scaleEffect(model.id == selectedCard?.id ? scale : 1)
                                    .transition(.model)
                                
                            } else {
                                
                                Button(action: {
                                    
                                    if isAnimating {
                                        return
                                    }
                                    
                                    isAnimating = true
                                    
                                    withAnimation(.linear(duration: Constants.modelDuration)) {
                                        showDetail.toggle()
                                        selectedCard = model
                                    }
                                    
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + Constants.modelDuration) {
                                        isAnimating = false
                                    }
                                    
                                }, label: {
                                    Card(cardModel: model)
                                    
                                })
                                .disabled(isAnimating)
                                .matchedGeometryEffect(id: model.id, in: card)
                                .matchedGeometryEffect(id: model.id, in: frame)
                                                            .animation(nil)
                                
                                .buttonStyle(CardButtonStyle())
                                .scaleEffect(model.id == selectedCard?.id ? scale : 1)
                                .transition(.model)
                                
                            }
                            
                        }
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("Redeen")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .bold()
                                .padding(8)
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            
                        })
                        
                        Divider()
                        
                        Button(action: {}, label: {
                            Text("Term & Conditions")
                                .foregroundColor(.gray)
                                .font(.footnote)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        })
                        
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                .padding(.bottom, tabBarSize.height + 8)
                
            }
            .zIndex(0)
            
            if let model = selectedCard,
               showDetail {
                
                Color.clear
                    .overlay(
                        
                        FullPage(showed: $showDetail, scale: $scale, close: {
                            

                            if isAnimating {
                                return
                            }
                            
                            isAnimating = true
                            
                            withAnimation(.linear(duration: Constants.modelDuration)) {
                                scale = 1
                                showDetail = false
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.modelDuration) {
                                isAnimating = false
                                selectedCard = nil
                            }
                        }) {
                            
                            CardDetail(showed: $showDetail, model: model, namesapce: card)
                            .matchedGeometryEffect(id: model.id, in: frame, isSource: false)
                            
                        }
                        .disabled(isAnimating)
                        .edgesIgnoringSafeArea(.all)
                        
                    )
                    .transition(.model)
                    .zIndex(1)
                
            }
            
            
        }
        
        .onChange(of: showDetail) { showDetail in
            withAnimation {
                
                if showDetail {
                    tabViewModel.hidden = true
                } else {
                    tabViewModel.hidden = false
                }
                
            }
            
        }
        
    }
}

struct Today_Previews: PreviewProvider {
    static var previews: some View {
        Today()
            .environmentObject(TodayViewModel())
            .environmentObject(TabViewModel())
    }
}

struct CardButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 400)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.25))
        
    }
    
}
