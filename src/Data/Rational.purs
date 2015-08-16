module Data.Rational
  ( Rational()
  , (%)
  , numerator
  , denominator
  , toNumber
  , fromInt
  ) where

import Prelude
import qualified Data.Int as Int

data Rational = Rational Int Int

instance showRational :: Show Rational where
  show (Rational a b) = "Rational " ++ show a ++ " " ++ show b

instance semiringRational :: Semiring Rational where
  one = Rational 1 1
  mul (Rational a b) (Rational c d) = reduce $ Rational (a * c) (b * d)
  zero = Rational 0 1
  add (Rational a b) (Rational c d) = reduce $ Rational ((a * d) + (b * c)) (b * d)

instance ringRational :: Ring Rational where
  sub (Rational a b) (Rational c d) = reduce $ Rational ((a * d) - (b * c)) (b * d)

instance eqRational :: Eq Rational where
  eq p q = numerator (reduce p) == numerator (reduce q) && denominator (reduce p) == denominator (reduce q)

instance eqRational :: Eq Rational where
  eq p q = numerator (reduce p) == numerator (reduce q) && denominator (reduce p) == denominator (reduce q)

infixl 7 %

(%) :: Int -> Int -> Rational
(%) m n = reduce $ Rational m n

numerator :: Rational -> Int
numerator (Rational a _) = a

denominator :: Rational -> Int
denominator (Rational _ b) = b

toNumber :: Rational -> Number
toNumber (Rational a b) = Int.toNumber a / Int.toNumber b

fromInt :: Int -> Rational
fromInt i = Rational i 1

reduce :: Rational -> Rational
reduce (Rational a b) = Rational (a `div` gcd a b) (b `div` gcd a b)
  where
    gcd :: Int -> Int -> Int
    gcd m n
      | n == 0 = m
      | otherwise = gcd n (m `mod` n)
