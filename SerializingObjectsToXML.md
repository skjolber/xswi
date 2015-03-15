# Introduction #
A common situation is to serialize objects in memory to XML. This example will explore two use-cases, one where the object structure and XML structure is equal, and one where they are not equal.

# Use-case 1: Map object structure to its corresponding XML structure #
So in other words, the object and XML structures are logically equal to each other. Lets first look at our data:

### Data structure ###
Our data has the following structure:
```
 - Party
   - Fighter
     - name
     - level
     - sword
   - Rogue
     - name
     - level
     - knife
   - Wizard
     - name
     - level
     - staff
```
where the lowest level consists of base types like NSString or BOOL and Fighter, Rogue and Wizard appear in no particular order.
### Class structure ###
The above corresponds to the Party root class having children of the abstract type Player:

Party.h:
```
@interface Party : NSObject{
    NSMutableArray *players;
}

@property (nonatomic, retain) NSMutableArray *players;

@end
```

Player.h:
```
@interface Player : NSObject {
    NSString *name;
    int level;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int level;

@end
```
And there are three concrete implementations of Player; Fighter, Rogue and Wizard, each with their own unique attribute:

Fighter.h:
```
@interface Fighter : Player {

	BOOL sword;
}

@property (nonatomic, assign) BOOL sword;

@end
```

Rogue.h:
```
@interface Rogue : Player {

	BOOL knife;
}

@property (nonatomic, assign) BOOL knife;

@end
```

Wizard.h:
```
@interface Wizard : Player {
	
	BOOL staff;
}

@property (nonatomic, assign) BOOL staff;

@end
```

### XML structure ###
It is of course always good to have an idea of what you want the expected output to be. We would like to see:
```
<Party>
	<Fighter sword="Yes">
		<Name>Butch</Name>
		<Level>1</Level>
	</Fighter>
	<Rogue>
		<Name>Shadow</Name>
		<Level>2</Level>
		<Knife>No</Knife>
	</Rogue>
	<Wizard>
		<Name>Crak</Name>
		<Level>3</Level>
		<!-- optional element for staff, present if staff is true -->
	</Wizard>

	<!-- n more elements of Fighter, Rogue and Wizard in no particular order --->

</Party>
```
### Structure summary ###
The Party object holds an array of types Fighter, Rogue or Wizard in no particular order.

All classes have a corresponding XML element. The Player class is an abstract superclass for Fighter, Rogue and Wizard and holds the common fields 'name' and 'level'.
## Writing the serialization logic ##
So how do we serialize these classes? Lets add an interface (@protocol) to the Player and Party classes:

```
@protocol XMLSerializable

- (void) write:(id<XMLStreamWriter>)writer;

@end

```

and then implement the method in all classes (initializers omitted):

Party.m:
```
@implementation Party

- (void) write:(id<XMLStreamWriter>)writer {
	[writer writeStartDocument];

	[writer writeStartElement:@"Party"];

	// serialize children
	for(Player *player in self.players) {
		[player write:writer];
	}

	[writer writeEndElement];

	[writer writeEndDocument];
}

@end
```

Player.m:
```
@implementation Player

- (void) write:(id<XMLStreamWriter>)writer {
	// do superclass behaviour here

	// write <Name>Butch</Name>
	[writer writeStartElement:@"Name"];
	[writer writeCharacters:self.name];
	[writer writeEndElement];
	
	// write <Level>1</Level>
	[writer writeStartElement:@"Level"];
	[writer writeCharacters:[NSString stringWithFormat:@"%i", self.level]];
	[writer writeEndElement];
}

@end
```
and for each subclass

Fighter.m:
```
@implementation Fighter

- (void) write:(id<XMLStreamWriter>)writer {
	[writer writeStartElement:@"Fighter"];
	
	// write optional attribute
	if(self.sword) {
		[writer writeAttribute:@"sword" value:@"Yes"];
	} else {
		// don't write anything
	}
	
	[super write:writer];

	[writer writeEndElement];
}

@end
```

Rogue.m:
```
@implementation Rogue

- (void) write:(id<XMLStreamWriter>)writer {
	[writer writeStartElement:@"Rogue"];
		
	[super write:writer];
	
	// write knife element
	[writer writeStartElement:@"Knife"];
	if(self.knife) {
		[writer writeCharacters:@"Yes"];
	} else {
		[writer writeCharacters:@"No"];
	}
	[writer writeEndElement];
	
	[writer writeEndElement];
}

@end
```
and finally

Wizard.m:
```
@implementation Wizard

- (void) write:(id<XMLStreamWriter>)writer {
	[writer writeStartElement:@"Wizard"];
	
	[super write:writer];
	
	// write optional knife element
	if(self.staff) {
		[writer writeStartElement:@"Staff"];
		[writer writeCharacters:@"Yes"];
		[writer writeEndElement];
	} else {
		// don't write anything
	}
	
	[writer writeEndElement];
}

@end
```
where each subclass has some custom behavior depending class type and attribute value.
### Serialization ###
The above approach gives us serialization logic nicely placed within each class, so lets start the serialization:
```
	// create the party objects
	Party* party = [[Party alloc]init];
	
	Fighter* fighter = [[Fighter alloc]initWithNameAndSword:@"Butch" level:1 sword:YES];
	[party.players addObject:fighter];
	
	Rogue* rougue = [[Rogue alloc]initWithNameAndKnife:@"Shadow" level:2 knife:NO];
	[party.players addObject:rougue];

	Wizard* wizard = [[Wizard alloc]initWithNameAndStaff:@"Crak" level:3 staff:NO];
	[party.players addObject:wizard];

	// allocate the xml writer
	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
	
	// write the xml
	[party write:xmlWriter];
```

which results in the following:
```
<Party>
	<Fighter sword="Yes">
		<Name>Butch</Name>
		<Level>1</Level>
	</Fighter>
	<Rogue>
		<Name>Shadow</Name>
		<Level>2</Level>
		<Knife>No</Knife>
	</Rogue>
	<Wizard>
		<Name>Crak</Name>
		<Level>3</Level>
	</Wizard>
</Party>
```
as expected.

## Summary ##
Object serialization can be performed in a quite straightforward manner, notably without the pitfalls of DOM trees. This is true also for cases where increasing structure depth and complexity is required.

Ray Wenderlich has written a nice [tutorial](http://www.raywenderlich.com/725/how-to-read-and-write-xml-documents-with-gdataxml) for GDataXML for DOM comparison, although this example is somewhat more advanced and the examples cannot be directly compared.

## Developer's notes ##
Designing clean XML formats in most cases implies sticking to either attributes or child elements for the lowest level (name, level, sword, knife, staff), the above is a mix. I prefer using attributes over elements, because it makes the format easier to parse:

```
	<Fighter sword="Yes" name="Butch" level="1" />
```
But if your data values are long, like more than 30-40 characters, or contains line-breaks or tabs, use elements. And if you only have one long data value, store it as text in your type like so:
```
	<Fighter sword="Yes" name="Butch" level="1">This is Butch's full title, which in medieval times was a very long name</Fighter>
```
and two long data values will be for example
```
	<Fighter>
		<Sword>Yes</Sword>
		<Name>Butch</Name>
		<Level>1</Level>
		<Title>This is Butch's full title, which in medieval times was a very long name</Title>
		<Hometown>This is Butch's hometown name, which we don't know the length of, thus taking no chances</Hometown>
	<Fighter>
```
# Use-case 2: Map object structure to a custom XML structure #
Regardless of the object structure, more startElement and endElement method calls can be introduced wherever to fulfill the XML output requirements.

## Example: Images to HTML document ##
Say you have an array of image URLs, and want to generate an HTML document to display them. You need to put

```
<html>
	<head></head>
	<body>
```
in front, and
```
	</body>
</html>
```
behind n times
```
<p>Image 0 from <a href="http://image.host/path/file1.jpg">here</a></p>
<img src="http://image.host/path/file1.jpg" width="25%" height="25%" />
```
But you do not have an object called html, head, body, p or img, so the approach in use-case 1 will not work - or at least you will be creating dummy objects, and we don't want to go that way. AND each URL is actually present in two XML tags, both in th 'a' and the 'img' tags. And there is image numbering from index 0 and up.

So lets rather just make good use of the writer in a single method:

```
	NSArray* imageURLs = [NSArray arrayWithObjects:@"http://host.domain/path/image1.jpg", @"http://host.domain/path/image2.jpg", @"http://host.domain/path/image3.jpg", nil];

	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
	
	[xmlWriter writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
	[xmlWriter writeStartElement:@"html"];
	[xmlWriter writeStartElement:@"head"];
	[xmlWriter writeEndElement];
	[xmlWriter writeStartElement:@"body"];
		
	for(int i = 0; i < [imageURLs count]; i++) {

		[xmlWriter writeStartElement:@"p"];
		[xmlWriter writeCharacters:[NSString stringWithFormat:@"Image %i from", i]];
			[xmlWriter writeStartElement:@"a"];
				[xmlWriter writeAttribute:@"href" value:[imageURLs objectAtIndex:i]];	
				[xmlWriter writeCharacters:@"here"];	
			[xmlWriter writeEndElement];
		[xmlWriter writeEndElement];
		
		[xmlWriter writeStartElement:@"img"];
			[xmlWriter writeAttribute:@"src" value:[imageURLs objectAtIndex:i]];	
			[xmlWriter writeAttribute:@"width" value:@"40%"];	
			[xmlWriter writeAttribute:@"heigth" value:@"40%"];	
		[xmlWriter writeEndElement];
	}	
	
	[xmlWriter writeEndElement];
	[xmlWriter writeEndElement];
```
which outputs
```
<html>
	<head />
	<body>
		<p>Image 0 from
			<a href="http://host.domain/path/image1.jpg">here</a>
		</p>
		<img src="http://host.domain/path/image1.jpg" width="40%" heigth="40%" />
		<p>Image 1 from
			<a href="http://host.domain/path/image2.jpg">here</a>
		</p>
		<img src="http://host.domain/path/image2.jpg" width="40%" heigth="40%" />
		<p>Image 2 from
			<a href="http://host.domain/path/image3.jpg">here</a>
		</p>
		<img src="http://host.domain/path/image3.jpg" width="40%" heigth="40%" />
	</body>
</html>
```
which is what we want, give or take some whitespace.
## Summary ##
XML output is not governed by the existence of objects. Just write whatever XML you want, with whatever abstractions you want.

In practice, the object structure will at least be remotely related to the output XML, in which case a mix between use-cases one and two is sensible. Simply write whatever additional XML tags you need within the write methods of each object, and if the whole document needs a wrapper, do as the above example.
# Further reading #
Keep in the back of your head that creating a corresponding [XML Schema](http://www.learn-xml-schema-tutorial.com/) will be helpful for server-side validation and as documentation of your format, if you need it. And if you'd like to look like a pro, of course ;)

Get the XMLWriter with these examples by checking out the project using git.