# encoding: utf-8
class Email
  def self.send_mail(subject, template_name, email, info)
    text = Document.new(File.read(Rails.root.to_s + "/app/views/user_mailer/#{template_name}.text.erb")).interpolate(info)
    html = Premailer.new(Document.new(File.read(Rails.root.to_s + "/app/views/user_mailer/#{template_name}.html.erb")).interpolate(info), {with_html_string: true}).to_inline_css
    params = {
     "ToAddress"=> email,
     "FromName"=> 'Getherly',
     "SenderAddress"=> "notifications@getherly.com",
     "Headers"=> [
       {
         "Name"=> "Reply-To",
         "Value"=>"notifications@getherly.com"
       }
     ],
     "ReplyToAddress"=> "notifications@getherly.com",
     "FromAddress"=> "notifications@getherly.com",
     "TextBody"=> text,
     "HtmlBody"=> html,
     "Subject"=> "Getherly ｜ " + subject
    }
    EmailYak::Email.send(params)
    true
  rescue => e
    p e
    false
  end
end
