{- SPOP. Lab 4. Nieoceniane -}

{- Napisz wersję starochińskiej gry "Nim", przyjmując poniższe zasady.

Plansza gry składa się z 5 rzędów gwiazdek:

1: *****
2: ****
3: ***
4: **
5: *

Dwóch graczy na zmianę usuwa jedną lub więcej gwiazdek z wybranego (jednego)
rzędu. Wygrywa ten, który usunie ostatnią gwiazdkę lub gwiazdki z planszy.

Uwaga: Dla uproszczenia przyjmij, że gracze wpisują poprawne wartości podając
       numer rzędu i liczbę gwiazdek. -}

type Board = [Int]

initialBoard :: Board       -- początkowy stan planszy
initialBoard = [5,4,3,2,1]  -- liczba gwiazdek w kolejnych rzędach

{- Funkcja 'removeStars' usuwa z danego rzędu planszy podaną liczbę gwiazdek:

ghci> removeStars initialBoard 1 3
[2,4,3,2,1]

-}

removeStars :: Board -> Int -> Int -> Board
removeStars = undefined

gameOver :: Board -> Bool              -- warunek zakończenia gry
gameOver board = board == [0,0,0,0,0]  -- na planszy nie ma gwiazdek

{- Funkcja 'printBoard' wyświetla podaną planszę:

ghci> printBoard initialBoard
1: *****
2: ****
3: ***
4: **
5: *

-}

printBoard :: Board -> IO ()
printBoard board = putStrLn (show board)  -- napisz właściwą wersję

data Player = Player1 | Player2 deriving Show

{- Funkcja 'game' realizuje główną pętlę gry:
   1. wyświetl planszę (argument 'board')
   2. wyświetl czyj ruch (argument 'player')
   3. wczytaj i wykonaj ruch
   4  jeśli plansza pusta to ogłoś zwycięzcę. -}

game :: Board -> Player -> IO ()
game board player = do
    printBoard board
    putStrLn (show player)
    -- dokończ

main = game initialBoard Player1
