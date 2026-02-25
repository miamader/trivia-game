import SwiftUI

struct ContentView: View {
    
    @State private var amount: String = "10"
    @State private var category: Int = 0
    @State private var difficulty: Double = 1.0
    @State private var type: String = "Any Type"
    @State private var timerDuration: String = "30 seconds"
    

    @State private var questions: [TriviaQuestion] = []
    @State private var isGameActive = false

    let categories = [(name: "Any Category", id: 0), (name: "General Knowledge", id: 9), (name: "Sports", id: 21), (name: "Computers", id: 18)]

    var body: some View {
        NavigationStack {
            ZStack {
                // footer background color
                Color(uiColor: .systemGray6).ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // styled header
                    HeaderView(title: "Trivia Game")
                    
                    VStack {
                        VStack(spacing: 20) {
                            TextField("Amount", text: $amount)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.plain)
                            
                            Divider()
                            
                            Picker("Select Category", selection: $category) {
                                ForEach(categories, id: \.id) { cat in
                                    Text(cat.name).tag(cat.id)
                                }
                            }
                            .pickerStyle(.menu)
                            
                            Divider()
                            
                            VStack(alignment: .leading) {
                                Text("Difficulty: \(difficultyText)")
                                Slider(value: $difficulty, in: 0...2, step: 1)
                            }
                            
                            Divider()
                            
                            Picker("Select Type", selection: $type) {
                                Text("Any Type").tag("Any Type")
                                Text("Multiple Choice").tag("multiple")
                                Text("True / False").tag("boolean")
                            }
                            
                            Divider()
                            
                            Picker("Timer Duration", selection: $timerDuration) {
                                Text("30 seconds").tag("30 seconds")
                                Text("60 seconds").tag("60 seconds")
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 25)
                        .padding(.top, 40)
                        
                        Spacer()
                        
                        // start button
                        Button(action: {
                            Task { await fetchQuestions() }
                        }) {
                            Text("Start Trivia")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(25)
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom, 30)
                    }
                }
                .ignoresSafeArea(edges: .top)
            }
            .navigationDestination(isPresented: $isGameActive) {
                TriviaGameView(questions: questions)
            }
        }
    }
    
    // slider
    var difficultyText: String {
        let options = ["Easy", "Medium", "Hard"]
        return options[Int(difficulty)]
    }

    func fetchQuestions() async {
        let diff = difficultyText.lowercased()
        
       
        let queryAmount = amount.isEmpty ? "10" : amount
        
        var urlComponents = URLComponents(string: "https://opentdb.com/api.php")!
        var queryItems = [
            URLQueryItem(name: "amount", value: queryAmount),
            URLQueryItem(name: "difficulty", value: diff),
            URLQueryItem(name: "type", value: type == "Any Type" ? nil : type)
        ]
        
        if category != 0 {
            queryItems.append(URLQueryItem(name: "category", value: "\(category)"))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 429 {
                print("Rate limited. Wait a few seconds.")
                return
            }

            let decoder = JSONDecoder()
            let triviaResponse = try decoder.decode(TriviaResponse.self, from: data)
            
            
            await MainActor.run {
                self.questions = triviaResponse.results
                if !self.questions.isEmpty {
                    self.isGameActive = true
                }
            }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
    }
}

struct HeaderView: View {
    let title: String
    var body: some View {
        ZStack {
            Color.blue
            Text(title)
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 60)
                .padding(.bottom, 20)
        }
        .frame(height: 150)
    }
}

#Preview {
    ContentView()
}
