# Wrapping already existing XML #
In some situations, you already have some XML and want to write a wrapper:

```
<MyContainerFormat>

<!-- insert already existing XML here -->

</MyContainerFormat>
```

Before starting, check if there are any namespace prefix collisions. Most parsers will accept the same namespace defined twice, with different prefixes, but using the same prefix twice is will cause trouble. Also, if the existing XML contains a document header, remove it.

So lets quickly write serialization code for the above XML:

```
XMLWriter* xmlWriter = [[XMLWriter alloc]init];
	
NSString* myExistingXML = @"<Entity>.....</Entity>";
	
[xmlWriter writeStartElement:@"MyContainerFormat"];
	
// the serializer does not know whether there are more attributes coming, so currently the element is open.
// close open start element
[xmlWriter writeCloseStartElement];

// lets add some pretty-printing stuff also
[xmlWriter writeLinebreak];
[xmlWriter writeIndentation];
	
// write directly to the buffer
[xmlWriter write:myExistingXML];
	
[xmlWriter writeEndElement];	
	
```

which should produce

```
<MyContainerFormat>
	<Entity>.....</Entity>
</MyContainerFormat>
```

as expected ;)