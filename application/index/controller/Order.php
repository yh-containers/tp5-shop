<?php
namespace app\index\controller;

class Order extends Common
{

    //创建订单
    public function create()
    {
        //发票类型

        $invoice_type = $this->request->param('type',0,'intvao');
        $input_data = $this->request->post();
        try{
            $order_model = new \app\common\model\Order();
            $order_id=$order_model->generatorOrder($this->user_id,$input_data,$invoice_type);


        }catch (\Exception $e) {
            $this->error($e->getMessage());
        }

        $this->redirect('Order/pay',['order_id'=>$order_id]);

    }

    //订单支付
    public function pay()
    {
        $order_id = $this->request->param('order_id');
        $order_model = new \app\common\model\Order();
        if(strpos($order_id,'_')){
            $order_id = explode('_',$order_id);
        }
        //设置订单信息
        $order_model->setOrderInfo($order_id);
//        $order_model->data($order_info);
//        dump($order_model->getData());exit;
//        dump($order_info);exit;
        if(empty($order_model->getOrderInfo())) {
            $this->error('订单信息异常');
        }
        //处理订单支付信息
        $order_model->handleOrderPayInfo();
//        dump($order_model->getOrderNo());exit;
//        print_r();exit;
        $pay_server = new \app\common\server\pay\ThirdServer();
        try{
            $pay_mode = 'NATIVE';
            $result = $pay_server->payInfo($order_model, 'NATIVE');
        }catch (\Exception $e) {
            return $this->display($pay_mode.'支付信息异常'.$e->getMessage());
        }
        return view('pay',[
            'pay_info'   => $order_model->getPayData(),
            'code_url'      => base64_encode($result['code_url'])
        ]);
    }


    //订单回调
    public function notify()
    {
        $order_id = $this->request->param('order_id');
        $model = $this->request->param('model','','trim');
        $class = '\\app\\common\\model\\'.$model;
        if(strpos($order_id,'_')){
            $order_id = explode('_',$order_id);
        }

        $order_model = new $class();
        $order_model->setOrderInfo($order_id);

        if(empty($order_model->getOrderInfo())) {
            return '订单信息异常';
        }

        //处理订单支付信息
        $order_model->handleOrderPayInfo();

        $pay_server = new \app\common\server\pay\ThirdServer();

        return $pay_server->payNotify($order_model);


    }

}