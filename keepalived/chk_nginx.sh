netstat -lntp | grep "0.0.0.0:80" | grep -q "nginx"
#echo $?
if [ $? -ne 0 ];then
        exit 1
fi
