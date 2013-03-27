xml.instruct!
xml.Response do
  xml.Say @msg
  xml.Say "Good Bye."
  xml.Hangup
  #xml.Redirect @redirect_to
end