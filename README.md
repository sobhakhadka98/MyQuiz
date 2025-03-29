# Quiz App - Button Selection & Navigation

## Features
This project is a simple quiz app in iOS using Swift and Storyboard. It includes the following functionalities:

- **Shuffled Questions & Answers:** Questions and their respective answers are displayed in a randomized order.
- **Answer Selection with Highlighting:** Users can select an answer, and the selected option is highlighted.
- **Navigation:** Users can move between questions using `Previous` and `Next` buttons, with restrictions on navigation.
- **Score Calculation:** The app calculates and displays the final score at the end of the quiz.
- **Multi-Screen Navigation:** Users can move between multiple screens, including dismissing multiple view controllers at once.

---

## Setup Instructions
### Prerequisites
- Xcode 15+
- iOS 16+ (Deployment Target)
- Swift 5+

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/quiz-app.git
   ```
2. Open the project in Xcode.
3. Run the app on a simulator or device.

---

## Implementation Details

### 1️⃣ **Button Selection with Highlighting**
- Users can select an answer, which updates the button’s **image**.
- When an answer is selected, all other options return to their default state.
- Uses SF Symbols (`circle` and `circle.inset.filled`) for selection indicators.

```swift
var optionButtons: [UIButton] = []

override func viewDidLoad() {
    super.viewDidLoad()
    optionButtons = [option1Button, option2Button, option3Button, option4button]
}

@IBAction func optionSelected(_ sender: UIButton) {
    for button in optionButtons {
        button.isSelected = (button == sender) // Highlight only the selected button
    }
}
```

---

### 2️⃣ **Navigating Between View Controllers**
- `Previous` button is hidden on the first question.
- `Next` button is hidden on the last question.
- `Submit` button appears only on the last question.

```swift
previousButtonOutlet.isHidden = (currentQuestionIndex == 0)
nextButtonOutlet.isHidden = (currentQuestionIndex == questions.count - 1)
finishButtonOutlet.isHidden = (currentQuestionIndex != questions.count - 1)
```

---

### 3️⃣ **Dismissing Multiple View Controllers**
- When the user finishes the quiz and returns, the app dismisses multiple controllers to go back to the start.

```swift
if let navigationController = self.presentingViewController?.presentingViewController as? UINavigationController {
    navigationController.dismiss(animated: true, completion: nil)
}
```

---
