require 'rspec'

class CustomFormatter
  RSpec::Core::Formatters.register self, :dump_pending, :dump_failures, :close,
                                   :dump_summary, :example_passed, :example_failed, :example_pending, :start, :example_group_started
  
  def initialize(output)
    @output = output
  end
  
  def start(notification)
    @output << "Testing #{notification.count} factors.\n"
  end
  def example_group_started(notification)
    @output << "#{RSpec::Core::Formatters::ConsoleCodes.wrap(notification.group.description, :yellow)}\n"
  end
  def example_passed(notification) # ExampleNotification
    @output << "#{add_spaces(2)}#{notification.example.description}: [#{RSpec::Core::Formatters::ConsoleCodes.wrap("\u{2714}", :success)}]\n"
  end
  
  def example_failed(notification) # FailedExampleNotification
    @output << "#{notification.example.description}: [#{RSpec::Core::Formatters::ConsoleCodes.wrap("\u{2718}", :failure)}]\n"
  end
  
  def example_pending(notification) # ExampleNotification
    @output << "#{notification.example.description}: [#{RSpec::Core::Formatters::ConsoleCodes.wrap("\u{2731}", :failure)}]\n"
  end
  
  def dump_pending(notification) # ExamplesNotification
    @output << "\nPENDING:\n\t"
    @output << notification.pending_examples.map {|example| example.full_description + " - " + example.location}.join("\n\t")
  end
  
  def dump_failures(notification) # ExamplesNotification
    @output << "\nFAILING\n\t"
    @output << failed_examples_output(notification)
  end
  
  def dump_summary(notification) # SummaryNotification
    @output << "\nFinished in #{RSpec::Core::Formatters::Helpers.format_duration(notification.duration)}."
  end
  
  def close(notification) # NullNotification
    @output << "\n"
  end
  
  private
  
  # Loops through all of the failed examples and rebuilds the exception message
  def failed_examples_output(notification)
    failed_examples_output = notification.failed_examples.map do |example|
      failed_example_output example
    end
    build_examples_output(failed_examples_output)
  end
  
  # Joins all exception messages
  def build_examples_output(output)
    output.join("\n\n\t")
  end
  
  # Extracts the full_description, location and formats the message of each example exception
  def failed_example_output(example)
    full_description  = example.full_description
    location          = example.location
    formatted_message = strip_message_from_whitespace(example.execution_result.exception.message)
  
    "#{full_description} - #{location} \n  #{formatted_message}"
  end
  
  # Removes whitespace from each of the exception message lines and reformats it
  def strip_message_from_whitespace(msg)
    msg.split("\n").map(&:strip).join("\n#{add_spaces(10)}")
  end
  
  def add_spaces(n)
    ' ' * n
  end

end