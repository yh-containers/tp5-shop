<?php
namespace app\admin\controller;

use app\common\server\pay\ThirdServer;

class Order extends Shop
{
    public function index()
    {
        $order_state = $this->request->param('order_state',0,'intval');
        $order_model = new \app\common\model\Order();
        $list = $order_model->order('id', 'desc')->paginate();
        return view('index',[
            'list'  => $list,
            'page'  => $list->render(),
            'pay_way' => ThirdServer::$pay_class,
            'btn_order_status' => $order_model::$btn_order_status,
            'order_state'   => $order_state
        ]);
    }

    //详情
    public function detail()
    {
        $id = $this->request->param('id',0,'intval');
        $order_model = new \app\common\model\Order();
        $order_model = $order_model->with(['linkGoods'])->where('id','=',$id)->find();

        //优惠券
        $invoice = $order_model->getData('invoice');
        $model_invoice = new \app\common\model\UserInvoice();
        $invoice_type = $invoice?$invoice['type']:false;
        $data_invoice = [];//发票信息
        if($invoice_type!==false) {
            $data_invoice = $model_invoice->getInvoiceInfo($invoice_type,$invoice);

        }
//        dump($data_invoice);exit;
        return view('detail',[
            'order_model' => $order_model,
            'data_invoice' => $data_invoice
        ]);
    }
}

