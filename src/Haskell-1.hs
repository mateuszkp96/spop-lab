{- SPOP. Lab 1. Nieoceniane -}

import Data.Char  -- funkcja 'toUpper'

{- Zadanie 1. Napisz funkcję, która koduje ciąg znaków alfabetem Morse'a.
Poszczególne znaki wynikowego kodu Morse'a powinny być oddzielone spacją.
Przykład:

ghci> morse "Haskell"
".... .- ... -.- . .-.. .-.."

Wykorzystaj zdefiniowaną niżej listę kodów liter. Znaki spoza tej listy
funkcja powinna ignorować. Funkcja 'toUpper :: Char -> Char' konwertuje
literę na dużą. NIE korzystaj z innych funkcji standardowych (ewentualnie
'fst' i 'snd'). -}

morseCodes = [('A',".-"),('B',"-..."),('C',"-.-."),('D',"-.."),
    ('E',"."),('F',"..-."),('G',"--."),('H',"...."),('I',".."),
    ('J',".---"),('K',"-.-"),('L',".-.."),('M',"--"),('N',"-."),
    ('O',"---"),('P',".--."),('Q',"--.-"),('R',".-."),('S',"..."),
    ('T',"-"),('U',"..-"),('V',"...-"),('W',".--"),('X',"-..-"),
    ('Y',"-.--"),('Z',"--..")]

morse :: String -> String
morse [] = []
morse [x] = getMorseCodeForChar x
morse (x:xs) = (getMorseCodeForChar x) ++ " " ++ morse(xs)

getMorseCodeForChar :: Char -> String
getMorseCodeForChar ch = snd (findTuple (toUpper ch) morseCodes)

findTuple :: Char -> [(Char, String)] -> (Char, String)
findTuple ch []                       = (ch, [ch])
findTuple ch ((x,y):tail) | x == ch   = (x,y)
                          | otherwise = findTuple ch tail

{- Zadanie 2. Napisz funkcję, jak w zadaniu 1, ale w rozwiązaniu
wykorzystaj funkcje standardowe: 'filter', 'map' i 'concat'. -}

morse' :: String -> String
morse' []     = []
morse' [x]    = getStandardMorseCode x
morse' (x:xs) = concat [(getStandardMorseCode x), " ", morse' xs]

getStandardMorseCode :: Char -> String
getStandardMorseCode ch = head (map snd foundTuples)
                          where
                            foundTuples = filter (\(x,_) -> x == (toUpper ch)) morseCodes
{- Sprawdź wartość 'check'. -}

check = morse msg == morse' msg 
msg   = "Houston, mamy problem!" {- A co ze spacjami? :)-}
