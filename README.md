# vim-bbrackets

## di and ci on all bracket types in a sane way

If you've ever wandered why you can delete the content inside the quotes without even having the cursor inside them, but you cannot do that with brackets, this plugin is for you.
Still not sure? Let's see some examples in the Usage section.

## Installation

Install using your favorite plugin manager, or use Vim's built-in package support:
```sh
mkdir -p ~/.vim/pack/filipgodlewski/start
cd ~/.vim/pack/filipgodlewski/start
git clone https://github.com/filipgodlewski/vim-bbrackets.git
```

## Usage

### Basic

Let's consider this situation:

```
This │is some text, and "this is some text inside quotes"
```

Your cursor is positioned where the "│" character is.

If you do `di"` in Normal mode, the outcome will be:

```
This is some text, and "│"
```

On the other hand, in this situation:

```
This │is some text, and (this is some text inside quotes)
```

Doing `di(` does nothing, unfortunately.

This plugins tackles that problem.

Works with round (`()`), square (`[]`) and angle (`<>`) brackets

Oh, and `ci(` will work as well!

### 'Advanced'

This plugin also makes deletion more sane, at least in my opinion.

All of the below situations:

```
# situation 1
text(text inside)

# situation 2
text│(text inside)

# situation 3
text(│text inside)

# situation 4
text(text inside│)

# situation 5
te│xt(
)

# situation 6
te│xt(text
     inside
)
```

Will result in:

```
text()
```

Moreover, if you happen to have this situation:

```
te│xt(text inside(innermost text))
```

It will result in:

```
te│xt(text inside())
```

Which effectively means that this plugin will first delete the innermost body inside brackets.

You can repeat deletion multiple times, so if in this same situation:

```
te│xt(text inside(innermost text))
```

You press `2di(`, it will result in:

```
text(│)
```

And if you have [vim-repeat](https://github.com/tpope/vim-repeat) installed, you can even use `.` to repeat your last action. Cool!

## FAQ

Q: It does not work on HTML (angle) brackets! What's going on?
A: Add the following to your .vimrc:

```
set matchpairs+=<:>
```

## Contributing

If you wish to contribute, don't hesitate to do that!
I am open for proposals.
If you have a great idea that you'd like to merge into vim-bbrackets,
either fork and create a pull request pointing to that repository,
or write an issue.

## License

Copyright (c) Filip Godlewski. Distributed under the same terms as Vim itself. See `:help license`.
