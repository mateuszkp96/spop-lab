{- SPOP. Lab 3. Nieoceniane -}

{- 1. Zdefiniuj klasę typów Stackable zawierającą typy, których wartości
są stosami liczb całkowitych. Typ a jest instancją klasy Stackable,
jeżeli istnieją dla niego operacje:

a)	empty :: a
empty zwraca pusty stos

b)	push :: Int -> a -> a
'push x s' zwraca stos s z wartością x umieszczoną na szczycie

c)	pop :: a -> (Int, a)
'pop s' zwraca parę (x, s’), gdzie x jest szczytową wartością
stosu s, a s’ stosem po jej usunięciu (dla pustego stosu s wynik
operacji jest niezdefiniowany) -}

class Stackable a where
    empty :: a
    push :: Int -> a -> a
    pop :: a -> (Int, a)

{- Następnie stwórz przykładowy własny typ danych (bez parametrów)
reprezentujący stos liczb całkowitych i uczyń go instancją klasy Stackable: -}

data Stack = Stack [Int] deriving (Eq, Show)

instance Stackable Stack where
    empty   = Stack []

    push value (Stack xs) = Stack (value:xs)

    pop (Stack (x:xs)) = (x, Stack xs)
    pop (Stack []) = error "Empty Stack"

{- Sprawdź poprawność implementacji obliczając wartość wyrażenia:

ghci> (fst . pop $ snd . pop $ push 2 $ push 1 $ (empty :: Stack)) == 1
True

-}
