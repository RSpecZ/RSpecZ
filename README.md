# RSpecZ

RSpecZ is a powerful extension for RSpec with strong and straightforward syntaxes.
With RSpecZ you can handle different contexts with only a single line of code.
RSpecZ also provides a number of aliases to improve the readability of RSpec code.

## Effect of RSpecZ

![image](https://user-images.githubusercontent.com/10380303/46996479-c60e8380-d157-11e8-9c8a-58ca1012e2ed.png)


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

#### with(name, value)

You can use `with` to set value to a variable, and execute the specified block:

```
with(name, value).so { my_block }
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
with(name, value).desc('my_context_description').so { my_block }
```

#### with(name, *values)

`with` allows you to assign multiple values to a variable in only one line of code,
it also creates context for each value, for example:

```
with(:age, 20, 30).so { my_block }
```

This is equals to:

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

Using multiple values don't allow you to set your own context description.

If you want to set description, you should write `with(name, value)` multiple times.

#### with(name) { value }

`with` also allow you to assign block value to a variable.

You can use dynamic values like `FactoryBot`.

```
with(:person) { create(:person) }.so { my_block }
```

This is equals to:

```
context "when person is create(:person)" do
  let(:person) { create(:person) }
   my_block
end
```

`with` with block produce description from your block source, so you can know what kind of context it is.

#### `and`

Each `with` method can chain `and` method.

If you want to set another variable for spec, you can set additional variable with `and` method.

```
with(:name, 'test').and(:age) { 10 }.so { my_block }
```

This is equals to:

```
context 'when name is test and age is 10' do
  let(:name) { 'test' }
  let(:age) { 10 }
  my_block
end
```

#### with_nil(*variables)

`with_nil` is a specific method to set nil to variables.

```
with_nil(:name, :age, :phone_number).so { my_block }
```

This is equals to:

```
%i[name age phone_number].each do |variable|
  context "when #{variable} is nil" do
    let(variable) { nil }
    my_block
  end
end
```


### valid, invalid, missing

`with` method doesn't provide any information about what kind of spec it is.

RSpecZ has `with_valid` , `with_invalid` , `with_missing` provide spec information by method name.

You can use these method to make specs review easy.


### super in with method

RSpec's `super` in `let` cannot be used in RSpecZ.

RSpecZ has `_super` method for this.

You can use `_super` like this.

```
let(:name) { 'test' }

with(:name) { _super + '10' }.so { my_block }
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
