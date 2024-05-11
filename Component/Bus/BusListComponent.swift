//
//  HSSCBusListComponentView.swift
//  skkumap
//
//  Created by 조승용 on 2023/12/31.
//

import SwiftUI

struct HSSCBusListComponentView: View {
    let stationName: String
    let stationNumber: String
    let eta: String
    let isFirstStation: Bool
    let isLastStation: Bool
    let isRotationStation: Bool
    
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 23) {
                
                // 좌측 도형 UI
                VStack {
                    Rectangle()
                        .fill(isFirstStation==true ? Color.white : Color.green)
                        .frame(width: 2, height: 26)
                    
                    Group {
                        if isRotationStation {
                            ZStack{
                                Capsule()
                                    .strokeBorder(Color.green, lineWidth: 1)
                                    .background(Color.white)
                                    .frame(width: 40, height: 20)
                                HStack(spacing: 0) {
                                    Text("회차")
                                        .font(.system(size: 9, weight: .bold))
                                        .foregroundColor(Color.green)
                                    Image(systemName: "arrow.uturn.down")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(.green)
                                        .scaleEffect(x: -1, y: 1)
                                    
                                }
                                
                                
                            }.frame(height: 5)
                        } else {
                            ZStack{
                                Circle()
                                    .strokeBorder(Color.green, lineWidth: 1)
                                    .background(Circle().foregroundColor(Color.white))
                                    .frame(width: 14, height: 14)
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 8, weight: .medium))
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .frame(width: 20)
                    
                    
                    Rectangle()
                        .fill(isLastStation==true ? Color.white : Color.green)
                        .frame(width: 2, height: 26)
                }.frame(height: 66)
                
                // 우측 글자 UI
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 3) {
                        Text(stationName)
                            .font(.system(size: 15, weight: .medium))
                            
                        if(stationName == "혜화역4번출구" || stationName == "혜화역1번출구" || stationName == "혜화역.마로니에공원") {
                            CircleIcon(text: "4")
//                                .frame(width: 10, height: 10)
                        }
                    }
                   
                    HStack(spacing: 4.5) {
                        Text(stationNumber)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(Color.gray)
                        Text("|")
                            .font(.system(size: 9, weight: .medium))
                            .opacity(0.3)
                            .foregroundColor(Color.gray)
                        Text(eta)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color.gray)
                        
                    }
                }.frame(height: 66)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    
                
            }
            .frame(height: 66)
            .padding(.leading, BusConstants.BusMainLeftSpace)
            .padding(.trailing, 15)
        }
        // 버스 역 구분선
        .overlay {
            VStack {
                Spacer()
                isLastStation == false ?
                Rectangle()
                    .fill(Color.gray)
                    .opacity(0.4)
                    .frame(height: 0.5)
                    .padding(.leading, BusConstants.BusMainLeftSpace + 10)
                : nil
            }
            
        }
    }
}

#Preview {
    HSSCBusListComponentView(stationName: "혜화역1번출구", stationNumber: "01504", eta: "1번째 전", isFirstStation: false, isLastStation: false, isRotationStation: false)
}
