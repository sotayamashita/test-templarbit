module Templarbit
  def self.sys_command(command)
    result = begin
               `#{command} 2>&1`
             rescue StandardError
               nil
             end
    return if result.nil? || result.empty? || $CHILD_STATUS.exitstatus != 0
    result.strip
  end
end
