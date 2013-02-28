xml.instruct!
xml.Response do
  xml.Say @msg
  xml.Say "If you have any question, please contact meals for me."
  xml.Redirect @redirect_to
end