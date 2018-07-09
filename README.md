# print_c
`print_f` command colorised. Use Ansi color, work great with any bash terminal, or git bash.

# Usage 

```bash
print_c "<{color};{modifier};{background}>{str}</{...}>"
```

#### color : 
Support ansi color : black, red, green, yellow, blue, purple, cyan, white.

#### background : _(optional)_
Support ansi color : black, red, green, yellow, blue, purple, cyan, white.

#### modifier : _(optional)_
Support ansi modifier : 

 * bold : bolder

 * high : high intensity

 * under : underlined


# Example 

```bash
# Output "Hello world !" in red
print_c "<red>Hello world !</red>"

# Output "Hello world !" with yellow background
print_c "<black;;yellow>Hello world !</black;;yellow>"

# Output "Hello world !" in red, underlined
print_c "<red;under>Hello world !</red;under>"

# Output "Foo has : bar" with "Foo has :" in red, and "bar" with yellow background 
print_c "<red>Foo has :</red> <black;;yellow>%</black;;yellow>" "bar"
```
