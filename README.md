# RSpecZ

RSpecZ is a powerful extension for RSpec with strong and straightforward syntaxes.
With RSpecZ you can handle different contexts with only a single line of code.
RSpecZ also provides a number of aliases to improve the readability of RSpec code.

## Installation

Add this line to your application's Gemfile:

Use github syntax until release Version 1.0.

```ruby
gem 'rspecz', github: 'RSpecZ/RSpecZ'
```

## Features

### Context

This is one of the most powerful features in RSpecZ.
RSpecZ has a number of context-related methods that can automatically
generate context descriptions for you.
You can also use methods like `set_values` to assign different values to a variable without writing multiple lines of code in your test.

### Let

RSpecZ provides variable assignment methods like `create_params` and `strings`, which allows you to create complex variables in only one line of code.

### Subject

RSpecZ also provides subject-related methods to simplify your code when you test subjects.

### Alias

To improve the readability of your test code, RSpecZ provides aliases such as `make` and `behave`. These aliases can help to greatly simplify your code and make them easier to review.


## Usage

### context

#### set

You can use `set` to set value to a variable, and execute the specified block:

```
set(name, value) { my_block }
```

This will automatically create context description for you based on the name and value you specified, like this:

```
context "when #{name} is #{value}" do
  let(name) { value }
  my_block
end
```

In the example above, `value` is assigned to `name` and the specified block will be executed.

You can also specify your own description:

```
set(name, value, 'my_context_description') { my_block }
```

or provide a multiple-line block:

```
set(name, value) do
  # do something
  # ...
  # do more things
end  
```

#### set_values

`set_values` allows you to assign multiple values to a variable in only one line of code,
it also creates context for each value, for example:

```
set_values(:age, 20, 30) { my_block }
```

This equals to:

```
context "when age is 20" do
  let(:age) { 20 }
  my_block
end

context "when age is 30" do
  let(:age) { 30 }
  my_block
end
```

Same as `set`, you can pass your own context description, or even do not pass a block.

#### set_nil

Similar to `set`, but you do not have to specify the value because it will be set to `nil` automatically, for example:

```
set_nil(name) { my_block }
```

will generate the code like this:

```
context "when #{name} is nil" do
  let(name) { nil }
  my_block
end
```

#### set_nils

This the plural version of `set_nil`,
it allows you to assign `nil` to each variable (while others remain the default value?) and creates context descriptions for each value.


#### set_valid

Same as `set`, except that the context description will point out that the value is valid:

```
context "when #{name} is valid(#{value})" do
  let(name) { value }
  my_block
end
```

### set_invalid

Same as `set`, except that the context description will point out that the value is invalid:

```
context "when #{name} is not valid(#{value})" do
  let(name) { value }
  my_block
end
```

#### set_invalids

The plural version of `set_invalid`,
it allows you to assign multiple invalid values to the variable,
and creates proper context descriptions for each invalid value.

```
context "when #{name} is not valid(#{value1})" do
  let(name) { value }
  my_block
end

context "when #{name} is not valid(#{value2})" do
  let(name) { value }
  my_block
end
```

This is extremely useful when you do value checking like emails:

```
set_invalids(:email, 'user@example', 'user.example.com') { # invalid email address }
```

#### set_block

Similar to `set`, but `set_block` also allows you to assign a variable with block:

```
set_block(:user) { create(:user, name: 'Alan', age: 20) }.spec { my_block }
```

### set_missing

Similar to `set`, except that the context description will point out that the value does not exist:

```
context "when #{name} does not exist(#{value})" do
  let(name) { value }
  my_block
end
```

#### set_context

`set_context` will include the specified shared context and generate a proper context description, for example:

```
set_context(shared_context) { my_block }
```

will act like this:

```
context "when include context(#{name})" do
  include_context name
  my_block
end
```

---

### let

#### create_params

`create_params` helps to create hash in just one line.

Suppose you have some variables like this:

```
let(:name) { 'Alan' }
let(:age) { 20 }
```

Generally, to create a hash with these variables, you need to write:

```
let(:params) {{
  name: name,
  age: age
}}
```

While in RSpecZ, you just use `create_params` and it will automatically create a hash with proper keys and values:

```
create_params(:name, :age)
```

#### string

`string` is useful when you are trying to create a number of strings,
it will create strings using the variable name with the prefix `test-`.

For example:

```
string(name, address)
```

This equals to:

```
let(:name) { 'test-name' }
let(:address) { 'test-address' }
```

---

### subject

#### subject_freezed

Some times the code needs to be tested under a specified time.
In RSpec, you will write code like this:

```
let(:now) { Time.zone.now }
subject do
  travel_to(now) do
    my_block
  end
end
```

However, RSpecZ provides a simpler way to do this:

```
let(:now) { Time.zone.now }
subject_freezed { my_block }
```

---

### alias

#### make

`let` and `let!` are so confusing for rubyists when writing specs, for example:

```
let(:user)    { create(:user) }
let!(:post)   { create(:post, user: user) } # eager evaluation
let(:like)    { create(:like, user: user, post: post) }
let(:comment) { create(:comment, user: user, post: post) }
```

In RSpecZ, you can use `make` instead of `let!`, which provides better identification and readability.

```
let(:user)    { create(:user) }
make(:post)   { create(:post, user: user) } # eager evaluation
let(:like)    { create(:like, user: user, post: post) }
let(:comment) { create(:comment, user: user, post: post) }
```

#### behave

RSpecZ also provides a short version of `it_behaves_like` when you use `shared_examples`, just use the keyword `behave`:

```
behave 'my_shared_examples'

# equals to:
# it_behaves_like 'my_shared_examples'
```

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
