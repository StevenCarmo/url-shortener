# url-shortener
#### Example: Not Production Ready

----
## What is does?
1. Given a long url it generates a short url (ShortLink)
2. Given a short url it returns the long url (LongLink)

## Short Link slug
The short url slug is generated using the characters specified in the ShortLink character set.

    CHARACTER_SET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

### "Checksum"
The ensure that no two short link slugs differ by a single character a "checksum" is added to the end of the slug.  This also ensures that a malformed short url lookup will not require a database lookup.

The checksum is calculated by the sum of each individual slug characters position of in CHARACTER\_SET.  Then taking the modulo of the sum by the CHARACTER\_SET Length.

#####Example 
Randomly generated slug

    abbbb

Sum of the slug character positions in CHARACTER\_SET 

    0+1+1+1+1+1 = 5


Sum modulo CHARACTER\_SET Length

    5 % 62 = 5

Fifth Character of CHARACTER\_SET

    5 = "e"

Slug to be insterted into database

    abbbbe


## Using the api

The api endpoints are

1. http://localhost/api/expand
2. http://localhost/api/shorten

Both require a url parameter as below:

1. http://localhost/api/expand?url=http://localhost/abbbbe
2. http://localhost/api/shorten?url=http://www.intrenix.com
