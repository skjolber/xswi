# XML Document header #
The code
```
// allocate serializer
id<XMLStreamWriter> xmlWriter = [[XMLWriter alloc]init];

[xmlWriter writeStartDocument:@"1.0" encoding:@"UTF-8"];
```

will add an XML document header to the top of the XML document:

```
<?xml version="1.0" encoding="UTF-8"?>
```

Be sure to **use the same character encoding** when you convert any XML text to bytes **as you specify in the header**.
# Elements and attributes #
This simple example illustrates how to write elements and attributes
```
// add document header
[xmlWriter writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];

// add root element
[xmlWriter writeStartElement:@"Root"];

	// add element with an attribute and some some text
	[xmlWriter writeStartElement:@"Element"];
	[xmlWriter writeAttribute:@"attributeName" value:@"attributeValue"];	
		[xmlWriter writeCharacters:@"This element has an attribute"];	
	[xmlWriter writeEndElement];

// close root element
[xmlWriter writeEndElement];

// end document
[xmlWriter writeEndDocument];
```
results in
```
<?xml version="1.0" encoding="UTF-8" ?>
<Root>
	<Element attributeName="attributeValue">This element has an attribute</Element>
</Root>
```

We recommend to **keep the code indentation equal to the desired XML output indentation**, like in the above example.
Extra { .. }  can be added to give the code strictly correct formatting.
## Pretty printing ##
Indentation and line-break can be configured using the indentation and linebreak fields. If you add
```
xmlWriter.indentation = NULL;
xmlWriter.lineBreak = NULL;
```

the output will go from

```
<?xml version="1.0" encoding="UTF-8" ?>
<Root>
	<Element>This is an example</Element>
</Root>
```
to
```
<?xml version="1.0" encoding="UTF-8" ?><Root><Element>This is an example</Element></Root>
```
which is more compact and thus recommended for production code.

### Automatic empty elements ###
If an element does not have child content like elements or text, instead of
```
<Element attributeName="attributeValue"></Element>
```
the XML writer per default outputs
```
<Element attributeName="attributeValue" />
```
which is a more compact (recommended) form.
# Namespaces #
Namespaces allow for elements and attributes to be of some specific, uniquely identifiable, type.

```
// determine the namespaces to use
NSString* firstNamespaceURI = @"firstNamespace";
NSString* secondNamespaceURI = @"secondNamespace";

// add the namespaces and set a prefix for each
[xmlWriter setPrefix:@"f" namespaceURI:firstNamespaceURI];
[xmlWriter setPrefix:@"s" namespaceURI:secondNamespaceURI];

// add document header	
[xmlWriter writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];

// add root element which belongs to the 'firstNamespace'
[xmlWriter writeStartElementWithNamespace:firstNamespaceURI localName:@"Root"];

	// add element which belongs to the 'secondNamespace'
	[xmlWriter writeStartElementWithNamespace:secondNamespaceURI localName:@"Element"];

	// write attribute without namespace
	[xmlWriter writeAttribute:@"attributeName" value:@"attributeValue"];	

	// write attribute with namespace
	[xmlWriter writeAttributeWithNamespace:secondNamespaceURI localName:@"namespaceAttributeName" value:@"attributeValue"];	
		[xmlWriter writeCharacters:@"This element has two attributes"];	
	[xmlWriter writeEndElement];

// end root element
[xmlWriter writeEndElement];

// end document
[xmlWriter writeEndDocument];

```
outputs to
```
<?xml version="1.0" encoding="UTF-8" ?>
<f:Root xmlns:f="firstNamespace" xmlns:s="secondNamespace">
	<s:Element attributeName="attributeValue" s:namespaceAttributeName="attributeValue">This element has two attributes</s:Element>
</f:Root>
```

where you see the namespaces declared in the root element using the xmlns attribute prefix.

Declaring all the namespaces in the top of the document, like in the above example, is considered best practice.
## Default namespace ##
If you have only one namespace, or some kind of master namespace, you probably would like to go with using the default namespace,

```
NSString* firstNamespaceURI = @"firstNamespace";

// set the default namespace
[xmlWriter setDefaultNamespace:firstNamespaceURI];
	
[xmlWriter writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
[xmlWriter writeStartElementWithNamespace:firstNamespaceURI localName:@"Root"];

	[xmlWriter writeStartElementWithNamespace:firstNamespaceURI localName:@"Element"];
	[xmlWriter writeAttribute:@"attributeName" value:@"attributeValue"];	
		[xmlWriter writeCharacters:@"This element actually has a namespace"];	
	[xmlWriter writeEndElement];

[xmlWriter writeEndElement];
[xmlWriter writeEndDocument];

```
gives
```
<Root xmlns="firstNamespace">
	<Element attributeName="attributeValue">This element actually has a namespace</Element>
</Root>
```

which is easier on the eyes.

# Further reading #
For more advanced topics, see [more examples](http://code.google.com/p/xswi/wiki/SerializingObjectsToXML) or the [wiki overview](http://code.google.com/p/xswi/w/list).