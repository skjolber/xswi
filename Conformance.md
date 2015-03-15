# XML Conformance #

In order to keep xswi as small as possible, no efforts are made to recognize certain well-formedness errors that would require additional detection code, such as

  * ‘]]>’ contained in text content,
  * duplicate attributes, and
  * illegal characters in namespace prefixes, element or attribute local names.