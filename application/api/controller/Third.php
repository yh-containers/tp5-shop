<?php
namespace app\api\controller;

class Third extends Common
{
    public function loginInfo()
    {
//        $redirect
    }


    public function getWechantAccessToken()
    {
        $url = $this->request->param('url');
        $server = new \app\common\server\pay\ThirdServer();
        $obj = $server->getObject(1);
        $ticket = $obj->jssdkSign($url);
        return jsonOut('获取成功',1,$ticket);
    }
}