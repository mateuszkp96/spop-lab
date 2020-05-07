

--data List a = Empty | Cons a (List a) deriving Show
--
--sorted :: Ord a => List a -> Bool
--sorted Empty = True
--sorted (Cons head Empty) = True
--sorted (Cons head (Cons head2 list)) | head < head2 = sorted (Cons head2 list)
--                                     | otherwise    = False
--
--ls = Cons 1 (Cons 2 (Cons 3 Empty))
--ls1 = Cons 1 (Cons 3 (Cons 2 Empty))
--ls2 = Cons 1 (Cons 2 (Cons 3 (Cons 4 Empty)))
--ls3 = Cons 1 (Empty)

data Nat = Zero | Succ Nat deriving (Eq, Show)

sub :: Nat -> Nat -> Nat
sub Zero Zero    = Zero
sub x Zero       = x
sub (Succ x) y   | Succ x == y  = Zero
                 | otherwise    = Succ (sub x y)

n0 = Zero
n1 = Succ Zero
n2 = Succ (Succ Zero)
n3 = Succ (Succ (Succ Zero))

sb1 = sub n1 n0
sb2 = sub n2 n1
sb3 = sub n3 n1

add :: Nat -> Nat -> Nat
add Zero  n     = n
add (Succ m) n  = Succ (add m n)

mult :: Nat -> Nat -> Nat
mult Zero _ = Zero
mult _ Zero = Zero
mult (Succ m) n = add (mult m n) n

ad1 = mult n1 n0
ad2 = mult n2 n1
ad3 = mult n2 n3

split :: [a] -> (a -> Bool) -> ([a],[a])
split xs pred = (a,b)
    where a = [x | x <-xs, pred x]
          b = [x | x <-xs, not (pred x)]

split2 :: [a] ->([a],[a])
split2 [] = ([],[])
split2 [x] = ([x],[])
split2 (x:y:ys) = (x:a, y:b)
                 where (a,b) = split2 ys

data Tree a = Empty | Node a (Tree a) (Tree a)

t = Node 6 (Node 4 (Node 1 Empty Empty)
                   (Node 5 Empty Empty))
           (Node 7 Empty
                   (Node 6 Empty Empty))

isBST :: Ord a => Tree a -> Bool
isBST Empty                = True
isBST (Node p Empty Empty) = True
isBST (Node p (Node ch l r) Empty) = p >= ch && isBST (Node ch l r)
isBST (Node p Empty (Node ch l r)) = p <= ch && isBST (Node ch l r)
isBST (Node p (Node chl ll rl) (Node chr lr rr)) = p >= chl && p <= chr && (isBST (Node chl ll rl)) && (isBST (Node chr lr rr))

bs = isBST t
