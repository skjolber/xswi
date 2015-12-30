//
//  xswiTests.m
//  xswiTests
//
//  Created by Thomas Rørvik Skjølberg on 9/30/14.
//  Copyright (c) 2014 Thomas Rørvik Skjølberg. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XMLWriter.h"

#import "Player.h"
#import "Party.h"
#import "Fighter.h"
#import "Rogue.h"
#import "Wizard.h"

@interface xswiTests : XCTestCase

@end

@implementation xswiTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void) testExample1 {
	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
	
	[xmlWriter writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
	[xmlWriter writeStartElement:@"Root"];
	[xmlWriter writeStartElement:@"Element"];
	[xmlWriter writeCharacters:@"This is an example"];
	[xmlWriter writeEndElement];
	[xmlWriter writeEndElement];
    
	NSLog(@"%@", [xmlWriter toString]);
    
    NSString* expected = @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Root><Element>This is an example</Element></Root>";
    
    XCTAssertEqualObjects([xmlWriter toString], expected, @"textExample1 failed");
}

- (void) testExample2 {
	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
   
    [xmlWriter setPrettyPrinting:@"\t" withLineBreak:@"\n"];
	
	[xmlWriter writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
	[xmlWriter writeStartElement:@"Root"];
	[xmlWriter writeStartElement:@"Element"];
	[xmlWriter writeCharacters:@"This is an example"];
	[xmlWriter writeEndElement];
	[xmlWriter writeEndElement];
	
    NSString* expected = @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<Root>\n\t<Element>This is an example</Element>\n</Root>";
    
    XCTAssertEqualObjects([xmlWriter toString], expected, @"textExample2 failed");
}

- (void) testExample3 {
	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
	
	[xmlWriter writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
	[xmlWriter writeStartElement:@"Root"];
	[xmlWriter writeStartElement:@"Element"];
	[xmlWriter writeAttribute:@"attributeName" value:@"attributeValue"];
	[xmlWriter writeCharacters:@"This element has an attribute"];
	[xmlWriter writeEndElement];
	[xmlWriter writeEndElement];
	[xmlWriter writeEndDocument];
	
	NSLog(@"%@", [xmlWriter toString]);
    
    NSString* expected = @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Root><Element attributeName=\"attributeValue\">This element has an attribute</Element></Root>";
    
    XCTAssertEqualObjects([xmlWriter toString], expected, @"textExample3 failed");

}

- (void) testExample4 {
	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
	
	NSString* firstNamespaceURI = @"firstNamespace";
	NSString* secondNamespaceURI = @"secondNamespace";
	
	[xmlWriter setPrefix:@"f" namespaceURI:firstNamespaceURI];
	[xmlWriter setPrefix:@"s" namespaceURI:secondNamespaceURI];
	
	[xmlWriter writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
	[xmlWriter writeStartElementWithNamespace:firstNamespaceURI localName:@"Root"];
	[xmlWriter writeStartElementWithNamespace:secondNamespaceURI localName:@"Element"];
	[xmlWriter writeAttribute:@"attributeName" value:@"attributeValue"];
	[xmlWriter writeAttributeWithNamespace:secondNamespaceURI localName:@"namespaceAttributeName" value:@"attributeValue"];
	[xmlWriter writeCharacters:@"This element has two attributes"];
	[xmlWriter writeEndElement];
	[xmlWriter writeEndElement];
	[xmlWriter writeEndDocument];
	
	NSLog(@"%@", [xmlWriter toString]);
    
    NSString* expected = @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><f:Root xmlns:f=\"firstNamespace\" xmlns:s=\"secondNamespace\"><s:Element attributeName=\"attributeValue\" s:namespaceAttributeName=\"attributeValue\">This element has two attributes</s:Element></f:Root>";
    
    XCTAssertEqualObjects([xmlWriter toString], expected, @"textExample4 failed");

}

- (void) testExample5 {
	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
	
	NSString* firstNamespaceURI = @"firstNamespace";
	[xmlWriter setDefaultNamespace:firstNamespaceURI];
	
	[xmlWriter writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
	[xmlWriter writeStartElementWithNamespace:firstNamespaceURI localName:@"Root"];
	[xmlWriter writeStartElementWithNamespace:firstNamespaceURI localName:@"Element"];
	[xmlWriter writeAttribute:@"attributeName" value:@"attributeValue"];
	[xmlWriter writeCharacters:@"This element actually has a namespace"];
	[xmlWriter writeEndElement];
	[xmlWriter writeEndElement];
	[xmlWriter writeEndDocument];
	
	NSLog(@"%@", [xmlWriter toString]);
    
    NSString* expected = @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Root xmlns=\"firstNamespace\"><Element attributeName=\"attributeValue\">This element actually has a namespace</Element></Root>";
    
    XCTAssertEqualObjects([xmlWriter toString], expected, @"textExample5 failed");

}

- (void) testExample6 {
	// create the party objects
	Party* party = [[Party alloc]init];
	
	Fighter* fighter = [[Fighter alloc]initWithNameAndSword:@"Butch" level:1 sword:YES];
	[party.players addObject:fighter];
	
	Rogue* rougue = [[Rogue alloc]initWithNameAndKnife:@"Shadow" level:2 knife:NO];
	[party.players addObject:rougue];
    
	Wizard* wizard = [[Wizard alloc]initWithNameAndStaff:@"Crak" level:3 staff:NO];
	[party.players addObject:wizard];
    
	// write the xml
	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
	
	[party write:xmlWriter];
	
	NSLog(@"%@", [xmlWriter toString]);
    
    NSString* expected = @"<?xml version=\"1.0\" ?><Party><Fighter sword=\"Yes\"><Name>Butch</Name><Level>1</Level></Fighter><Rogue><Name>Shadow</Name><Level>2</Level><Knife>No</Knife></Rogue><Wizard><Name>Crak</Name><Level>3</Level></Wizard></Party>";
    
    XCTAssertEqualObjects([xmlWriter toString], expected, @"textExample6 failed");

	
}

- (void) testExample7 {
	NSArray* imageURLs = [NSArray arrayWithObjects:@"http://host.domain/path/image1.jpg", @"http://host.domain/path/image2.jpg", @"http://host.domain/path/image3.jpg", nil];
    
	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
	
	[xmlWriter writeStartDocumentWithEncodingAndVersion:@"UTF-8" version:@"1.0"];
	[xmlWriter writeStartElement:@"html"];
	[xmlWriter writeStartElement:@"head"];
	[xmlWriter writeEndElement];
	[xmlWriter writeStartElement:@"body"];
    
	for(NSUInteger i = 0; i < [imageURLs count]; i++) {
        
		[xmlWriter writeStartElement:@"p"];
		[xmlWriter writeCharacters:[NSString stringWithFormat:@"Image %li from", (unsigned long)i]];
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
	
	NSLog(@"%@", [xmlWriter toString]);
    
    
    NSString* expected = @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><html><head /><body><p>Image 0 from<a href=\"http://host.domain/path/image1.jpg\">here</a></p><img src=\"http://host.domain/path/image1.jpg\" width=\"40%\" heigth=\"40%\" /><p>Image 1 from<a href=\"http://host.domain/path/image2.jpg\">here</a></p><img src=\"http://host.domain/path/image2.jpg\" width=\"40%\" heigth=\"40%\" /><p>Image 2 from<a href=\"http://host.domain/path/image3.jpg\">here</a></p><img src=\"http://host.domain/path/image3.jpg\" width=\"40%\" heigth=\"40%\" /></body></html>";
    
    XCTAssertEqualObjects([xmlWriter toString], expected, @"textExample7 failed");

    
}


-(void)testExample8 {
	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
	
	NSString* myExistingXML = @"<Entity>.....</Entity>";
	
	[xmlWriter writeStartElement:@"MyContainerFormat"];
	
	// the serializer does not know whether there are more attributes coming, so currently the element is open
	// close open start element
	[xmlWriter writeCloseStartElement];
	
	// lets add some pretty-printing stuff also
	[xmlWriter writeLinebreak];
	[xmlWriter writeIndentation];
	
	// write directly to the buffer
	[xmlWriter write:myExistingXML];
	
	[xmlWriter writeEndElement];
	
	NSLog(@"%@", [xmlWriter toString]);
	
    NSString* expected = @"<MyContainerFormat><Entity>.....</Entity></MyContainerFormat>";
    
    XCTAssertEqualObjects([xmlWriter toString], expected, @"textExample1 failed");

}


-(void)testIssue1 {
	// test for issue 1 as reported by henrik.lundstedt
	
	XMLWriter* writer = [[XMLWriter alloc]init];
    
	NSString* NAMESPACE_WS_SECURITY = @"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
	NSString* NAMESPACE_COMMON_COMPLEX_ELEMENTS = @"http://secondnamespace";
	NSString* USER_NAME = @"xxxxxx";
	NSString* PASSWORD = @"yyyyy";
	NSString* SALES_UNIT_KEY_ACCEPTANCE_TEST = @"zzzzz";
	
	[writer setPrefix:@"wsse" namespaceURI:NAMESPACE_WS_SECURITY];
	[writer writeStartElementWithNamespace:NAMESPACE_WS_SECURITY localName:@"Security"];
	[writer writeAttribute:@"mustUnderstand" value:@"1"];
	[writer writeStartElementWithNamespace:NAMESPACE_WS_SECURITY localName:@"UsernameToken"];
	[writer writeStartElementWithNamespace:NAMESPACE_WS_SECURITY localName:@"Username"];
	[writer writeCharacters:USER_NAME];
	[writer writeEndElement];
	[writer writeStartElementWithNamespace:NAMESPACE_WS_SECURITY localName:@"Password"];
	[writer writeCharacters:PASSWORD];
	[writer writeEndElement];
	[writer writeEndElement];
	[writer writeEndElement];
	
	[writer setPrefix:@"ns2" namespaceURI:NAMESPACE_COMMON_COMPLEX_ELEMENTS];
	[writer writeStartElementWithNamespace:NAMESPACE_COMMON_COMPLEX_ELEMENTS localName:@"ClientInformation"];
	[writer writeStartElementWithNamespace:NAMESPACE_COMMON_COMPLEX_ELEMENTS localName:@"SalesUnitKey"];
	[writer writeCharacters:SALES_UNIT_KEY_ACCEPTANCE_TEST];
	[writer writeEndElement];
	[writer writeStartElementWithNamespace:NAMESPACE_COMMON_COMPLEX_ELEMENTS localName:@"ApplicationName"];
	[writer writeCharacters:@""];
	[writer writeEndElement];
	[writer writeEndElement];
	
	NSLog(@"%@", [writer toString]);
    
    NSString* expected = @"<wsse:Security mustUnderstand=\"1\" xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\"><wsse:UsernameToken><wsse:Username>xxxxxx</wsse:Username><wsse:Password>yyyyy</wsse:Password></wsse:UsernameToken></wsse:Security><ns2:ClientInformation xmlns:ns2=\"http://secondnamespace\"><ns2:SalesUnitKey>zzzzz</ns2:SalesUnitKey><ns2:ApplicationName></ns2:ApplicationName></ns2:ClientInformation>";
    
    XCTAssertEqualObjects([writer toString], expected, @"textIssue1 failed");

    
    
    
}

-(void)testIssue2 {
	// test for issue 1 as reported by henrik.lundstedt
	
	XMLWriter* xmlWriter = [[XMLWriter alloc]init];
    
	[xmlWriter writeStartElement:@"Root"];
	[xmlWriter writeCharacters:@"Escaped character content < > & \"' postfix"];
	[xmlWriter writeEndElement];
	
	NSLog(@"%@", [xmlWriter toString]);
    
    NSString* expected = @"<Root>Escaped character content &lt; &gt; &amp; &quot;' postfix</Root>";
    
    XCTAssertEqualObjects([xmlWriter toString], expected, @"textIssue2 failed");

}



@end
