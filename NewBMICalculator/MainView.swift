//
//  ContentView.swift
//  NewBMICalculator
//
//  Created by Pattanan Prarom on 30/3/2566 BE.
//

import SwiftUI
struct MainView: View {
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(destination: MyBMICalculatorView()) {
                    Image("BMI")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    .padding()
                    
                }
                Text("BMI Calculation")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(y:-75)
                    .padding(.bottom, -75)
                
                NavigationLink(destination: MyDeveloperView()) {
                    Image("Developer")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
        
                Text("Developer")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(y:-75)
                    .padding(.bottom, -75)
            }
            .navigationTitle("BMI Calculator")
            .navigationBarTitleDisplayMode(.large)
           
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
