def mfm_say
  say "Hello, you got an order from meals for me dot com, invoice is " + $order_id
  ask "If correct, please press 1. If not, please press 0.", {
      :choices  => "[1 DIGITS]",
      :timeout  => 15.0,
      :onChoice => lambda { |invitee|
        if invitee.value == "1"
          say "All right! We know it."
          hangup
          'Success 1'
        else
          say "thats o.k. now they will probably talk about you."
          hangup
          'Success 2'
        end
      }
  }
end

def mfm_call(waiting_time)
  wait(waiting_time)
  call '+' + $phone, {
      :onAnswer => lambda {
        mfm_say
      },
      :onTimeout => lambda {
        wait(waiting_time)
        call '+' + $phone, {
            :onAnswer => lambda {
              mfm_say
            },
            :onTimeout => lambda {
              wait(waiting_time)
              call '+' + $phone, {
                  :onAnswer => lambda {
                    mfm_say
                  },
                  :onTimeout => {
                      # Report failure
                  }
              }
            }
        }
      }
  }
end

flag = 'nothing'
waiting_time = 0

flag = mfm_call(waiting_time)

3.times {
  unless flag != 'nothing' || $currentCall.isActive
    flag = mfm_call(waiting_time)
  end
}

# Tropo Example Script
#
#call "+19797396180"
#
#def question
#  result = ask "What is your favorite color?", {:choices => "red, green, blue"}
#  return result.value
#end
#
#def confirm(result)
#  result1 = ask "Did you say that your favorite color was #{result}?", {:choice => "yes, no"}
#  return result1.value
#end
#
#def sequence
#  if $currentCall.isActive
#    $color = question
#  else
#    return "call ended"
#  end
#  if $currentCall.isActive
#    final = confirm($color)
#  else
#    return "call ended"
#  end
#
#  return final
#end
#
#user = "starting"
#while user == "call ended" || user == "starting" do
#  user = sequence
#
#  if user == "call ended"
#    call "+19797396180"
#  end
#end
#
#user will have the confirmation that the variable '$color' is the users favorite color