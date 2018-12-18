<?php
namespace app\auth\controller;

use think\Controller;
use think\Request;

class Index extends Controller
{
    public function index()
    {
        return '123';
    }

    public function login()
    {
        $app_id = $this->request->get('app_id');
        $redirect_url = $this->request->get('redirect_url');
        return view('/login',[
            'app_id' => $app_id,
            'redirect_url' => $redirect_url
        ]);
    }

    public function loginAction()
    {
        $app_id = $this->request->param('app_id');
        $redirect_url = $this->request->param('redirect_url','','urldecode');
        $name = $this->request->param('name');
        $password = $this->request->param('password');
        $result = go_curl('http://app.uumhome.com/api.php/Public/login/username/'.$name.'/password/'.$password);
        if(is_bool($result)){
            $this->error('授权接口异常!');
        }else{
            $info= json_decode($result,true);

            if($info['error_code']!=1) {
                $this->error($info['message']);
            }
            //登录信息
            $data = $info['data'];
            $redirect_url .='?user_id='.$data['uid'].'&token='.$data['token'];
            $this->redirect($redirect_url);
        }
    }
}