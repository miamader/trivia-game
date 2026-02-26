# Project 5 - *Trivia Game*

Submitted by: **Mia Mader**

**Trivia Game** is an app that allows the user to play a trivia game. They can type in the number of questions they wish to recieve, as well as select the category, difficulty, type of question (mutliple choice or true/false) and the time. After the user finishes answering all questions and presses 'submit', or the time limit runs out, they will be shown how many questions they got right. 

Time spent: **4** hours spent in total

## Required Features

The following **required** functionality is completed:

- [X] App launches to an Options screen where user can modify the types of questions presented when the game starts. Users should be able to choose:
  - [X] Number of questions
  - [X] Category of questions
  - [X] Difficulty of questions
  - [X] Type of questions (Multiple Choice or True False)
- [X] User can tap a button to start trivia game, this presents questions and answers in a List or Card view.
  - Hint: For Card view visit your FlashCard app. List view is an equivalent to UITableView in UIKit. Much easier to use!
- [X] Selected choices are marked as user taps their choice (but answered is not presented yet!)
- [X] User can submit choices and is presented with a score on trivia game
 
The following **optional** features are implemented:

- [ ] User has answer marked as correct or incorrect after submitting choices (alongside their score).
- [X] Implement a timer that puts pressure on the user! Choose any time that works and auto submit choices after the timer expires. 

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<div>
    <a href="https://www.loom.com/share/0d9f9b6a2c704e518f84d4722377f483">
    </a>
    <a href="https://www.loom.com/share/0d9f9b6a2c704e518f84d4722377f483">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/0d9f9b6a2c704e518f84d4722377f483-bf54179ae298e104-full-play.gif#t=0.1">
    </a>
  </div>

## Notes

- I had a bug where the every time the timer ticked down would shift around the answer choices, so I needed to add some code which used .fixedsize so the height would only be calculated once.
- Used the code from the unit 5 lab 'Parks' as a base to fetch information from the API

## License

    Copyright 2026 Mia Mader

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
