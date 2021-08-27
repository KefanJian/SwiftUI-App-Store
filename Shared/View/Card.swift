//
//  Card.swift
//  AppStrore
//
//  Created by Kefan Jian on 2021/7/23.
//

import SwiftUI

struct Card: View {
    
    var cardModel: CardModel
    
    var body: some View {
        
        ZStack {
            
                VStack(alignment: .leading) {
                    Text(cardModel.caption)
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.5))
                    Text(cardModel.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
        }
        .background(Image(cardModel.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaleEffect(1.2)
                        .edgesIgnoringSafeArea(.top)
        )
        .clipped()
    }
}

struct Card_Previews: PreviewProvider {
    
    @Namespace static var namespace

    static var previews: some View {
        let model = TodayViewModel().cards[0]
        Card(cardModel: model)
            .previewLayout(.fixed(width: 375, height: 500))
    }
}
