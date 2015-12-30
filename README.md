[![Build Status](https://travis-ci.org/skjolber/xswi.svg)](https://travis-ci.org/skjolber/xswi)

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

Head over to the [wiki](https://github.com/skjolber/xswi/tree/wiki) for a better [introduction](https://github.com/skjolber/xswi/blob/wiki/Introduction.md) and [examples](https://github.com/skjolber/xswi/blob/wiki/Examples.md).

XML beginners are encouraged to see if this project is  [something for them](https://github.com/skjolber/xswi/blob/wiki/Relevance.md).

## Source code ##
Download ([XMLWriter.h](https://github.com/skjolber/xswi/blob/master/xswi/XMLWriter.h) and  [XMLWriter.m](https://github.com/skjolber/xswi/blob/master/xswi/XMLWriter.m)), or run

```
git clone https://github.com/skjolber/xswi.git
```

No frameworks beyond the Foundation framework are necessary.
## License ##
The project is available under the [MIT](http://www.opensource.org/licenses/mit-license.php) open source license. In a nuthsell, this means this project is <b>free to use in proprietary (also commercial) software </b> without opening up any of your own code or contributing derivate works.
More details in the [wiki](https://github.com/skjolber/xswi/blob/wiki/License.md).

## News ##
30th December 2015: Emoji support, Travis build and project update by <a href="https://github.com/tsparber">tsparber</a><br>
15th March 2015: Project migrated from Google Code. Final stats: Approximately 3500 downloads.<br>
30th September 2014: ARC is now supported. <br>

<h2>History</h2>
<b>Sept 30th 2014:</b> Version 1.05 released with fix for <a href='https://github.com/skjolber/xswi/issues/7'>issue 7</a> (ARC).<br>
<b>Aug 29th 2011:</b> Version 1.04 released with fix for <a href='https://github.com/skjolber/xswi/issues/5'>issue 5</a>.<br>
<b>May 12th 2011:</b> Version 1.03.1 released with code cleanup - no functional changes.<br>
<b>March 20th 2011:</b> Version 1.03 released with fix for <a href='https://github.com/skjolber/xswi/issues/2'>issue 2</a>.<br>
<b>December 25th 2010:</b> Version 1.02 released with fix for <a href='https://github.com/skjolber/xswi/issues/1'>issue 1</a>.<br>
<b>November 19th 2010:</b> Version 1.01 released.<br>
<b>October 19th 2010:</b> First version released!<br>
<br>
<h1>Need help?</h1>
If you need professional help with a project, get in touch.<br>
<br>
<h1>Donate</h1>
Chip in to add new features or test cases - divert time from paid work.<br>
<br>
<a href='https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=G45FR5K42QGUS'><img src='https://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif' /></a>

<blockquote>
