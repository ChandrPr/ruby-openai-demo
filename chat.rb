require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

puts "Hello! How can I help you today?"
puts "-"*50

message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant who talks like Shakespeare."
  }
]

loop do

  user_input = gets.chomp
  break if user_input == "bye"

  message_list.append( {"role" => "user", "content" => user_input} )

  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )
  message_list.append(api_response['choices'][0]['message'])
  
  puts api_response['choices'][0]['message']['content']
  puts "-"*50

end

# pp message_list
