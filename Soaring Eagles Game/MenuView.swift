import SwiftUI

struct MenuView: View {
    

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                    ZStack {
                        VStack {
                            HStack {
                                ButtonTemplateSmall(image: "dailytrue", action: {NavGuard.shared.currentScreen = .BONUS})
                                Spacer()
                            }
                            Spacer()
                        }
                        VStack(spacing: -30) {
                            
                            HStack(spacing: 20) {
                                ButtonTemplateBig(image: "playBtn1", action: {NavGuard.shared.currentScreen = .LEVELS})
                                ButtonTemplateBig(image: "styleBtn1", action: {NavGuard.shared.currentScreen = .STYLE})
                                    .padding(.top, 100)
                                ButtonTemplateBig(image: "achiveBtn", action: {NavGuard.shared.currentScreen = .ACHIVE})
                                ButtonTemplateBig(image: "shopBtn", action: {NavGuard.shared.currentScreen = .SHOP})
                                    .padding(.top, 100)
                                ButtonTemplateBig(image: "rulesBtn", action: {NavGuard.shared.currentScreen = .RULES})
                                ButtonTemplateBig(image: "settingsBtn1", action: {NavGuard.shared.currentScreen = .SETTINGS})
                                    .padding(.top, 100)
                            }
                            .padding(.top, 80)

                            }
                    }
                    
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(
                Image(.backgroundMenu)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.1)
            )
            

        }
    }
}




struct BalanceTemplate: View {
    @AppStorage("coinscore") var coinscore: Int = 10
    var body: some View {
        ZStack {
            Image("balanceTemplate")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 70)
                .overlay(
                    ZStack {
                            Text("\(coinscore)")
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .font(.title3)
                            .position(x: 80, y: 35)
                        
                    }
                )
        }
    }
}


struct ButtonTemplateSmall: View {
    var image: String
    var action: () -> Void

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 80)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        }
    }
}

struct ButtonTemplateBig: View {
    var image: String
    var action: () -> Void

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 110, height: 110)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        }
    }
}



#Preview {
    MenuView()
}

