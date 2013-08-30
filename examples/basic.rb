require 'logger'
require 'opener/client'

class Basic < Opener::Client::Pipeline
  # Define your processors. The order matters.
  define_processors "language-identifier",
                    "tokenizer",
                    "pos-tagger",
                    "polarity-tagger",
                    "ner",
                    "opinion-detector"

  # Defaults to :async, other option is :sync
  processor_style :async

  webservice_host "http://localhost:9292"

  outlet "http://localhost:3000/review_browser/outlet"


  def process_file(input_file, output_file)
    text     = File.read(input_file)

    log.info "Testing Async Pipeline\n"
    log.info "Processing: #{input_file}"

    #
    # This is where the magic happens
    #
    response = process(text)

    wait_for_completion(response, output_file)
  end

  def wait_for_completion(response, output)
    log.info "We can expect the analysis to arrive at:"
    log.info "#{response["output_url"]}"

    #
    # Wait for the pipeline to complete. You would normally
    # Just define your own outlet that takes the response.
    # But in case you simply want to wait, this shows you how long you've
    # been waiting.
    #

    i = 0
    while i += 1 do
      result = HTTPClient.get(response["output_url"])
      if result.status == 200
        file = File.open(output, "w")
        file.puts result.body
        log.info "Wrote output to #{output} after #{i} seconds."
        break
      end

      if result.status == 500
        break
      end
      print "Waiting #{i} seconds\r"
      sleep(1)
    end
  end

  private

  def log
    @logger ||= Logger.new(STDOUT)
  end
end


basic = Basic.new
basic.process_file(ARGV[0], ARGV[1])
