Status Codes
-----------
Allows you to communicate information effectively with both human and browser

Classes:

|Status #|Code |Description|
|-----|-----|-----|
|1|1xx: Informational | request received and continuing process|
|2|2xx: Success | request successfully received, understood and accepted|
|3|3xx: Redirection | further action must be taken to complete requst |
|4|4xx: Client Error | request contains bad syntax and can't be completed |
|5|5xx: Server Error | server couldn't complete reqeust |

```ruby
class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path=="/songs"
      resp.write "You requested the songs"
    else
      return [404, {}, ["Route not found"]]
      # The above replaces these two lines
      # resp.write "Route not found"
      # resp.status = 404
    end
    resp.finish

  end
end
```
