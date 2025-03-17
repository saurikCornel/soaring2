import SwiftUI

struct ShopPageThree: View {
    @Binding var playerBalance: Int

    @AppStorage("ownedCards1") private var ownedCards1: String = "firstCardClose" // Используем строку для хранения карт
    @AppStorage("selectedCard1") private var selectedCard1: String = "firstCardClose" // Выбранная карта
    @AppStorage("currentSelectedCloseCard2") private var currentSelectedCloseCard2: String = "hel1" // Новая переменная для хранения closeImage выбранной карты

    @State private var alertMessage: String? // Для хранения текста алерта
    @State private var showAlert: Bool = false // Отображение алерта

    private let cardOptions: [CardOption] = [
        CardOption(id: "hel1", buyImage: "hel1Buy", selectImage: "hel1Select", closeImage: "hel1", selectedImage: "hel1Selected"),
        CardOption(id: "hel2", buyImage: "hel2Buy", selectImage: "hel2Select", closeImage: "hel2", selectedImage: "hel2Selected"),
        CardOption(id: "hel3", buyImage: "hel3Buy", selectImage: "hel3Select", closeImage: "hel3", selectedImage: "frame3Selected"),
        CardOption(id: "hel4", buyImage: "hel4Buy", selectImage: "helSelect", closeImage: "hel4", selectedImage: "hel4Selected")
    ]

    private let cardPrice: Int = 50

    var body: some View {
        VStack(spacing: 10) { // Оборачиваем два HStack в VStack
            // Первый ряд (первые два элемента)
            HStack(spacing: 20) {
                ForEach(Array(cardOptions.prefix(2))) { card in
                    Button(action: {
                        handleCardAction(for: card)
                    }) {
                        Image(currentImage(for: card))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)
                    }
                }
            }
            
            // Второй ряд (последние два элемента)
            HStack(spacing: 20) {
                ForEach(Array(cardOptions.suffix(2))) { card in
                    Button(action: {
                        handleCardAction(for: card)
                    }) {
                        Image(currentImage(for: card))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notification"), message: Text(alertMessage ?? ""), dismissButton: .default(Text("OK")))
        }
    }

    private func currentImage(for card: CardOption) -> String {
        if card.selectedImage == selectedCard1 {
            return card.selectedImage // Отображаем "выбранный" статус
        } else if ownedCards1.contains(card.closeImage) {
            return card.selectImage // Карта куплена, но не выбрана
        } else {
            return card.buyImage // Карта не куплена
        }
    }

    private func handleCardAction(for card: CardOption) {
        if ownedCards1.contains(card.closeImage) {
            // Если карта уже куплена, просто выбираем её
            selectedCard1 = card.selectedImage
            saveCurrentSelectedCloseCard(card.closeImage) // Сохраняем closeImage выбранной карты
            alertMessage = "Card selected successfully!" // Сообщение об успешном выборе карты
        } else if playerBalance >= cardPrice {
            // Покупаем карту
            playerBalance -= cardPrice
            ownedCards1 += "," + card.closeImage // Добавляем карту в список
            selectedCard1 = card.selectedImage
            saveCurrentSelectedCloseCard(card.closeImage) // Сохраняем closeImage выбранной карты
            alertMessage = "Card purchased successfully!" // Сообщение об успешной покупке карты
        } else {
            alertMessage = "Not enough coins to buy this card!" // Сообщение о недостатке монет
        }
        showAlert = true
    }

    private func saveCurrentSelectedCloseCard(_ closeCard: String) {
        currentSelectedCloseCard2 = closeCard // Сохраняем в @AppStorage значение closeImage
    }
}

struct ShopPageTwo: View {
    @Binding var playerBalance: Int

    @AppStorage("ownedCards1") private var ownedCards1: String = "firstCardClose" // Используем строку для хранения карт
    @AppStorage("selectedCard1") private var selectedCard1: String = "firstCardClose" // Выбранная карта
    @AppStorage("currentSelectedCloseCard1") private var currentSelectedCloseCard1: String = "frame"

    @State private var alertMessage: String?
    @State private var showAlert: Bool = false

    private let cardOptions: [CardOption] = [
        CardOption(id: "frame1", buyImage: "frame1Buy", selectImage: "frame1Select", closeImage: "frame", selectedImage: "frame1Selected"),
        CardOption(id: "frame2", buyImage: "frame2Buy", selectImage: "frame2Select", closeImage: "red", selectedImage: "frame2Selected"),
        CardOption(id: "frame3", buyImage: "frame3Buy", selectImage: "frame3Select", closeImage: "blue", selectedImage: "frame3Selected"),
        CardOption(id: "frame4", buyImage: "frame4Buy", selectImage: "frame4Select", closeImage: "green", selectedImage: "frame4Selected")
    ]

    private let cardPrice: Int = 50

    var body: some View {
        VStack(spacing: 10) { // Оборачиваем два HStack в VStack
            // Первый ряд (первые два элемента)
            HStack(spacing: 20) {
                ForEach(Array(cardOptions.prefix(2))) { card in
                    Button(action: {
                        handleCardAction(for: card)
                    }) {
                        Image(currentImage(for: card))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)
                    }
                }
            }
            
            // Второй ряд (последние два элемента)
            HStack(spacing: 20) {
                ForEach(Array(cardOptions.suffix(2))) { card in
                    Button(action: {
                        handleCardAction(for: card)
                    }) {
                        Image(currentImage(for: card))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notification"), message: Text(alertMessage ?? ""), dismissButton: .default(Text("OK")))
        }
    }

    private func currentImage(for card: CardOption) -> String {
        if card.selectedImage == selectedCard1 {
            return card.selectedImage // Отображаем "выбранный" статус
        } else if ownedCards1.contains(card.closeImage) {
            return card.selectImage // Карта куплена, но не выбрана
        } else {
            return card.buyImage // Карта не куплена
        }
    }

    private func handleCardAction(for card: CardOption) {
        if ownedCards1.contains(card.closeImage) {
            // Если карта уже куплена, просто выбираем её
            selectedCard1 = card.selectedImage
            saveCurrentSelectedCloseCard(card.closeImage) // Сохраняем closeImage выбранной карты
            alertMessage = "Card selected successfully!" // Сообщение об успешном выборе карты
        } else if playerBalance >= cardPrice {
            // Покупаем карту
            playerBalance -= cardPrice
            ownedCards1 += "," + card.closeImage // Добавляем карту в список
            selectedCard1 = card.selectedImage
            saveCurrentSelectedCloseCard(card.closeImage) // Сохраняем closeImage выбранной карты
            alertMessage = "Card purchased successfully!" // Сообщение об успешной покупке карты
        } else {
            alertMessage = "Not enough coins to buy this card!" // Сообщение о недостатке монет
        }
        showAlert = true
    }

    private func saveCurrentSelectedCloseCard(_ closeCard: String) {
        currentSelectedCloseCard1 = closeCard // Сохраняем в @AppStorage значение closeImage
    }
}

struct ShopPageOne: View {
    @Binding var playerBalance: Int

    @AppStorage("ownedCards") private var ownedCards: String = "firstCardClose" // Используем строку для хранения карт
    @AppStorage("selectedCard") private var selectedCard: String = "firstCardClose" // Выбранная карта
    @AppStorage("currentSelectedCloseCard10") private var currentSelectedCloseCard10: String = "plane1" // Новая переменная для хранения closeImage выбранной карты

    @State private var alertMessage: String? // Для хранения текста алерта
    @State private var showAlert: Bool = false // Отображение алерта

    private let cardOptions: [CardOption] = [
        CardOption(id: "plane1", buyImage: "plane1Buy", selectImage: "plane1Select", closeImage: "plane1", selectedImage: "plane1Selected"),
        CardOption(id: "plane2", buyImage: "plane2Buy", selectImage: "plane2Select", closeImage: "plane2", selectedImage: "plane2Selected"),
        CardOption(id: "plane3", buyImage: "plane3Buy", selectImage: "plane3Select", closeImage: "plane3", selectedImage: "plane3Selected"),
        CardOption(id: "plane4", buyImage: "plane4Buy", selectImage: "plane4Select", closeImage: "plane4", selectedImage: "plane4Selected")
    ]

    private let cardPrice: Int = 50

    var body: some View {
        VStack(spacing: 10) { // Оборачиваем два HStack в VStack
            // Первый ряд (первые два элемента)
            HStack(spacing: 20) {
                ForEach(Array(cardOptions.prefix(2))) { card in
                    Button(action: {
                        handleCardAction(for: card)
                    }) {
                        Image(currentImage(for: card))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)
                    }
                }
            }
            
            // Второй ряд (последние два элемента)
            HStack(spacing: 20) {
                ForEach(Array(cardOptions.suffix(2))) { card in
                    Button(action: {
                        handleCardAction(for: card)
                    }) {
                        Image(currentImage(for: card))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notification"), message: Text(alertMessage ?? ""), dismissButton: .default(Text("OK")))
        }
    }

    private func currentImage(for card: CardOption) -> String {
        if card.selectedImage == selectedCard {
            return card.selectedImage // Отображаем "выбранный" статус
        } else if ownedCards.contains(card.closeImage) {
            return card.selectImage // Карта куплена, но не выбрана
        } else {
            return card.buyImage // Карта не куплена
        }
    }

    private func handleCardAction(for card: CardOption) {
        if ownedCards.contains(card.closeImage) {
            // Если карта уже куплена, просто выбираем её
            selectedCard = card.selectedImage
            saveCurrentSelectedCloseCard(card.closeImage) // Сохраняем closeImage выбранной карты
            alertMessage = "Card selected successfully!" // Сообщение об успешном выборе карты
        } else if playerBalance >= cardPrice {
            // Покупаем карту
            playerBalance -= cardPrice
            ownedCards += "," + card.closeImage // Добавляем карту в список
            selectedCard = card.selectedImage
            saveCurrentSelectedCloseCard(card.closeImage) // Сохраняем closeImage выбранной карты
            alertMessage = "Card purchased successfully!" // Сообщение об успешной покупке карты
        } else {
            alertMessage = "Not enough coins to buy this card!" // Сообщение о недостатке монет
        }
        showAlert = true
    }

    private func saveCurrentSelectedCloseCard(_ closeCard: String) {
        currentSelectedCloseCard10 = closeCard // Сохраняем в @AppStorage значение closeImage
    }
}

// Основной экран магазина
struct ShopView: View {
    @State private var currentGroupIndex: Int = 0
    @AppStorage("coinscore") private var playerBalance: Int = 10

    var body: some View {
        GeometryReader { geometry in
            ZStack {
               
                VStack {
                    HStack {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                NavGuard.shared.currentScreen = .MENU
                            }
                        Spacer()
                        BalanceTemplate()
                    }
                    Spacer()
                }
                .padding(.top, 10)
                
                Image(currentGroupIndex == 0 ? "shopPlate1" : currentGroupIndex == 1 ? "shopPlate2" : "shopPlate3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 620, height: 360)

                    ZStack {
                        
                        
                        
                        HStack {
                            // Левая стрелка
                            Image("left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .onTapGesture {
                                    withAnimation {
                                        currentGroupIndex = max(0, currentGroupIndex - 1)
                                    }
                                }

                            
                            Spacer()
                            // Правая стрелка
                            Image("right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .onTapGesture {
                                    withAnimation {
                                        currentGroupIndex = min(2, currentGroupIndex + 1)
                                    }
                                }
                        }
                        
                        VStack {
                            
                            
                            

                            HStack {

                                // Отображение текущей страницы
                                if currentGroupIndex == 0 {
                                    ShopPageOne(playerBalance: $playerBalance)
                                }
                                
                                if currentGroupIndex == 1 {
                                    ShopPageTwo(playerBalance: $playerBalance)
                                }
                                
                                if currentGroupIndex == 2 {
                                    ShopPageThree(playerBalance: $playerBalance)
                                }

                               
                            }
                            .padding(.top, 80)
                            

                            // Индикатор текущей страницы
//                            HStack(spacing: 10) {
//                                ForEach(0..<2, id: \.self) { index in
//                                    Circle()
//                                        .fill(index == currentGroupIndex ? Color.white : Color.gray)
//                                        .frame(width: 10, height: 10)
//                                }
//                            }
                        }
                    }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(
                Image(.backgroundShop)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.1)
            )
        }
    }
}

struct CardOption: Identifiable {
    let id: String
    let buyImage: String
    let selectImage: String
    let closeImage: String
    let selectedImage: String // Новое состояние для выбранной карты
}

#Preview {
    ShopView()
}

