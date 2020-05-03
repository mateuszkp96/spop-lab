{- SPOP. Lab 0. Nieoceniane -}

import Data.Char  -- funkcje 'ord' i 'chr' do zadania 5.

{- Zadanie 1. Napisz funkcję, która zwraca środkowy element podanej listy.
Wykorzystaj funkcje standardowe: 'div' i 'length' oraz operator (!!). Przykład:

ghci> middle "Haskell"
'k'
-}

middle :: [a] -> a
middle list = list !! (length list `div` 2)

{- Zadanie 2. Napisz funkcję, która usuwa z listy występujące bezpośrednio
po sobie duplikaty danego elementu. Nie korzystaj z funkcji standardowych.
Przykład:

ghci> removeDuplicates [9, 3, 3, 3, 4, 5, 5, 3, 5]
[9,3,4,5,3,5]

Wskazówka: spójrz na definicję funkcji 'maximum' z wykładu. -}

removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [x]                    = [x]
removeDuplicates (x:y:ys) | x == y      = removeDuplicates(x:ys)
                          | otherwise   = x : removeDuplicates(y:ys)

{- Zadanie 3. Napisz funkcję, która wstawia do danej listy nowy element
na podanej pozycji. Nie korzystaj z funkcji standardowych. Przykład:

ghci> insertAt "askell" 'H' 0
"Haskell"

Wskazówka: por. z definicją operatora (!!) z wykładu
-}

insertAt :: [a] -> a -> Int -> [a]
insertAt xs element 0       = element : xs
insertAt (x:xs) element i   = x : insertAt xs element (i - 1)

{- Zadanie 4. Napisz funkcję, która usuwa z listy wszystkie występujące
dalej duplikaty poszczególnych elementów. Przykład:

ghci> removeAllDuplicates [9, 3, 3, 3, 4, 5, 5, 3, 5]
[9,3,4,5]

Wskazówka: spójrz na definicję funkcji 'reverse' z wykładu. W akumulatorze
przechowuj elementy napotykane po raz pierwszy. Użyj funkcji 'elem' do
sprawdzenia, czy element jest już w akumulatorze. -}

removeAllDuplicates :: Eq a => [a] -> [a]
removeAllDuplicates list =  remDuplicates list []
                            where remDuplicates [] acc  = acc
                                  remDuplicates (x:xs) acc
                                    | x `elem` acc      = remDuplicates xs acc
                                    | otherwise         = remDuplicates xs (acc ++ [x])

{- Zadanie 5. Zadanie dotyczy szyfrowania tekstów. Prosty kod Cezara polega
na tym, że w miejsce danej litery wstawiamy literę o kodzie większym np.
o 3 (liczbę tę nazywamy kluczem w kodzie Cezara). Końcowe litery alfabetu
zastępujemy literami z początku alfabetu. Np. w miejsce 'A' wstawiamy 'D',
w miejsce 'X' wstawiamy 'A'. Napisz dwie funkcje, które odpowiednio kodują
i dekodują napis szyfrem Cezara o podanym kluczu. Przykład:

ghci> codeCezar "Koty" 3
"Nrwb"
ghci> decodeCezar "Nrwb" 3
"Koty"

Wskazówka: kod ASCII danego znaku zwraca funkcja 'ord :: Char -> Int', natomiast
znak odpowiadający podanemu kodowi ASCII zwraca funkcja 'chr :: Int -> Char'.
Przykład:

ghci> ord 'A'
65
ghci> chr 65
'A' -}

codeCezar :: String -> Int -> String
codeCezar [] n        = []
codeCezar (x:xs) n    = charWithOffset x n : codeCezar xs n

decodeCezar :: String -> Int -> String
decodeCezar [] n        = []
decodeCezar (x:xs) n    = charWithOffset x (-1 * n) : codeCezar xs (-1 * n)

charWithOffset :: Char -> Int -> Char
charWithOffset ch offset  | charInRange ch 'a' 'z' = chr (codeWithOffsetWithinRange (ord ch) offset (ord 'a') (ord 'z'))
                          | charInRange ch 'A' 'Z' = chr (codeWithOffsetWithinRange (ord ch) offset (ord 'A') (ord 'Z'))

charInRange :: Char -> Char -> Char -> Bool
charInRange ch r1 r2  = a <= n && n <= b
                        where n = ord ch
                              a = ord r1
                              b = ord r2

codeWithOffsetWithinRange :: Int -> Int -> Int -> Int -> Int
codeWithOffsetWithinRange code offset r1 r2 | (code + offset) > r2    = codeWithOffsetWithinRange r1 ((code + offset) - r2 - 1) r1 r2
                                            | (code + offset) < r1    = codeWithOffsetWithinRange r2 ((code + offset) - r1 + 1) r1 r2
                                            | otherwise               = code + offset


