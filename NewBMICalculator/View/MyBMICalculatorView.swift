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
                        return Alert(title: Text("BMICalculator"), message: Text("กรุณากรอกข้อมูลให้ครบถ้วน"), primaryButton: .cancel(Text("ปิดหน้าต่าง")), secondaryButton: .default(Text("เคลียร์ข้อมูล"), action: {
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
            .navigationBarTitle("คํานวณค่า BMI")
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
        var result : String = "ค่า BMI = \(bmiValue) \n"
        if bmiValue >= 40.0 {
            result += "คุณเป็นโรคอ้วนขึ้นสูงสุด กรุณาพบแพทย์ด่วน"
        }else if bmiValue >= 35.0 {
            result += "คุณเป็นโรคอ้วนระดับ 2 คุณเสี่ยงต่อการเกิดโรคที่มากับความอ้วน หากคุณมีเส้นรอบเอวมากกว่าเกณฑ์ปกติคุณจะเสี่ยงต่อการเกิดโรคสูง คุณต้องควบคุมอาหาร และออกกําลังกายอย่างจริงจัง"
        }else if bmiValue >= 28.5 {
            result += "คุณเป็นโรคอ้วนระดับ 1 และหากคุณมีเส้นรอบเอวมากกว่า 90 ซม.(ชาย) 80 ซม.(หญิง) คุณจะมีโอกาสเกิดโรคความดัน เบาหวานสูง จําเป็นต้องควบคุมอาหาร และออกกําลังกาย"
        }else if bmiValue >= 23.5 {
            result += "น้ําหนักเกิน หากคุณมีกรรมพันธ์เป็นโรคเบาหวานหรือไขมันในเลือดสูงต้องพยายามลดน้ําหนักให้ดัชนีมวลกายต่ํากว่า 23"
        }else if bmiValue >= 18.5{
            result += "น้ําหนักปกติ และมีปริมาณไขมันอยู่ในเกณฑ์ปกติมักจะไม่ค่อยมีโรคร้าย อุบัติการณ์ของโรคเบาหวาน ความดันโลหิตสูงต่ํากว่าผู้ที่อ้วนกว่านี้"
        }else{
            result += "น้ําหนักน้อยเกินไป ซึ่งอาจจะเกิดจากนักกีฬาที่ออกกําลังกายมาก และได้รับสารอาหารไม่เพียงพอ วิธีแก้ไขต้องรับประทานอาหารที่มีคุณภาพ และมีปริมาณพลังงานเพียงพอ และออกกําลังกายอย่างเหมาะสม"
        }
        return result
    }
    
}


struct MyBMICalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        MyBMICalculatorView()
    }
}
