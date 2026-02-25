import SwiftUI

struct TriviaGameView: View {
    let questions: [TriviaQuestion]
    @Environment(\.dismiss) var dismiss 
    
    @State private var selectedAnswers: [String: String] = [:]
    @State private var showingScore = false
    @State private var score = 0
    
    // Timer State
    @State private var timeRemaining = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 0) {
           
            ZStack {
                HeaderView(title: "Quiz")
                
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20)
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    // Display Time Remaining
                    Text("\(timeRemaining)s")
                        .font(.system(size: 20, weight: .bold).monospacedDigit())
                        .frame(width: 50, alignment: .trailing)
                        .padding(.trailing, 20)
                        .padding(.top, 40)
                }
            }
            
            List(questions, id: \.id) { question in
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text(question.question.decoded)
                        .font(.headline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    ForEach(question.allAnswers, id: \.self) { answer in
                        Button(action: {
                            selectedAnswers[question.question] = answer
                        }) {
                            HStack {
                                Text(answer.decoded)
                                Spacer()
                                
                        
                                Image(systemName: "checkmark.circle.fill")
                                    .opacity(selectedAnswers[question.question] == answer ? 1 : 0)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(.bordered)
                        .tint(selectedAnswers[question.question] == answer ? .green : .blue)
                    }
                }
                .padding(.vertical, 8)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
            Button(action: {
                submitQuiz()
            }) {
                Text("Submit Quiz")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedAnswers.count == questions.count ? Color.blue : Color.gray)
                    .cornerRadius(25)
            }
            .disabled(selectedAnswers.count < questions.count)
            .padding()
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                
                submitQuiz()
            }
        }
        .alert("Quiz Result", isPresented: $showingScore) {
            Button("OK") { dismiss() }
        } message: {
            Text("You scored \(score) out of \(questions.count)!")
        }
    }
    
    func submitQuiz() {
        calculateScore()
        showingScore = true
    }
    
    func calculateScore() {
        var currentScore = 0
        for question in questions {
            if selectedAnswers[question.question] == question.correctAnswer {
                currentScore += 1
            }
        }
        self.score = currentScore
    }
}
