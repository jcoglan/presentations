!SLIDE frp

```coffee
irc   = require 'irc'
split = require 'split'

app = (socket, stdin, stdout, logFile) ->
```


!SLIDE frp

```coffee
irc   = require 'irc'
split = require 'split'

app = (socket, stdin, stdout, logFile) ->
    socket.pipe(split /\r\n/).on 'data', (line) ->                              #
        logFile.write "--> #{line}\n"                                           #
        msg = irc.parse line                                                    #

        switch msg.command                                                      #
            when 'NOTICE'                                                       #
                stdout.write "<#{msg.server}> #{msg.params.join ' '}\n"         #
```


!SLIDE frp

```coffee
irc   = require 'irc'
split = require 'split'

app = (socket, stdin, stdout, logFile) ->
    room = null                                                                 #

    stdin.pipe(split /\n/).on 'data', (line) ->                                 #
        if m = line.match /^\/join +(\S+)/                                      #
            room = m[1]                                                         #
            msg  = { command: 'JOIN', params: [room] }                          #
        if msg                                                                  #
            msg = irc.unparse msg                                               #
            socket.write "#{msg}\r\n"                                           #
            logFile.write "<-- #{msg}\n"                                        #

    socket.pipe(split /\r\n/).on 'data', (line) ->
        logFile.write "--> #{line}\n"
        msg = irc.parse line

        switch msg.command
            when 'NOTICE'
                stdout.write "<#{msg.server}> #{msg.params.join ' '}\n"
```


!SLIDE frp

```coffee
irc   = require 'irc'
split = require 'split'

app = (socket, stdin, stdout, logFile) ->
    room = null

    stdin.pipe(split /\n/).on 'data', (line) ->
        if m = line.match /^\/join +(\S+)/
            room = m[1]
            msg  = { command: 'JOIN', params: [room] }
        else if room and not line.match /^ *$/                                  #
            msg  = { command: 'PRIVMSG', params: [room, line] }                 #
        if msg
            msg = irc.unparse msg
            socket.write "#{msg}\r\n"
            logFile.write "<-- #{msg}\n"

    socket.pipe(split /\r\n/).on 'data', (line) ->
        logFile.write "--> #{line}\n"
        msg = irc.parse line

        switch msg.command
            when 'NOTICE'
                stdout.write "<#{msg.server}> #{msg.params.join ' '}\n"
```


!SLIDE frp

```coffee
irc   = require 'irc'
split = require 'split'

app = (socket, stdin, stdout, logFile) ->
    room = null

    stdin.pipe(split /\n/).on 'data', (line) ->
        if m = line.match /^\/join +(\S+)/
            room = m[1]
            msg  = { command: 'JOIN', params: [room] }
        else if room and not line.match /^ *$/
            msg  = { command: 'PRIVMSG', params: [room, line] }
        if msg
            msg = irc.unparse msg
            socket.write "#{msg}\r\n"
            logFile.write "<-- #{msg}\n"

    socket.pipe(split /\r\n/).on 'data', (line) ->
        logFile.write "--> #{line}\n"
        msg = irc.parse line

        switch msg.command
            when 'NOTICE'
                stdout.write "<#{msg.server}> #{msg.params.join ' '}\n"
            when 'PRIVMSG'                                                      #
                [channel, message] = msg.params                                 #
                if channel is room                                              #
                    stdout.write "#{channel} <#{msg.nick}>: #{message}\n"       #
```


!SLIDE frp

```coffee
app = (tcpIn, userIn) ->
    # ...
    [tcpOut, userOut, logs]
```


!SLIDE frp

```coffee
app = (tcpIn, userIn) ->
    ircIn     = tcpIn.map(irc.parse)                                            #

    notices   = ircIn.filter (msg) -> msg.command is 'NOTICE'                   #
                     .map    (msg) -> "<#{msg.server}> #{msg.params.join ' '}"  #

    userOut   = notices                                                         #

    logs      = tcpIn.map (line) -> "<-- #{line}"                               #

    [tcpOut, userOut, logs]
```


!SLIDE frp

```coffee
app = (tcpIn, userIn) ->
    ircIn     = tcpIn.map(irc.parse)

    rooms     = userIn.map    (line)      -> line.match /^\/join +(\S+)/        #
                      .filter (match)     -> match isnt null                    #
                      .map    ([_, room]) -> room                               #

    joinCmd   = rooms.map (room) -> { command: 'JOIN', params: [room] }         #

    notices   = ircIn.filter (msg) -> msg.command is 'NOTICE'
                     .map    (msg) -> "<#{msg.server}> #{msg.params.join ' '}"

    tcpOut    = joinCmd.map(irc.unparse)                                        #

    userOut   = notices

    logs      = tcpIn.map (line) -> "<-- #{line}"                               #
                .merge tcpOut.map (line) -> "--> #{line}"                       #

    [tcpOut, userOut, logs]
```


!SLIDE frp

```coffee
app = (tcpIn, userIn) ->
    ircIn     = tcpIn.map(irc.parse)

    rooms     = userIn.map    (line)      -> line.match /^\/join +(\S+)/
                      .filter (match)     -> match isnt null
                      .map    ([_, room]) -> room

    joinCmd   = rooms.map (room) -> { command: 'JOIN', params: [room] }

    messages  = userIn.filter (line) -> not line.match /^\/|^ *$/               #
    msgCmd    = rooms.sampleBy messages, (room, message) ->                     #
                    { command: 'PRIVMSG', params: [room, message] }             #

    notices   = ircIn.filter (msg) -> msg.command is 'NOTICE'
                     .map    (msg) -> "<#{msg.server}> #{msg.params.join ' '}"

    tcpOut    = joinCmd.merge(msgCmd).map(irc.unparse)                          #

    userOut   = notices

    logs      = tcpIn.map (line) -> "<-- #{line}"
                .merge tcpOut.map (line) -> "--> #{line}"

    [tcpOut, userOut, logs]
```


!SLIDE frp

```coffee
app = (tcpIn, userIn) ->
    ircIn     = tcpIn.map(irc.parse)

    rooms     = userIn.map    (line)      -> line.match /^\/join +(\S+)/
                      .filter (match)     -> match isnt null
                      .map    ([_, room]) -> room

    joinCmd   = rooms.map (room) -> { command: 'JOIN', params: [room] }

    messages  = userIn.filter (line) -> not line.match /^\/|^ *$/
    msgCmd    = rooms.sampleBy messages, (room, message) ->
                    { command: 'PRIVMSG', params: [room, message] }

    msgIn     = ircIn.filter (msg) -> msg.command is 'PRIVMSG'                  #
    msgInRoom = rooms.sampleBy msgIn, (room, {params}) -> room is params[0]     #
    roomMsg   = msgIn.filter msgInRoom                                          #

    notices   = ircIn.filter (msg) -> msg.command is 'NOTICE'
                     .map    (msg) -> "<#{msg.server}> #{msg.params.join ' '}"

    tcpOut    = joinCmd.merge(msgCmd).map(irc.unparse)

    userOut   = notices.merge(roomMsg)                                          #

    logs      = tcpIn.map (line) -> "<-- #{line}"
                .merge tcpOut.map (line) -> "--> #{line}"

    [tcpOut, userOut, logs]
```
