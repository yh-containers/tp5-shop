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

    //退货信息
    public function refundGoods()
    {
        $keyword = $this->request->param('keyword','','trim');
        $order_state = $this->request->param('order_state',0,'intval');
        $back_model = new \app\common\model\OrderGoodsBack();
        $where = [];
        $keyword &&  $where[] = ['no','like','%'.$keyword.'%'];
        if($order_state==1) {
            $where[]=['status','=',1];

        }elseif ($order_state==2) {//已处理
            $where[]=['status','>',1];

        }elseif ($order_state==3) {//已完成
            $where[] = ['status','=',4];
        }
        $list = $back_model->where($where)->order('id', 'desc')->paginate();

        return view('refundGoods',[
            'list'  => $list,
            'page'  => $list->render(),
            'btn_order_status' => $back_model::$btn_order_status,
            'order_state'   => $order_state,
            'keyword'   => $keyword,
        ]);

    }

    //退货信息-详情
    public function refGoodsDetail()
    {
        $id = $this->request->param('id');
        $model = new \app\common\model\OrderGoodsBack();

        $model_info = $model->with(['linkFlow'=>function($query){
            $query->order('id','asc');
        }])->where('id',$id)->order('id','desc')->find();
        return view('refGoodsDetail',[
            'model_info'    =>  $model_info,
        ]);
    }

    //审核退货流程
    public function refGoodsAuth()
    {
        $id = $this->request->param('id');
        $status = $this->request->param('status');
        if($status==1) {//通过
            $status=2;
        }else{//拒绝
            $status=3;
        }
        $model = new \app\common\model\OrderGoodsBack();
        list($bool,$msg) = $model->optFlow($id,$status);
        return ['code'=>$bool?1:0,'msg'=>$bool?'操作成功':$msg];
    }



    /*
     * 商品退货提交
     * */
    public function reqGoodsBackAction()
    {
        $input_data = $this->request->param();
        $id = $this->request->param('id',0,'intval');
        $model = new \app\common\model\OrderGoodsBack();
        list($bool, $msg) = $model->handleFlow(0,$id, $input_data);
        return ['code'=>$bool?1:0,'msg'=>$bool?'操作成功':$msg];
    }

    /*
     * 商品退货提交
     * */
    public function reqGoodsBackRecAction()
    {
        $id = $this->request->param('id',0,'intval');
        $model = new \app\common\model\OrderGoodsBack();
        $input_data['id'] = $id;
        $input_data['is_send'] = 2;//确认收货
        $input_data['rec_time'] = time();
        $validate = new \app\common\validate\OrderGoodsBack();
        $validate->scene('rec_logistics');

        return $model->actionAdd($input_data,$validate);
    }
}

