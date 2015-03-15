# Introduction #
An XML writer is a tool for producing XML documents. Although XML is a simple, textual format, it does have its [pitfalls](http://www.ibm.com/developerworks/xml/library/x-wxxm30.html).

**Production quality code should always use an XML writer** directly or indirectly.

The only exception is if your XML format is super-simple and you know how to do [XML encoding](http://en.wikipedia.org/wiki/XML#Characters_and_escaping), which you probably don't.

# XML serializer API #
There is two protocols to choose from, one with namespace support and one without. For special needs, use the base interface.

## XMLStreamWriter ##
For serialization of XML without namespaces.

```
// allocate serializer
id<XMLStreamWriter> xmlWriter = [[XMLWriter alloc]init];

// start writing XML elements
[xmlWriter writeStartElement:@"Root"];
[xmlWriter writeCharacters:@"Text content for root element"];
[xmlWriter writeEndElement];
```

produces the following XML:

```
<Root>Text content for root element</Root>
```

## NSXMLStreamWriter ##
For serialization of XML with namespaces.

```
// allocate serializer
id<NSXMLStreamWriter> xmlWriter = [[XMLWriter alloc]init];
 
// set necessary namespace(s) and prefix(es)
[xmlWriter setPrefix:@"abc" namespaceURI:@"urn:my:namespace:uri"];

// start writing XML elements with namespaces
[xmlWriter writeStartElementWithNamespace:"urn:my:namespace:uri" localName:@"Root"];
[xmlWriter writeCharacters:@"Text content for root element with namespace"];
[xmlWriter writeEndElement];
```

produces the following XML:

```
<abc:Root xmlns:abc="urn:my:namespace:uri">Text content for root element with namespace</abc:Root>
```

You may write any XML document using this serializer. For further examples, see [this wiki page](http://code.google.com/p/xswi/wiki/Examples).