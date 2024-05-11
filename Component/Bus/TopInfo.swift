//
//  TopInfo.swift
//  skkumap
//
//  Created by 조승용 on 2024/01/02.
//

import SwiftUI

struct TopInfo: View {
    @State private var screenWidth: CGFloat = UIScreen.screenWidth
    
    var timeFormat: TimeFormat
    var busCount: Int
    var busStatus: BusStatus
    
    private var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormat == .Format12Hour ? "hh:mm a" : "HH:mm"
        return formatter.string(from: Date())
    }
    
    private var busCountString: String {
        busStatus == .active ? "\(busCount)대 운행 중" : "운행 종료"
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.init(hex: 0xFFE8E9EB))
                .frame(width: UIScreen.main.bounds.size.width, height: 30)
            
            HStack {
                HStack(spacing: 3) {
                    Text("\(timeString) 기준")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.black)
                    Text("·")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.black)
                    Text(busCountString)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.black)
                }
                .padding(.leading, 15)
                
                Spacer()
            }
        }
        .frame(width: screenWidth, height: 30)
        
    }
    
}


#Preview {
    TopInfo(timeFormat: .Format24Hour, busCount: 3, busStatus: .active)
}
