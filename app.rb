require 'bundler'
Bundler.require()

require 'mandrill'
mandrill = Mandrill::API.new 'your-api-key-here'

get '/' do
  return {"Message" => "Looks like you took a wrong turn..."}
end

post '/api/mail' do
  cross_origin
  info = Hash.new
  info['message'] = "Thanks, " + params[:userName].to_s + "! Your email has been sent!"

  message = {
     "preserve_recipients"=>nil,
     "text"=> params[:request].to_s,
     "to"=>
        [{"type"=>"to",
            "email"=> params[:userEmail].to_s,
            "name"=> params[:userName].to_s }],
     "return_path_domain"=>nil,
     "from_name"=>"Sender Name",
     "from_email"=>"sender@somewhere.com",
     "subject"=>"Your subject here!",
    }
    result = mandrill.messages.send message

  return info.to_json
end
