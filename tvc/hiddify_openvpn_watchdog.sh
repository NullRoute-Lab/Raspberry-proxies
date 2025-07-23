#!/bin/sh

CONF_FILE="/root/hiddify-openvpn-conf.json"
RUN_CMD="./HiddifyCli run --config /root/hiddify-sub --hiddify $CONF_FILE"
WEB_SECRET=$(jq -r '.["web-secret"]' "$CONF_FILE")

curl -L -o /root/hiddify-sub $SUB_URL
while true; do
    # Check if HiddifyCli is running
    if ! pgrep -fl HiddifyCli &>/dev/null; then
        echo "HiddifyCli is not running. Restarting..."
        (cd "$SERVICE_DIR" && nohup $RUN_CMD > /dev/null 2>&1 &)
        # sleep 600
    # else
    #     echo "Checking HiddifyCli response..."
    #     HTTP_RESPONSE_PROXY=$(curl -s --connect-timeout 5 --max-time 10 --retry 3 --retry-delay 0 --retry-max-time 30 --proxy http://127.0.0.1:2334 http://www.gstatic.com/generate_204 -o /dev/null -w "%{http_code}")
    #     if [ "$HTTP_RESPONSE_PROXY" -ne 204 ]; then
    #         echo "Proxy is not responding. Making HTTP call to switch group..."
    #         curl -X GET "http://127.0.0.1:6756/group/select/delay?url=http://www.gstatic.com/generate_204&timeout=2000" \
    #             -H "Authorization: Bearer $WEB_SECRET" &
    #         sleep 240
    #     fi
    fi

    # Check if OpenVPN is running
    if ! pgrep -fl /usr/sbin/openvpn &>/dev/null; then
        HTTP_RESPONSE_PROXY=$(curl -s --proxy http://127.0.0.1:2334 http://www.gstatic.com/generate_204 -o /dev/null -w "%{http_code}")
        if [ "$HTTP_RESPONSE_PROXY" -eq 204 ]; then
            echo "OpenVPN is not running. Restarting..."
            nohup /usr/sbin/openvpn /root/openvpn/vpn.ovpn > /dev/null 2>&1 &
        fi
        # sleep 60
    # else
    #     echo "Checking OpenVPN response..."
    #     # Check if tun0 is up using ifconfig
    #     TUN0_STATUS=$(ifconfig tun0 2>/dev/null | grep 'UP' | wc -l)

    #     if [ "$TUN0_STATUS" -eq 0 ]; then
    #         echo "OpenVPN is not responding. Restarting..."
    #         killall openvpn
    #         sleep 10
    #         nohup /usr/sbin/openvpn /root/openvpn/vpn.ovpn > /dev/null 2>&1 &
    #         sleep 60
    #     fi
    fi

    echo "HiddifyCli and OpenVPN processes are checked."
    sleep 5
done
