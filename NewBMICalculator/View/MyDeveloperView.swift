//
//  MyDeveloperView.swift
//  NewBMICalculator
//
//  Created by Pattanan Prarom on 30/3/2566 BE.
//

import SwiftUI

struct MyDeveloperView: View {
    var body: some View {
        VStack { //เปิด VStack
        //ใสข้อความบนหน้าจอ
        MyImageView()
            
        Text("Pattanan Prarom")
            .fontWeight(.bold)
            .font(.custom("Sukhumvit Set", size: 35))
            .foregroundColor(.yellow)
            Text( "pattanan.pr@ku.th")
    //        Text(verbatim: "pattanan.pr@ku.th").foregroundColor(.blue)
            Text("Kasetsart University").font(.title2).fontWeight(.bold)
    //    Spacer()
        } //ปิด VStack

        .padding(25)
        .cornerRadius(20)
        }
}

struct MyDeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        MyDeveloperView()
    }
}
