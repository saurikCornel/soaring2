import SwiftUI

struct DailyBonus: View {
    @AppStorage("lastSpinTime") private var lastSpinTime: Double = 0
    @State private var isSpinning = false
    @State private var rotationAngle: Double = 0
    @State private var showPrize = false
    @State private var showWaitMessage = false
    @State private var remainingTime: String = ""
    @AppStorage("coinscore") var coinscore: Int = 10
    
    private var canSpin: Bool {
        let currentTime = Date().timeIntervalSince1970
        return currentTime - lastSpinTime > 86400
    }
    
    private func updateRemainingTime() {
        let currentTime = Date().timeIntervalSince1970
        let timeLeft = 86400 - (currentTime - lastSpinTime)
        if timeLeft > 0 {
            let hours = Int(timeLeft) / 3600
            let minutes = (Int(timeLeft) % 3600) / 60
            remainingTime = String(format: "%02d:%02d", hours, minutes)
        } else {
            remainingTime = "00:00"
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Фон и элементы интерфейса
                ZStack {
                    VStack {
                        HStack {
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(.top, 60)
                                .padding()
                                .foregroundStyle(.white)
                                .onTapGesture {
                                    NavGuard.shared.currentScreen = .MENU
                                }
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    VStack(spacing: -30) {
                        Image(.wheel)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .overlay(
                                Image(.rulet)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .rotationEffect(.degrees(rotationAngle))
                                    .animation(.easeOut(duration: 6), value: rotationAngle)
                            )
                        
                        Image(.spinBtn)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .disabled(isSpinning)
                            .opacity(isSpinning ? 0.5 : 1.0)
                            .onTapGesture {
                                if canSpin && !isSpinning {
                                    isSpinning = true
                                    rotationAngle += 3600
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) { // Устанавливаем 6 секунд, как у анимации
                                        isSpinning = false
                                        coinscore += 5
                                        showPrize = true
                                        lastSpinTime = Date().timeIntervalSince1970
                                        print("Prize should show now, showPrize = \(showPrize)") // Отладка
                                    }
                                } else if !canSpin {
                                    updateRemainingTime()
                                    showWaitMessage = true
                                }
                            }
                    }
                    .padding(.top, 130)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                // Окно с призом
                if showPrize {
                    WinViewLevel4()
                        .zIndex(1)
                        .transition(.opacity) // Добавляем анимацию появления
                        .animation(.easeInOut, value: showPrize) // Плавное появление
                }
                
                // Окно с ожиданием
                if showWaitMessage {
                    Text("You can open it in \(remainingTime)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .onTapGesture {
                            showWaitMessage = false
                        }
                        .zIndex(1)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(
                Image(.backgroundDaily)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.1)
            )
        }
    }
}

struct WinViewLevel4: View {
    @AppStorage("coinscore") var coinscore: Int = 10

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.winView)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .scaleEffect(1.22)
                    .onTapGesture {
                        coinscore += 10
                        NavGuard.shared.currentScreen = .MENU
                    }
            }
        }
    }
}

#Preview {
    DailyBonus()
}
