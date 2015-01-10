require 'bizflow/external/business_process'

class SampleProcess < Bizflow::BusinessProcess



end

FactoryGirl.define do
  
  factory :process, class: SampleProcess do
    start_block "start_block"
    block_descriptors  ["block1", "block2"]
    task_descriptors ["task1", "task2"]
  end

end
