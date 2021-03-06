{- Group 9: Algeb-RACE
Design Thinking Project

Dalip Jandir | 400012917
Divya Sridhar | 001411552
Kathryn Kodama | 400013582
Patrick Tsang | 400012566

Problem Definition:
Grade 6-8 students need help understanding the importance of variables and how to manipulate them in an enjoyable manner.

Solution (from Ideation stage):
A racing game where users answer algebra question get closer to the finish line. 
We will have a tutorial on variables before the game starts with multiple choice questions.

Throughout our game, we used Norman's principles to create an application fit for our users.

1) Feedback
We offer feedback to our users when they interact with our game.  Examples of this are clicking buttons to change the page 
(the feedback is the transition to the next page) or "WRONG" displayed when the user selects the wrong answer to a question. 
There is not a single button that can be pressed without feedback being provided.

2) Constraints
We used constraints to limit the possibilities and actions of our users. An example of this is that the game ends when the user
reaches the finish line in the game.  The cars cannot move off the screen.

3) Mapping
We map our controls to the functions available to our users.  We use natural mappings to improve the understanding of our users.
For example, answering questions moves the player's cars upwards on the page, and the multiple choice is placed in a natural order.
The cars are also mapped to their own sides, the player can naturally tell which side is theres.

4) Discoverability
We used discoverability by allowing users to discover the current state of our application. For example, transitioning between pages.
The buttons are made obvious so the user knows exactly what they can press. The current state is also made obvious, nothing is hidden
from the user.

5) Affordance
We afford users the options to perform their desired actions.  For example, changing pages, selecting answers to questions, and 
playing the game again.

6) Signifiers
We use signifiers such as labels, buttons, text, and movement of the cars to convey to the user the affordances available to the user.
The cars are also designed as cars

7) Conceptual Model
Our tutorial pages help aid the users in understanding the conceptual model of our application.  All of the above mentioned principles 
also contribute to the conceptual model of our application. We use the graphics and name of the app to convey that it is indeed a racing
game. Nothing is hidden from the user, they can easily tell what the app allows them to do.
 -}

module Main exposing (..)

-- Imports
import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing(..)
import List
import String
import Dict exposing (Dict)
import Random

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

-- questions list is formatted the following way:
-- question, list of possible answers, which answer is correct (0, 1, or 2)
questions = [ ("3 + x = 20", ("16", "31", "17"), 2), 
              ("2x = 10", ("5", "6", "7"), 0), 
              ("16 / x = 4", ("4", "5", "16"), 0), 
              ("- 1 + x = 2", ("2", "3", "1"), 1),  
              ("3 - x = 20", ("-16", "-31", "-17"), 2), 
              ("5x = 10", ("2", "3", "1"), 0), 
              ("68 - x = 4", ("64", "-64", "-46"), 0), 
              ("x / 2 = 16", ("-8", "32", "16"), 1),
              ("13 - x = 16", ("-7", "-3", "5"), 1),
              ("17 - x = 13", ("0", "4", "6"), 1),
              ("17 + x = 15", ("-12", "-1", "-2"), 2),
              ("15 + x = 19", ("4", "-5", "9"), 0),
              ("15x = 75", ("5", "1", "9"), 0),
              ("18 - x = 6", ("9", "12", "13"), 1),
              ("20 - x = 18", ("-3", "7", "2"), 2),
              ("5 - x = 10", ("-14", "-5", "-3"), 1),
              ("11x = 55", ("5", "0", "10"), 0),
              ("0x = 0", ("3", "1", "6"), 0),
              ("10x = 30", ("-5", "3", "11"), 1),
              ("3x = 9", ("-5", "3", "5"), 1),
              ("10 - x = 6", ("4", "-3", "5"), 0),
              ("8x = 16", ("2", "-2", "5"), 0),
              ("5 + x = 7", ("2", "0", "6"), 0),
              ("12x = 12", ("-9", "3", "1"), 2),
              ("1 + x = 10", ("1", "9", "16"), 1),
              ("19 + x = 0", ("-27", "-19", "-9"), 1),
              ("8 - x = 8", ("-2", "0", "6"), 1),
              ("4x = 8", ("2", "1", "4"), 0),
              ("9 + x = 1", ("-8", "-14", "0"), 0),
              ("4x = 4", ("1", "-4", "5"), 0),
              ("4 + x = 11", ("-3", "7", "13"), 1),
              ("5x = 25", ("-2", "5", "9"), 1),
              ("1 + x = 12", ("11", "1", "12"), 0),
              ("16 + x = 9", ("-12", "-4", "-7"), 2),
              ("8 + x = 2", ("-6", "-12", "-3"), 0),
              ("17 - x = 13", ("-2", "7", "4"), 2),
              ("12x = 36", ("-3", "3", "11"), 1),
              ("5 + x = 18", ("13", "12", "19"), 0),
              ("5 + x = 0", ("-15", "4", "-5"), 2),
              ("1x = 2", ("2", "0", "6"), 0),
              ("2 - x = 7", ("-6", "-5", "-1"), 1),
              ("14 + x = 0", ("-24", "-14", "-11"), 1),
              ("6x = 24", ("-3", "4", "7"), 1),
              ("14 + x = 6", ("-10", "-8", "-1"), 1),
              ("1 + x = 7", ("-2", "9", "6"), 2),
              ("13 + x = 9", ("-9", "4", "-4"), 2),
              ("17x = 68", ("0", "4", "6"), 1),
              ("8 + x = 6", ("-12", "-2", "6"), 1),
              ("2x = 4", ("-3", "4", "2"), 2),
              ("1x = 5", ("4", "5", "15"), 1),
              ("1x = 2", ("0", "11", "2"), 2),
              ("1x = 5", ("5", "1", "6"), 0),
              ("13x = 65", ("-3", "5", "11"), 1),
              ("3x = 6", ("1", "2", "3"), 1),
              ("10 - x = 13", ("-3", "-12", "1"), 0),
              ("10x = 50", ("3", "6", "5"), 2),
              ("15 + x = 9", ("-8", "0", "-6"), 2),
              ("4x = 12", ("3", "1", "6"), 0),
              ("2 + x = 17", ("11", "23", "15"), 2),
              ("20 - x = 17", ("3", "-1", "6"), 0),
              ("9 + x = 7", ("-2", "-3", "0"), 0),
              ("14x = 56", ("-3", "9", "4"), 2),
              ("5 - x = 5", ("0", "-10", "1"), 0),
              ("2 - x = 8", ("-14", "-3", "-6"), 2),
              ("13 - x = 2", ("5", "13", "11"), 2),
              ("2 - x = 9", ("-16", "-4", "-7"), 2),
              ("1 + x = 14", ("13", "3", "19"), 0),
              ("11 - x = 14", ("-4", "-2", "-3"), 2),
              ("14 - x = 5", ("3", "10", "9"), 2),
              ("7 + x = 9", ("-7", "2", "11"), 1),
              ("8 + x = 1", ("-10", "-7", "-1"), 1),
              ("3x = 12", ("3", "4", "7"), 1),
              ("1x = 2", ("-6", "10", "2"), 2),
              ("12x = 48", ("-4", "4", "6"), 1),
              ("12x = 36", ("-1", "3", "12"), 1),
              ("20x = 40", ("-6", "10", "2"), 2),
              ("16x = 32", ("2", "0", "3"), 0),
              ("7 - x = 8", ("-9", "-1", "6"), 1),
              ("18 - x = 0", ("11", "20", "18"), 2),
              ("14 - x = 10", ("1", "6", "4"), 2),
              ("12 - x = 9", ("3", "-2", "8"), 0),
              ("7 - x = 8", ("-1", "-2", "5"), 0),
              ("3 - x = 1", ("-7", "2", "9"), 1),
              ("18x = 18", ("-1", "1", "8"), 1),
              ("13 - x = 14", ("-5", "4", "-1"), 2),
              ("0 + x = 0", ("0", "-1", "9"), 0),
              ("11 - x = 17", ("-6", "-8", "-5"), 0),
              ("5x = 10", ("-2", "2", "6"), 1),
              ("3 - x = 3", ("-8", "9", "0"), 2),
              ("2 + x = 20", ("18", "17", "24"), 0),
              ("8 - x = 6", ("-2", "2", "7"), 1),
              ("6 + x = 13", ("2", "17", "7"), 2),
              ("5x = 10", ("-3", "8", "2"), 2),
              ("17x = 34", ("-4", "11", "2"), 2),
              ("0 + x = 16", ("9", "16", "20"), 1),
              ("0x = 0", ("1", "5", "15"), 1),
              ("12x = 60", ("0", "13", "5"), 2),
              ("17x = 34", ("-5", "7", "2"), 2),
              ("11 - x = 17", ("-14", "-6", "4"), 1),
              ("13x = 52", ("4", "1", "9"), 0),
              ("1 + x = 12", ("5", "13", "11"), 2),
              ("8x = 32", ("-2", "4", "5"), 1),
              ("2 + x = 16", ("6", "18", "14"), 2),
              ("4x = 4", ("1", "-2", "4"), 0),
              ("12 - x = 4", ("0", "8", "16"), 1),
              ("12 + x = 20", ("3", "8", "9"), 1),
              ("10 + x = 20", ("7", "10", "18"), 1),
              ("20 + x = 19", ("-1", "-11", "3"), 0)]

-- possible pages: Main Menu, Tutorial, Play Game, Game Over
myShapes model = let 
                   playerPos = model.playerPos
                   oppPos = model.oppPos
                   page = model.currentPage
                   currQ = model.currentQuestion
                   direction = model.direction

                   blockA = model.blockA
                   blockB = model.blockB
                   blockC = model.blockC
                 in
                 [ square 300 |> filled green]
                 ++
                   [
                   if page == "Main Menu" then -- Main Menu page
                     group
                       [ 
                        circle 60 |> outlined (solid 20) darkGray
                        , circle 60 |> outlined (dashed 1) yellow
                        , if model.direction == "left" -- easter egg to switch the cars position on the main menu page when the title is selected
                            then
                            group
                            [
                              -- graphics for the Main Menu page to move cars around
                              redCar |> scale 0.25 |> move (sin -model.time*53 , cos -model.time*53)
                            , blueCar |> scale 0.25 |> move (sin model.time*65 , cos model.time*65)
                            ]
                          else
                            group
                            [
                              redCar |> scale 0.25 |> move (sin model.time*53 , cos model.time*53)
                            , blueCar |> scale 0.25 |> move (sin -model.time*65 , cos -model.time*65)
                            ]
                        , rect 62 12 |> filled (lightBlue) |> move (0, 5) |> notifyTap (ChangePage "Play Game")
                        , rect 62 12 |> filled (lightBlue) |> move (0, -9) |> notifyTap (ChangePage "Tutorial")
                        , rect 62 12 |> filled (lightBlue) |> move (0, -23) |> notifyTap (ChangePage "Algebra")
                        , text "ALGEB-RACE" |> centered |> sansserif |> bold |> underline |> filled white |> move (0, 20) |> notifyTap (ChangeDir)
                        , text "START" |> centered |> sansserif |> size 7 |> filled white |> move ( 0, 2) |> notifyTap (ChangePage "Play Game")
                        , text "HOW TO PLAY" |> centered |> sansserif |> size 7 |> filled white |> move ( 0, -12) |> notifyTap (ChangePage "Tutorial")
                        , text "ALGEBRA BASICS" |> centered |> sansserif |> size 6.5 |> filled white |> move ( 0, -26) |> notifyTap (ChangePage "Algebra")
                       ]
                   else if page == "Tutorial" then -- How to Play Tutorial page
                     group 
                       [ text "How To Play" |> centered |> sansserif |> bold |> underline |> filled white |> move (0, 50)
                         , text "- Solve for x in each question" |> sansserif |> size 6 |> filled (rgb 100 0 100) |> move (-60,35)
                         , text "- Click the correct answer to make the red car move" |> sansserif |> size 6 |> filled (rgb 100 0 100) |> move (-60,25)
                         , text "- Answer fast before the blue car wins!" |> sansserif |> size 6 |> filled (rgb 100 0 100) |> move (-60,15)
                         , text "- Be careful! A wrong answer will move you backwards" |> sansserif |> size 6 |> filled (rgb 100 0 100) |> move (-60,5)
                         , mainMenuButton |> move (0, -30) |> notifyTap (ChangePage "Main Menu")
                       ]
                   else if page == "Algebra" then -- Algebra tutorial page
                     group
                       [ text "Adding and subtracting algebraic expressions:" |> sansserif |> size 5 |> filled (rgb 100 0 100) |> move (-70,40)
                         , text "- Isolate for x! For example:" |> sansserif |> size 4 |> filled (rgb 100 0 100) |> move (-65,33)
                         , text "x + 2 = 6" |> sansserif |> size 5 |> filled (rgb 100 0 100) |> move (-15,26)
                         , text "x + 2 - 2 = 6 - 2" |> sansserif |> size 5 |> filled (rgb 100 0 120) |> move (-22,20)
                         , text "x = 4" |> sansserif |> size 5 |> filled red |> move (-6,14)
                         , text "Multiplying and dividing algebraic expressions:" |> sansserif |> size 5 |> filled (rgb 100 0 120) |> move (-70,5)
                         , text "- Do the same, isolate for x! For example:" |> sansserif |> size 4 |> filled (rgb 100 0 100) |> move (-65,-2)
                         , text "3x = 15" |> sansserif |> size 5 |> filled (rgb 100 0 100) |> move (-15,-9)
                         , text "3x ÷ 3 = 15 ÷ 3" |> sansserif |> size 5 |> filled (rgb 100 0 120) |> move (-23,-15)
                         , text "x = 5" |> sansserif |> size 5 |> filled red |> move (-12,-21)
                         , mainMenuButton |> move (40, -35) |> notifyTap (ChangePage "Main Menu")
                       ]
                   else if page == "Game Over" then -- Game Over page
                    group
                      [
                        rect 300 10 |> filled (lightGray)
                        , if model.winner == "red" then 
                        -- You win page
                          group [
                            text "You Win! :)" |> sansserif |> centered |> filled red |> move (0, 25)
                            , redCar |> scale 0.25 |> move (sin model.time*53 , 0)
                          ]
                        else 
                          group [
                            -- You lose page
                            text "You Lose :(" |> sansserif |> centered |> filled blue |> move (0, 25)
                            , blueCar |> scale 0.25 |> move (sin model.time*53 , 0)
                          ]
                        -- options to redirect back to the Play Game or Main Menu page
                        , playAgainButton |> move (-40, -30) |> notifyTap (ChangePage "Play Game")
                        , mainMenuButton |> move (40, -30) |> notifyTap (ChangePage "Main Menu")
                      ]
                   else -- Play Game page
                     group
                       [ rect 20 200 |> filled (lightGray) |> move (70, 0)
                         , rect 20 200 |> filled (lightGray) |> move (-70, 0)
                         , finishLine |> move (0, 50)
                         , redCar |> rotate(degrees 90) |> scale 0.25 |> move (playerPos) 
                         , blueCar |> rotate(degrees -90) |> scale 0.25 |> move (oppPos)
                         , question currQ
                         , wrongAnswer blockA blockB blockC
                         ]
                 ]

-- helper method to display questions                
question (q, (a, b, c), correct) = group
                  [ text (q) |> centered |> filled (black) |> move (0, 20) 
                  , if correct == 0 then --Option A correct
                  group
                    [ questionButton a|> move (0, 0) |> notifyTap (UpdatePos)
                   , questionButton b |> move (0, -15) |> notifyTap (WrongAnswer "b")
                   , questionButton c |> move (0, -30) |> notifyTap (WrongAnswer "c")
                  ] 
                  else if correct == 1  then  --Option B correct
                  group 
                    [questionButton a |> move (0, 0) |> notifyTap (WrongAnswer "a")
                   , questionButton b |> move (0, -15) |> notifyTap (UpdatePos)
                   , questionButton c |> move (0, -30) |> notifyTap (WrongAnswer "c")
                  ]
                  else --Option C correct
                  group 
                    [questionButton a |> move (0, 0) |> notifyTap (WrongAnswer "a")
                   , questionButton b |> move (0, -15) |> notifyTap (WrongAnswer "b")
                   , questionButton c |> move (0, -30) |> notifyTap (UpdatePos)
                  ]
                  ]

-- helper method to indicate to the user when they select the wrong answer (Feedback)
wrongAnswer blockA blockB blockC = group
              [ if blockA == True
                  then
                    questionBlock
                else
                  group []

                ,if blockB == True
                  then
                    questionBlock |> move(0, -15)
                else
                  group []

                ,if blockC == True 
                  then
                    questionBlock |> move(0, -30)
                else
                  group []
               ]

-- red car, used the car on the Elm demo page as a template
redCar = group   
         [ roundedRect 100 25 20
            |> filled red
        , wedge 30 0.5
            |> filled red
            |> rotate (degrees 90)
            |> move (0,8)
        , circle 10
            |> filled black
            |> move(-20,-10)
        , circle 10
            |> filled black
            |> move(20,-10)
        , wedge 20 0.5
            |> filled white
            |> rotate (degrees 90)
            |> move(0,12)
        , circle 5
            |> filled white
            |> move(20,-10)
        , circle 5
            |> filled white
            |> move(-20,-10)
        ]

-- blue car, used the car on the Elm demo page as a template
blueCar = group 
          [  roundedRect 100 25 20
            |> filled blue
        , wedge 30 0.5
            |> filled blue
            |> rotate (degrees 90)
            |> move (0,8)
        , circle 10
            |> filled black
            |> move(-20,-10)
        , circle 10
            |> filled black
            |> move(20,-10)
        , wedge 20 0.5
            |> filled white
            |> rotate (degrees 90)
            |> move(0,12)
        , circle 5
            |> filled white
            |> move(20,-10)
        , circle 5
            |> filled white
            |> move(-20,-10)
          ]

-- finish line on the game page, user wins when their car passes the finish line
finishLine = group 
              [ rect 500 3 |> filled (black)
                , text ("FINISH!") |> sansserif |> size 10 |> centered |> filled black  |> move(0,5) 
              ]

-- Play again button to redirect back to Play Game button             
playAgainButton = group
              [ rect 62 12 |> filled (lightBlue)
              , text ("Play again") |> sansserif |> size 8 |> centered |> filled white |> move (0, -2)
              ]

-- Main Menu button
mainMenuButton = group
              [ rect 62 12 |> filled (lightBlue)
              , text ("Main Menu") |> sansserif |> size 8 |> centered |> filled white |> move (0, -2)
              ]

-- button to display the possible question solutions
questionButton answer = group
                      [ rect 30 10 |> filled grey
                      , text (answer) |> sansserif |> size 8 |> centered |> filled black |> move (0, -2)]

-- block to display when a possible answer is wrong
questionBlock = group
                      [ rect 30 10 |> filled green
                      , text "WRONG!" |> sansserif |> size 8 |> centered |> filled red |> move (0, -2)]   
               

-- Possible msg types for update function
type Msg = Tick Float GetKeyState | UpdatePos | WrongAnswer String | ChangePage String | ChangeDir

update msg model = case msg of
                     Tick t _ -> let -- Time update (updates player position and randomness)
                                   (oppX, oppY) = model.oppPos
                                   (playerX, playerY) = model.playerPos
                                   currentPage = model.currentPage
                                   oldDrop = model.drop
                                 in
                                 -- if oppPos y value has passed finish line (50), user loses
                                 if currentPage == "Play Game" then 
                                   if oppY > 50
                                     then
                                       { model | time = t
                                             , oppPos = (oppX, 50)
                                             , winner = "blue"
                                             , currentPage = "Game Over"
                                       }
                                     else if playerY > 50 
                                       then 
                                         { model | time = t
                                               , winner = "red"
                                               , currentPage = "Game Over"
                                         }
                                     else 
                                        if (oldDrop >= 100) 
                                           then
                                               { model | time = t
                                                     , oppPos = (oppX , oppY + 0.1)
                                                     , drop = 1
                                               }
                                        else 
                                              { model | time = t
                                                   , oppPos = (oppX , oppY + 0.1)
                                                   , drop = oldDrop + 1
                                              }
                                  else 
                                      if (oldDrop >= 100) 
                                           then
                                               { model | time = t
                                                     , drop = 1
                                               }
                                        else 
                                              { model | time = t
                                                   , drop = oldDrop + 1
                                              }

                     -- update the player position and cycle to a new question             
                     UpdatePos -> let 
                                        (x, y) = model.playerPos
                                      in 
                                      { model | playerPos = (-70, y + 35)
                                      , currentQuestion =  Maybe.withDefault ("x + 4 = 10", ("-2", "-6", "6"), 2) <| List.head <| List.drop model.drop model.questions
                                      , questions = List.drop 1 model.questions
                                      , blockA = False, blockB = False, blockC = False
                                      }

                    -- update positions when the wrong answer is selected to move the player back a space
                     WrongAnswer ans -> let (x, y) = model.playerPos in 
                                        if y > -50 then 
                                          if ans == "a"
                                          then {model | blockA = True, playerPos = (-70, y - 35)}
                                          else if ans == "b"
                                            then {model | blockB = True, playerPos = (-70, y - 35)}
                                          else
                                            {model | blockC = True, playerPos = (-70, y - 35)}

                                        -- if the player is still at the starting space, do not move them back (else they would move off the screen)
                                        else 
                                          if ans == "a"
                                            then {model | blockA = True, playerPos = (-70, y)}
                                          else if ans == "b"
                                            then {model | blockB = True, playerPos = (-70, y)}
                                          else
                                            {model | blockC = True, playerPos = (-70, y)}          
                     
                     -- change page to the page specified                  
                     ChangePage page -> if page == "Play Game" 
                                        -- if playing the game again, reset all values
                                         then
                                           { model | currentPage = page
                                           , playerPos = (-70, -50)
                                           , oppPos = (70, -50)
                                           , winner = " "
                                           , questions = questions
                                           , blockA = False
                                           , blockB = False
                                           , blockC = False}
                                         else
                                           { model | currentPage = page }

                    -- easter egg to change the direction of the cars animation on the front page
                     ChangeDir -> if model.direction == "left"
                                        then 
                                          { model | direction = "right" }
                                        else 
                                          { model | direction = "left" }

-- initialize values to start with
init = { time = 0
         , playerPos = (-70, -50)
         , oppPos = (70, -50)
         , winner = " "
         , currentPage = "Main Menu" -- start on the Main Menu page
         , questions = questions
         , blockA = False
         , blockB = False
         , blockC = False
         , direction = "right"
         , drop = 1
         , currentQuestion = Maybe.withDefault ("0", ("0", "0", "0"), 0) <| List.head questions
         }