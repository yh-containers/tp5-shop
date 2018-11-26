<?php
namespace app\index\controller;

use think\Controller;

class Common extends Controller
{
    protected $user_id =0;

    public function initialize()
    {
        $this->user_id = 1;
        //绑定用户信息
        bind('container_user_id',function(){
            return $this->user_id;
        });
    }
}