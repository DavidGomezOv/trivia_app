# trivia_app

This is a simple Trivia - Quizz application based on BloC-Cubit architecture and using the Open Trivia Database: "https://opentdb.com"

## Getting Started

- Generate necessary files executing the codegen.sh file located in the root folder

## Deployment

- Build flutter web app:
    - flutter build web --web-renderer html --release
- Remove the "<base href="/">" piece of code located in root>build>web>index.html
