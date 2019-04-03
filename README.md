# easy-password-generator

This password generator was inspired by this comic of Randall Munroe: [https://xkcd.com/936/](https://xkcd.com/936/).

## Usage

```
easy-password [OPTIONS] file seperator1 seperator2
```

The file has to have one word per line.
To make the passwords more secure two seperators are choosen. These seperators will alternate after every word.
One operator should be a special character and the other seperator should be a number.

## Example use

```
$> easy-password example_word_files/words_alpha.txt % 5

```

## Credits

- Randall Munroe for the idea
- first20hours for the word lists [https://github.com/first20hours/google-10000-english](https://github.com/first20hours/google-10000-english)
