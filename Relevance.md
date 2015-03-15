# XML #
Before continuing, first decide if XML at all is the right thing for you. If for exchange of data with the outside world, then probably yes. If for internal use only, then [maybe](http://developer.apple.com/library/mac/#documentation/cocoa/reference/foundation/Classes/NSCoder_Class/Reference/NSCoder.html) no.

You might also want to check out [JSON](http://en.wikipedia.org/wiki/JSON), but I recommend XML, especially on the client-side.
# The DOM, SAX, and StAX #
You can serialize your data to an XML document using different versions of the DOM, SAX, or StAX APIs. There are some pros and cons of each API you should be aware of before deciding what is right for you.

## DOM ##
The DOM API is ideal for editing the structure of your XML document by adding, modifying or deleting elements. It is generally well-documented and a fair choice for small documents, or those that contain under a hundred elements.

The DOM API requires the entire XML document before you can begin writing XML. In cases where you already have an object model (classes), this usually means that your memory usage potentially will increase dramatically, as your data will be stored in two objects trees at the same time.

Code for reading DOM trees will look much as code using pull-parsers.
## SAX and StAX ##
The SAX API is the most lightweight of the APIs. It is faster but not as user-friendly as StAX, which is a form of pull-parser.

Outputting starts directly without any pre-processing and there is no requirement that all the data is available at the same time.

# When is this project NOT a tool for you #
  * if you already are comfortable with DOM APIs and your XML documents are small
  * if you plan on reading, modifying and writing general XML documents - XML editors and such
  * if your input and/or output interfaces or imported tools (like XPath) require DOM
  * if your google search reveals a better and/or simpler API, especially one with a corresponding pull-parser

Note that small documents are relative to the available memory. As a rule of thumb, an XML text document of 10k requires about 1MB of memory (multiply by a factor of 100) using DOM.

# When is this project a tool for you #
  * if you have memory constraints (or just don't know)
  * if you need high performance XML serialization (relative to DOM)
  * if your scenario (e.g. network transmission) is best served by output data being available ASAP
  * if you already somehow have an object model (classes) and plan on adding XML serialization in a format you control
  * if you need a simple tool for just writing XML in any format

# Gotchas #
If you were planing on writing your own little text-appending XML code snippet (how hard can that really be?), **forget that and use a proper tool instead** - if not this project then [another](http://code.google.com/p/xswi/wiki/Alternatives). If not then someone will come and enter some text string like for example 'M&M' and your XML will (silently) be invalid, and will NOT be accepted by any XML parser and backfire as to demonstrate that you do not even master XML, which is a simple and fundamental format on the modern Internet.

Also **please** always use UTF text encoding for your XML, or my name 'Thomas Skjølberg' will like like 'Thomas SkjÃƒÆ’Ã‚Â¸lberg', which I really hate :P