# load data from Terraform output
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)

alb_dns = params['alb_dns']['value']

dns_list = ["#{alb_dns}"]

dns_list.each do |host|
  describe http("http://#{host}") do
    its('status') { should cmp 200 }
    its('body') { should include 'Greetings'}
  end
end