//
//  MyBMICalculatorView.swift
//  NewBMICalculator
//
//  Created by Pattanan Prarom on 30/3/2566 BE.
//

import SwiftUI

struct MyBMICalculatorView: View {
    
    @State var myWeight : String = ""
    @State var myHeight : String = ""
    @State var myBMIResult : String = ""
    //ตัวแปรแทนการตรวจสอบการแจ้งเตือนในกรณีที่ผู้ใช้กรอกข้อมูลไม่ครบถ้วน
    @State var showAlert : Bool = false
    
    var body: some View {
        //กําหนดสีพื้นหลังหน้าจอด้วย ZStack
        ZStack{
            Color.init(red: 239.0/255.0, green: 244.0/255.0, blue: 244.0/255.0)
            VStack {
                TextField("น้ําหนัก", text: $myWeight)
                    .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(Color.white)
                    .offset(y : 20)
                    .keyboardType(.decimalPad)
                TextField("ส่วนสูง", text: $myHeight)
                    .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(Color.white)
                    .offset(y : 25)
                    .keyboardType(.decimalPad)
                HStack{
                    Button(action: {
                        self.checkInput()
                        self.hideKeyboard()
                    } ) {
                        Text("แสดงค่า BMI")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 45)
                            .background(Color.gray)
                            .foregroundColor(Color.white)
                    }
                    .alert(isPresented: $showAlert) { () -> Alert in
                        return Alert(title: Text("BMICalculator"), message: Text("Please enter your data"), primaryButton: .cancel(Text("Close Window")), secondaryButton: .default(Text("Clear Data"), action: {
                            self.myWeight = ""
                            self.myHeight = ""
                            self.myBMIResult = ""
                        }))
                    }
                    Button(action: {
                        self.myWeight = ""
                        self.myHeight = ""
                        self.myBMIResult = ""
                    }) {
                        Text("เคลียร์แบบฟอร์ม")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 45)
                            .background(Color.gray)
                            .foregroundColor(Color.white)
                    }
                }
                .offset(y : 35)
                //ส่วนของการแสดงผล BMI
                Text("\(myBMIResult)")
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .offset(y : 50)
                Spacer()
            }
            .padding(.horizontal, 15)
            .navigationBarTitle("Calculate")
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    
    
    private func hideKeyboard(){
        let myScenes = UIApplication.shared.connectedScenes
        let windowScene = myScenes.first as? UIWindowScene
        windowScene?.windows.forEach({ $0.endEditing(true)})
    }
    //ฟังก์ชันทําการตรวจสอบข้อมูลนําเข้า
    private func checkInput(){
        if ((Double(self.myWeight) != nil) && (Double(self.myHeight) != nil)){
            self.bmiCalculationMethod()
        }
        else{
            self.showAlert = true
        }
    }
    private func bmiCalculationMethod() {
        let myWeight = Double(self.myWeight)!
        let myHeight = Double(self.myHeight)! / 100.0
        let myBMIResult = myWeight / (myHeight * myHeight)
        self.myBMIResult = self.bmiResultInterpretation(bmiValue: myBMIResult)
    }
    //ฟังชันแปลค่า BMI เป็นคําอธิบาย
    private func bmiResultInterpretation(bmiValue : Double) -> String{
        var bmi = String(format: "%.1f", bmiValue)
        var result : String = "BMI = \(bmi) \n"
        if bmiValue >= 40.0 {
            result += "You are extremely obese. Please see a doctor urgently."
        }else if bmiValue >= 35.0 {
            result += "If you are obese at level 2, you are at risk for the diseases that come with obesity. If you have a waist circumference greater than the norm, you are at high risk of developing the disease. You have to control your diet. and exercise vigorously"
        }else if bmiValue >= 28.5 {
            result += "You are obese level 1 and if you have a waist circumference of more than 90 cm (men) 80 cm (women), you are more likely to develop high blood pressure and diabetes. You need to control your diet. and exercise"
        }else if bmiValue >= 23.5 {
            result += "Overweight If you have a genetic predisposition to diabetes or hyperlipidemia, try to lose weight so that your body mass index is below 23."
        }else if bmiValue >= 18.5{
            result += "Normal weight and fat content within the normal range are less likely to have a serious disease. incidence of diabetes lower blood pressure than those who are obese"
        }else{
            result += "underweight This may be caused by athletes who exercise a lot. and not getting enough nutrients The solution is to eat quality food. and has sufficient energy and exercise appropriately"
        }
        return result
    }
    
}


struct MyBMICalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        MyBMICalculatorView()
    }
}
