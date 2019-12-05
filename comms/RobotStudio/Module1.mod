MODULE Module1
    !***********************************************************
    !
    ! Module:  Module1
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: katabeta
    !
    ! Version: 1.0
    !
    !***********************************************************
    
    
    
    !Declare variables
    VAR socketdev server_socket;
    VAR socketdev client_socket;
    VAR string receive_string;
    VAR string client_ip;
    VAR rawbytes data;

    
    
    PROC createConnection()
        SocketCreate server_socket;
        SocketBind server_socket, "127.0.0.1", 55555;
        SocketListen server_socket;

        ! Waiting for a connection request
        WHILE TRUE DO
            SocketAccept server_socket, client_socket\ClientAddress:=client_ip\Time:=WAIT_MAX;
            SocketReceive client_socket \Str := receive_string;
            SocketSend client_socket \Str := "Hello client with ip-addres " +client_ip;
            SocketClose client_socket;
        ENDWHILE
    ERROR
        RETRY;
    UNDO
        SocketClose server_socket;
        SocketClose client_socket;
    ENDPROC
    
    PROC closeConnection()
        SocketClose server_socket;
        SocketClose client_socket;
    ENDPROC
    
    PROC sendMsg(string msg)
        !Send message
        SocketSend client_socket,\Str:=msg;
    ENDPROC
    
    PROC rcvMsg()
        !Receive response
        SocketReceive client_socket,\RawData:=data;
        UnpackRawBytes data,1,receive_string,\ASCII:=15;
    ENDPROC
    
    
    !***********************************************************
    !
    ! Procedure main
    !
    !   This is the entry point of your program
    !
    !***********************************************************
    PROC main()
        createConnection;
        sendMsg("Hello MATLAB from RobotStudio!");
        rcvMsg;
        closeConnection;
    ENDPROC
    
    
    
    
ENDMODULE