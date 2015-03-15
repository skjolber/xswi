# Streaming bytes #
Per default, the XMLWriter buffers the XML text as a mutable string.

If you want to output bytes to a file or network stream in the middle of writing XML, you can

  1. Get the mutable string using the toString method.
  1. Get the byte representation in the correct encoding (see the toData method)
  1. Reset the size of the mutable string using

```
[xml setString:@""]; // xml is an NSString
```
Whether you wish to employ a strategy of output in terms of XML element level(s) or XML buffer length, is up to you - but XMLWriter does not do this for you.