<?php
namespace app\common\server\pay;

/*
 * 获取订单支付信息
 * */

use app\common\model\traits\Pay;
use think\Model;

class ThirdServer
{
    private $third_server;
    //第三方配置信息
    protected $third_config=[];





    public static $pay_class =[
        [],
        //微信支付
        [
            'key' => 'wechat',
            'name' => '微信',
            'lang' => 'g_pay_wechat',
            'class'=>'\app\common\server\pay\Wechat',
            'config'=>[
                //键的值仅供测试使用
                'appid'=>'wx426b3015555a46be',
                'mchid'=>'1900009851',
                'key'=>'8934e7d15453e97507ef794cf7b0519d',
                'appsecret'=>'7813490da6f1265e4901ffb80afaa36f',
            ]
        ],
        //支付宝
        [
            'key'=>'alipay',
            'name' => '支付宝',
            'lang' => 'g_pay_alipay',
            'class'=>'\app\common\server\pay\AliPay',
            'config'=>[
                'gateway_url'   =>  'https://openapi.alipay.com/gateway.do',
                'app_id' =>  '2018081561077852',
                'merchant_private_key'   =>  '',
                'alipay_public_key'   =>  '',
                'pid'   =>  '',
            ]
        ]
    ];


    /*
     * 支付信息
     * @param $opt_obj Model 模型对象
     * @param $pay_mode string 支付模式 APP-app支付 NATIVE--二维码
     * */
    public function payInfo(Model $opt_obj,$pay_mode)
    {
        //获取第三方模式
        $third_id = $opt_obj->getPayId();
        //创建服务对象
        $this->_createServer($third_id);
        //设置回调通知地址
        $obj_class_name = class_basename($opt_obj);
        $notify_url = url('Index/Order/notify',['order_id'=>$opt_obj->getPrimaryKeyValue(),'model'=>$obj_class_name],false,true);
//        dump($notify_url);exit;
        //设置通知地址
        $this->third_server->setNotifyUrl($notify_url);
        //设置订单有效时长
        $this->third_server->setOrderExpress(1800);
        //支付操作

        $result = $this->third_server->pay($opt_obj,$pay_mode);

        return $result;
    }


    /*
     * 处理回调
     * @param $opt_obj Model 模型对象
     * @param $pay_mode string 支付模式 APP-app支付 NATIVE--二维码
     * */
    public function payNotify(Model $opt_obj)
    {
        //获取第三方模式
        $third_id = $opt_obj->getPayId();
        //创建服务对象
        $this->_createServer($third_id);
        //支付操作
//        try{
            //验证支付是否完成
            $state = $opt_obj->checkOrderStatus();
            if(!$state) {

                $pay_info = $this->third_server->notify();
                //处理通知数据
                $opt_obj->handleOrderComplete($pay_info);
            }
            //回调响应
            return $this->third_server->responseInfo();
//        } catch (\Exception $e){
//            trace(40060,'通知回调异常:'.$e->getMessage());
//
//        }
    }

    /*
     * 获取配置信息
     * */
    public function getConfig()
    {
        return model('ThirdConfig')->getContent($this->third_config['key']);
    }

    private function _createServer($third_id)
    {
        if(empty($third_id) || empty(self::$pay_class[$third_id])){
            abort(40040, lang('e_class_no_exist'));
        }

        $this->third_config = self::$pay_class[$third_id];
        //获取配置信息
        $config = $this->getConfig();
        //合并配置
        if(!empty($config)) {
            $this->third_config['config']=array_merge($this->third_config['config'], $config);
        }

        $class = $this->third_config['class'];
        $this->third_server = new $class($this->third_config['config']);
    }
}



