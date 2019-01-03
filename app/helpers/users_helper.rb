module UsersHelper

def get_avatar(user)
gravid=Digest::MD5::hexdigest(user.email)
ret_url="https://secure.gravatar.com/avatar/#{gravid}"

image_tag(ret_url,alt:user.name,class:"gravatar")
end
end
