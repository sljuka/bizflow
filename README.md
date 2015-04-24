# Bizflow

Bizflow is software for managing business processes.
Its features are:
 - DSL for process modeling
 - Compiling DSL scripts into process models
 - Creating and managing process instances
 - Reviewing status of process instances

## Installation

Install sqlite3:

    $ sudo apt-get install sqlite3 libsqlite3-dev

Add this line to your application's Gemfile:

    gem 'bizflow'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bizflow

## Usage

Setup config file and place for DSL scripts:

    $ bundle exec bizflow install

Setup internal database:
  
    $ bundle exec bizflow setup

Compile:

    $ bundle exec bizflow build

DSL sample:

```ruby

process "make_breakfast" do

  description "creates breakfast"
  
  start "check_supplies"

  input_action "check_supplies" do
    
    description "checks if there are enaugh eggs, bacon and bread"
    question "Are there enaugh supplies?"

    next_actions(
      not_enaugh_supplies: "get_supplies",
      enaugh_supplies: "make_breakfast"
    )

  end

  task_action "get_supplies" do

    description "get enaugh eggs, bacon and bread"
    task "get_bacon", roles: ["storage", "kitchen"], description: "optional description", auto_assign: true
    task "get_eggs", roles: ["storage", "kitchen"]
    task "get_bread", roles: ["storage"]

    next_action "make_breakfast"

  end

  task_action "make_breakfast" do

    description "sets stove, fry eggs, roast bacon"
    task "make_breakfast", roles: ["kitchen"]

    next_action "serve_breakfast"
    
  end

  task_action "serve_breakfast" do

    task "prepare_table", roles: ["servers"]
    task "slice_bread", roles: ["kitchen"]

    next_action "process:finish"

  end


end

```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/bizflow/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
