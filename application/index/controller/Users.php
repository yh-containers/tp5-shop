<?php
namespace app\index\controller;


class Users extends Common
{
    /*
     * 收货地址
     * */
    public function addr()
    {
        $model = new \app\common\model\UserAddr();

        $list = $model->where('uid',$this->user_id)->order('is_default','desc')->order('id','desc')->select();

        return view('addr',[
            'list' => $list
        ]);
    }

    /*
     * 收货地址--添加/编辑
     * */
    public function addrAdd()
    {
        $id = $this->request->param('id');
        $model = new \app\common\model\UserAddr();

        if($this->request->isAjax()){
            $input_data = $this->request->param('','','trim');
            $input_data['uid'] = $this->user_id;

            $validate = new \app\common\validate\UserAddr();

            return $model->actionAdd($input_data,$validate);
        }
        $model = $model->where(['id'=>$id,'uid'=>$this->user_id])->find();
        return view('addrAdd',[
            'model' =>$model,
        ]);
    }

    /*
     * 收货地址--删除
     *
     * */
    public function addrDel()
    {
        $id = $this->request->param('id');

        if(empty($id)){
            return ['code'=>0,'msg'=>'删除异常'];
        }

        $model = new \app\common\model\UserAddr();
        $bool = $model->destroy(['id'=>$id,'uid'=>$this->user_id]);
        return ['code'=>$bool?1:0,'msg'=>$bool?'操作成功':'操作异常'];
    }

    /*
     * 收货地址--默认地址
     *
     * */
    public function addrDefault()
    {
        $id = $this->request->param('id');

        if(empty($id)){
            return ['code'=>0,'msg'=>'删除异常'];
        }

        $model = new \app\common\model\UserAddr();
        $bool = $model->defaultAddr($id,$this->user_id);
        return ['code'=>$bool?1:0,'msg'=>$bool?'操作成功':'操作异常'];
    }


    /*
     * 我的订单
     * */
    public function order()
    {
        $model = new \app\common\model\Order();

        $list = $model->with(['linkGoods','linkMerchant'])->where('uid',$this->user_id)->order('id','desc')->paginate(5);

        return view('order',[
            'list' =>$list,
            'page' => $list->render()
        ]);
    }

    /*
     * 我的订单-订单详情
     * */
    public function orderDetail()
    {
        $id = $this->request->param('id',0,'intval');

        $model = new \app\common\model\Order();

        $model = $model->with(['linkGoods','linkMerchant'])->where(['uid'=>$this->user_id,'id'=>$id])->find();
//        dump($model);exit;
        return view('orderDetail',[
            'model' =>$model,
        ]);
    }

    /*
     * 订单管理--催单
     * */
    public function orderReminder()
    {
        $id = $this->request->param('id',0,'intval');

        $model = new \app\common\model\Order();
        $bool = $model->reminder($this->user_id, $id);
        return ['code'=>$bool?1:0,'msg'=>$bool?'操作成功':'操作异常'];
    }

    /*
     * 订单管理--删除订单
     * */
    public function orderDel()
    {
        $id = $this->request->param('id',0,'intval');

        $model = new \app\common\model\Order();
        list($bool,$msg) = $model->del($id,$this->user_id);
        return ['code'=>(int)$bool,'msg'=>$msg];
    }

    /*
     * 订单管理--取消订单
     * */
    public function orderCancel()
    {
        $id = $this->request->param('id',0,'intval');

        $model = new \app\common\model\Order();
        list($bool,$msg) = $model->cancel($id,$this->user_id);
        return ['code'=>(int)$bool,'msg'=>$msg];
    }

    /*
     * 订单管理--取消订单
     * */
    public function orderReceive()
    {
        $id = $this->request->param('id',0,'intval');

        $model = new \app\common\model\Order();
        list($bool,$msg) = $model->receive($id,$this->user_id);
        return ['code'=>(int)$bool,'msg'=>$msg];
    }
}
