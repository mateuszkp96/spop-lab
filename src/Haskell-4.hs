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
removeStars (x:xs) toRemove 1 = ((x-toRemove) : xs)
removeStars (x:xs) toRemove row = x : (removeStars xs toRemove (row-1))

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
rowNumbers :: [Int]
rowNumbers = [1,2,3,4,5]

printBoard :: Board -> IO ()
printBoard board = putStrLn (displayBoard board)  -- napisz właściwą wersję

displayBoard :: Board -> String
displayBoard a = concat (map toRow (zip rowNumbers a))

toRow :: (Int, Int) -> String
toRow (ord, n) = show ord ++ ": " ++ getNumOfChars n '*' ++ "\n"

getNumOfChars :: Int -> Char -> String
getNumOfChars 0 _     = []
getNumOfChars n char  = [char] ++ getNumOfChars (n - 1) char

data Player = Player1 | Player2 deriving (Eq, Show)

{- Funkcja 'game' realizuje główną pętlę gry:
   1. wyświetl planszę (argument 'board')
   2. wyświetl czyj ruch (argument 'player')
   3. wczytaj i wykonaj ruch
   4  jeśli plansza pusta to ogłoś zwycięzcę. -}

--instance Show Player where
--  show Player1

game :: Board -> Player -> IO ()
game board player = do
    printBoard board
    putStrLn (show player)
    -- dokończ
    input1 <- getLine
    input2 <- getLine
    let row = (read input1 :: Int)
    let toRemove = (read input2 :: Int)
    let board1 = removeStars board toRemove row
    if gameOver board1 then
        putStrLn (show player ++ " win")
        else
            if player == Player1 then
                game board1 Player2
            else
                game board1 Player1


main = game initialBoard Player1
