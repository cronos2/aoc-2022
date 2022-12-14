{-# LANGUAGE FunctionalDependencies, TemplateHaskell #-}
module Utils.Spatial where

import Lens.Micro.Platform (makeFields)

data Direction
  = L
  | U
  | R
  | D
  deriving (Eq, Show)
data Point2D =
  Point2D
    { _point2DX :: Int
    , _point2DY :: Int
    }
  deriving (Eq, Ord, Show)

$(makeFields ''Point2D)

instance Num Point2D where
  (+) (Point2D a b) (Point2D a' b') = Point2D (a + a') (b + b')
  (*) (Point2D a b) (Point2D a' b') = Point2D (a * a') (b * b')
  (-) (Point2D a b) (Point2D a' b') = Point2D (a - a') (b - b')
  -- these are kinda pointless (*drums*) but required to avoid a warning
  abs (Point2D a b) = Point2D (abs a) (abs b)
  signum (Point2D a b) = Point2D (signum a) (signum b)
  fromInteger n = Point2D (fromInteger n) (fromInteger n)

squaredModulus :: Point2D -> Int
squaredModulus (Point2D x y) = x * x + y * y

move :: Point2D -> Direction -> Point2D
move (Point2D x y) L = Point2D (x - 1) y
move (Point2D x y) U = Point2D x (y + 1)
move (Point2D x y) R = Point2D (x + 1) y
move (Point2D x y) D = Point2D x (y - 1)

vonNeumannNeighbours :: Point2D -> [Point2D]
vonNeumannNeighbours (Point2D x0 y0) =
  [ Point2D (x0 + 1) y0
  , Point2D x0 (y0 + 1)
  , Point2D x0 (y0 - 1)
  , Point2D (x0 - 1) y0
  ]
