# easy-password-generator

This password generator was inspired by this comic of Randall Munroe: [https://xkcd.com/936/](https://xkcd.com/936/).

## Usage

```
easy-password [OPTIONS] file seperator1 seperator2
```

The file has to have one word per line.

To make the passwords more secure two seperators are choosen.

These seperators will alternate after every word. One operator should be a special character and the other seperator should be a number.

## Example uses

```
$> easy-password example_word_files/word_list.txt % 5
Fewer%Trees5Cleaning%Kitty5
$> easy-password --number=5 example_word_files/word_list.txt '$' 8
Symbol$Teacher8Requieres$Minimal8Pills$
```

## Credits

- Randall Munroe for the idea
- first20hours for the word lists [https://github.com/first20hours/google-10000-english](https://github.com/first20hours/google-10000-english)
