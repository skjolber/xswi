# Overview #
The XSWI project hosts a **simple, standalone XML stream writer for iOS** implemented in Objective-C. <br />
As such, it can be used for iPhone, iPad and iPod apps.

## Background ##
The project is inspired by the [kXML](http://kxml.sourceforge.net/) and [StAX](http://en.wikipedia.org/wiki/StAX) serializers from the Java world.

## Features ##
The most important features are
  * Well-formed XML output
  * Simple setup and usage
  * Namespace support
  * Low memory footprint

## Usage ##
Usage is straightforward:
```
// allocate serializer
XMLWriter* xmlWriter = [[XMLWriter alloc]init];

// start writing XML elements
[xmlWriter writeStartElement:@"Root"];
[xmlWriter writeCharacters:@"Text content for root element"];
[xmlWriter writeEndElement];

// get the resulting XML string
NSString* xml = [xmlWriter toString];
```

This produces the following XML string:

```
<Root>Text content for root element</Root>
```

Head over to the [wiki](http://code.google.com/p/xswi/w/list) for a better [introduction](http://code.google.com/p/xswi/wiki/Introduction) and [examples](http://code.google.com/p/xswi/wiki/Examples).

XML beginners are encouraged to see if this project is  [something for them](http://code.google.com/p/xswi/wiki/Relevance).

## Source code ##
Download ([XMLWriter.h](https://code.google.com/p/xswi/source/browse/xswi/XMLWriter.h) and  [XMLWriter.m](https://code.google.com/p/xswi/source/browse/xswi/XMLWriter.m)), or run

```
git clone https://code.google.com/p/xswi/
```

No frameworks beyond the Foundation framework are necessary.
## License ##
The project is available under the [MIT](http://www.opensource.org/licenses/mit-license.php) open source license. In a nuthsell, this means this project is <b>free to use in proprietary (also commercial) software </b> without opening up any of your own code or contributing derivate works.
More details in the [wiki](http://code.google.com/p/xswi/wiki/License).

## News ##
30th September 2014: ARC is now supported. <br>
24th of February 2012: > 400 downloads for version 1.04 and > 1000 in total :P<br>
12th of May 2011: Changed to <a href='http://www.opensource.org/licenses/mit-license.php'>MIT</a> license due to user input. <br>

<h2>History</h2>
<b>Sept 30th 2014:</b> <a href='https://code.google.com/p/xswi/source/browse/?name=v1.0.5'>Version 1.05</a> released with fix for <a href='https://code.google.com/p/xswi/issues/detail?id=7'>issue 7</a> (ARC).<br>
<b>Aug 29th 2011:</b> Version 1.04 released with fix for <a href='https://code.google.com/p/xswi/issues/detail?id=5'>issue 5</a>.<br>
<b>May 12th 2011:</b> Version 1.03.1 released with code cleanup - no functional changes.<br>
<b>March 20th 2011:</b> Version 1.03 released with fix for <a href='https://code.google.com/p/xswi/issues/detail?id=2'>issue 2</a>.<br>
<b>December 25th 2010:</b> Version 1.02 released with fix for <a href='https://code.google.com/p/xswi/issues/detail?id=1'>issue 1</a>.<br>
<b>November 19th 2010:</b> Version 1.01 released.<br>
<b>October 19th 2010:</b> First version released!<br>
<br>
<h1>Need help?</h1>
If you need professional help with a project, get in touch.<br>
<br>
<h1>Donate</h1>
Chip in to add ARC and more test cases - divert time from paid work. Any amount is helpful and encouraging :-)<br>
<br>
<a href='https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=G45FR5K42QGUS'><img src='https://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif' /></a>

<blockquote>