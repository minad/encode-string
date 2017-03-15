# encode-string: String encoding and decoding

[![Hackage](https://img.shields.io/hackage/v/encode-string.svg)](https://hackage.haskell.org/package/encode-string)
[![Build Status](https://secure.travis-ci.org/minad/encode-string.png?branch=master)](http://travis-ci.org/minad/encode-string)

In modern Haskell many different string types
are commonly used in combination with the 'OverloadedStrings' extension.
This small package provides means to convert safely between those.
Currently, 'String', lazy and strict 'Text', lazy and strict 'ByteString',
'[Word8]' and 'ShortByteString' are supported.
