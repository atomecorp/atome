# ping example

def ping_call_back(val)
  text({ content: val, color: :red })
end
ATOME.ping("https://apple.com", "ping_call_back('Apple site is unreachable')", "ping_call_back('Apple site is up')")

