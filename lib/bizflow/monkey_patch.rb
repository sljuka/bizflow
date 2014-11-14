unless "foo_bar".respond_to? :camelcase_notation

  class String

    def camelcase_notation
      return self if self !~ /_/ && self =~ /[A-Z]+.*/
      split('_').map{|e| e.capitalize}.join
    end

  end

end
