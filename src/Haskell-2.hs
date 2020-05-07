{- SPOP. Lab 2. Nieoceniane -}

{- Obiekt w systemie plików jest plikiem o określonej nazwie, lub
katalogiem o określonej nazwie, zawierającym inne obiekty (które są
plikami lub katalogami): -}

data FSObject = File String | Directory String [FSObject] deriving (Eq, Show)

{- Przykładowa wartość: -}

fs :: FSObject
fs = Directory "Root" [(File "root.txt"),
                       (Directory "Tmp" [(File "tmp.txt"),
                                         (File "tmp.exe")
                                        ]),
                       (File "root.exe")
                      ]

{- Zadanie 1. Napisz funkcję, która sprawdza, czy plik o podanej nazwie
istnieje w danym systemie plików. -}

find :: String -> FSObject -> Bool
find name (File filename)       = name == filename
find _ (Directory _ [])         = False
find name (Directory _ list)    = foldr (||) False (map (\fsobj -> find name fsobj) list)

{- Zadanie 2. Napisz funkcję, która szuka pliku o podanej nazwie w danym
systemu plików. Jeśli taki plik istnieje, funkcja zwraca ścieżkę do
tego pliku postaci "nazwa katalogu/nazwa katalogu/.../nazwa pliku". -}

search :: String -> FSObject -> Maybe String
search name (File filename)  | name == filename  = Just filename
                             | otherwise         = Nothing
search _ (Directory _ [])                        = Nothing
search name (Directory dirname list)  =
                      if paths == []              then Nothing
                      else if length paths == 1   then Just (dirname ++ "/" ++ lift (paths !! 0))
                      else error "more than one file"
                      where paths = filter (/=Nothing) (map (\fsobj -> search name fsobj) list)

lift :: Maybe String -> String
lift (Just a) = a