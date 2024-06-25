//
//  DraggableView.swift
//  skkumap
//
//  Created by 조승용 on 2024/05/17.
//
import SwiftUI

// MARK: - Properties
enum SheetPosition: CGFloat {
    case low = 0.78 // 85% down the screen
    case mid = 0.5 // 50% down the screen
    case high = 0.08 // 5% down the screen
}

struct DraggableView: View {
    @Binding var currentPage: Int
    @Binding var sheetPosition: SheetPosition
    @Binding var currentOffset: CGFloat
    
  
    
    @Binding var path: NavigationPath
    
   
    
    
    

    private var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }

    private func calculateOffset() -> CGFloat {
        return screenHeight * sheetPosition.rawValue
    }

    private func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                if (sheetPosition == .high && value.translation.height < 0) ||
                    (sheetPosition == .low && value.translation.height > 0) {
                    return
                }
                currentOffset = value.translation.height
            }
            .onEnded { value in
                withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                    if currentOffset < -10 && sheetPosition != .high {
                        sheetPosition = sheetPosition == .mid ? .high : .mid
                    } else if currentOffset > 10 && sheetPosition != .low {
                        sheetPosition = sheetPosition == .mid ? .low : .mid
                    }
                    currentOffset = 0
                }
            }
    }

    var body: some View {
        VStack(spacing: 0) {
            // 끌어올릴 수 있는 손잡이 부분
            Rectangle()
                .fill(Color.gray)
                .frame(width: 35, height: 4)
                .cornerRadius(5)
                .opacity(0.5)
                .padding(.top)

            Spacer().frame(height: 10)

            VStack(alignment: .leading, spacing: 0) {
                if currentPage == 1 {
                    BusInfoRow(iconName: "flaticon_bus1", mainTitle: "인사캠 셔틀버스", subtitle: "정차소(인문.농구장) ↔ 600주년 기념관", boxText: "성대", themeColor: Color(UIColor.customDeepGreen1))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            path.append(NavigationState.HSSCBus)
                        }
                    BusInfoRow(iconName: "flaticon_bus1", mainTitle: "인자셔틀", subtitle: "인사캠 ↔ 자과캠", boxText: "성대", themeColor: Color(UIColor.customDeepGreen1))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            
                            path.append(NavigationState.campusBus)
                        }
                    BusInfoRow(iconName: "flaticon_bus1", mainTitle: "종로02", subtitle: "성균관대학교 ↔ 종각역YMCA", boxText: "마을", themeColor: .green)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            path.append(NavigationState.Jongro07Bus)
                        }
                    BusInfoRow(iconName: "flaticon_bus1", mainTitle: "종로07", subtitle: "명륜새마을금고 ↔ 명륜새마을금고", boxText: "마을", themeColor: .green)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            path.append("campusbus")
                        }
                    BusInfoRow(iconName: "flaticon_bus1", mainTitle: "종로08", subtitle: "명륜3가 ↔ 명륜5가", boxText: "마을", themeColor: .green)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            path.append(NavigationState.Jongro07Bus)
                        }
                }

                if currentPage == 2 {
                    Text("else page-2")
                }

                if currentPage == 3 {
                    Text("else page-3")
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.cornerRadius(15))
        .offset(y: calculateOffset() + currentOffset)
        .gesture(dragGesture())
    }
}
//
//#Preview {
//    DraggableView()
//}





struct DraggableView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        DraggableView(
            currentPage: .constant(1),
            sheetPosition: .constant(.mid),
            currentOffset: .constant(0), 
            
            path: .constant(NavigationPath())
        )
    }
}
