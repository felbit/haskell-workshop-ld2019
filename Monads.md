# Monads

```hs
f :: * -> *
-- [], Maybe, Either e, IO ... 
-- all examples need another Type to be complete

class Functor f where
    fmap :: (a -> b) -> f a -> f b
-- the '->' is right associative
-- (<$>) = fmap
class Functor f => Applicative f where
    (<*>) :: f (a -> b) -> f a -> f b

-- e.g.
(*3) <$> [1,2,3] -- [3,6,9]
(*) <$> [1,2,3]  -- [(1*), (2*), (3*)] (but cannot be printed by GHC)
(*) <$> [1,2,3] <*> [10,20,30]  -- [10,20,30,20,40,60,30,60,90]

-- and the Monad
class Applicative f => Monad f where
    (>>=) :: f a -> (a -> f b) -> f b

-- (=<<) :: (a -> f b) -> f a -> f b
```
