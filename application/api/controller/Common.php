<?php
namespace app\api\controller;

use think\App;
use think\Container;

class Common
{
    protected $app;
    /**
     * Request实例
     * @var \think\Request
     */
    protected $request;

    public function __construct(App $app = null)
    {
        $this->app = $app?:Container::get('app');
        $this->request = $this->app['request'];
    }



    /*
     * 处理数据
     * */
}