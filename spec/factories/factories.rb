# This will guess the User class
FactoryGirl.define do

  to_create { |instance| instance.save }

  factory :process_bp , class: Bizflow::DataModel::ProcessBlueprint do
    sequence(:name) { |n| "process_blueprint#{n}" }
    start "action_blueprint1"
  end

  factory :action_bp , class: Bizflow::DataModel::ActionBlueprint do
    sequence(:name) { |n| "action_blueprint#{n}" }
    type "task"
  end

  factory :task_bp , class: Bizflow::DataModel::TaskBlueprint do
    sequence(:name) { |n| "task_blueprint#{n}" }
  end

  factory :process , class: Bizflow::DataModel::Process do
    sequence(:name) { |n| "process#{n}" }
  end

  factory :action , class: Bizflow::DataModel::Action do
    sequence(:name) { |n| "action#{n}" }
  end

  factory :next_action_bp, class: Bizflow::DataModel::NextActionBlueprint do
    
  end


end