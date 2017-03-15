{-# LANGUAGE ExplicitForAll #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Data.ByteString.Short (ShortByteString)
import Data.Proxy (Proxy(..))
import Data.String.Encode
import Data.Word (Word8)
import Test.QuickCheck
import Test.QuickCheck.Instances ()
import Data.Text (Text)
import Data.ByteString (ByteString)
import qualified Data.Text.Lazy as TL
import qualified Data.ByteString.Lazy as BL

main :: IO ()
main = do
  encode (Proxy :: Proxy TL.Text)       (Proxy :: Proxy ByteString)
  encode (Proxy :: Proxy TL.Text)       (Proxy :: Proxy BL.ByteString)
  encode (Proxy :: Proxy TL.Text)       (Proxy :: Proxy ShortByteString)
  encode (Proxy :: Proxy TL.Text)       (Proxy :: Proxy [Word8])
  encode (Proxy :: Proxy String)        (Proxy :: Proxy ByteString)
  encode (Proxy :: Proxy String)        (Proxy :: Proxy BL.ByteString)
  encode (Proxy :: Proxy String)        (Proxy :: Proxy ShortByteString)
  encode (Proxy :: Proxy String)        (Proxy :: Proxy [Word8])
  encode (Proxy :: Proxy Text)          (Proxy :: Proxy ByteString)
  encode (Proxy :: Proxy Text)          (Proxy :: Proxy BL.ByteString)
  encode (Proxy :: Proxy Text)          (Proxy :: Proxy ShortByteString)
  encode (Proxy :: Proxy Text)          (Proxy :: Proxy [Word8])
  iso    (Proxy :: Proxy ByteString)    (Proxy :: Proxy ByteString)
  iso    (Proxy :: Proxy ByteString)    (Proxy :: Proxy BL.ByteString)
  iso    (Proxy :: Proxy ByteString)    (Proxy :: Proxy ShortByteString)
  iso    (Proxy :: Proxy ByteString)    (Proxy :: Proxy [Word8])
  iso    (Proxy :: Proxy BL.ByteString) (Proxy :: Proxy ByteString)
  iso    (Proxy :: Proxy BL.ByteString) (Proxy :: Proxy BL.ByteString)
  iso    (Proxy :: Proxy BL.ByteString) (Proxy :: Proxy ShortByteString)
  iso    (Proxy :: Proxy BL.ByteString) (Proxy :: Proxy [Word8])
  iso    (Proxy :: Proxy TL.Text)       (Proxy :: Proxy TL.Text)
  iso    (Proxy :: Proxy TL.Text)       (Proxy :: Proxy String)
  iso    (Proxy :: Proxy TL.Text)       (Proxy :: Proxy Text)
  iso    (Proxy :: Proxy String)        (Proxy :: Proxy TL.Text)
  iso    (Proxy :: Proxy String)        (Proxy :: Proxy String)
  iso    (Proxy :: Proxy String)        (Proxy :: Proxy Text)
  iso    (Proxy :: Proxy Text)          (Proxy :: Proxy TL.Text)
  iso    (Proxy :: Proxy Text)          (Proxy :: Proxy String)
  iso    (Proxy :: Proxy Text)          (Proxy :: Proxy Text)
  iso    (Proxy :: Proxy [Word8])       (Proxy :: Proxy ByteString)
  iso    (Proxy :: Proxy [Word8])       (Proxy :: Proxy BL.ByteString)
  iso    (Proxy :: Proxy [Word8])       (Proxy :: Proxy ShortByteString)
  iso    (Proxy :: Proxy [Word8])       (Proxy :: Proxy [Word8])

iso :: forall a b proxy. (Eq a, Show a, Arbitrary a, ConvertString a b, ConvertString b a) => proxy a -> proxy b -> IO ()
iso _ _ = quickCheck $ \(a :: a) -> convertString (convertString a :: b) == a

encode :: forall a b proxy. (Eq a, Show a, Arbitrary a, EncodeString a b) => proxy a -> proxy b -> IO ()
encode _ _ = do
  quickCheck $ \(a :: a) -> decodeString (encodeString a :: b) == Just a
  quickCheck $ \(a :: a) -> decodeStringLenient (encodeString a :: b) == a
