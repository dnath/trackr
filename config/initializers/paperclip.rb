Paperclip::Attachment.default_options[:url] = 'trac.kr.s3.amazonaws.com'
Paperclip::Attachment.default_options[:path] = '/image/:filename'
Paperclip::Attachment.default_options[:default_url] = '/assets/:attachment_missing.jpg'