function st 
    switch $argv[1]
        case start
            brew services start syncthing
        case stop
            brew services stop syncthing
        case restart
            brew services restart syncthing
        case status
            brew services info syncthing
        case '*'
            echo "Usage: st {start|stop|restart|status|log}"
    end
end
