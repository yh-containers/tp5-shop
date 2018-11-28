<?php
namespace app\common\model;

use think\model\concern\SoftDelete;
use think\Validate;

class OrderGoodsBack extends BaseModel
{
    use SoftDelete;
    protected $name = 's_order_goods_back';

    protected $insert = ['no','status'=>1];



    public static $btn_order_status = ['全部','待审核','已处理','已完成'];

    public static function init()
    {
        self::event('after_update', function ($model) {
            $origin_data = $model->getOrigin();
            if (!empty($origin_data) && $origin_data['status']!=$model['status']) { //数据发生变动 且状态变化

                $flow_model = new UserBackFlow();
                if($model['status'] == 0) {
                    $flow_model->save([
                        'fid' => $model['id'],
                        'content' => '已取消退货申请'
                    ]);
                }elseif($model['status'] == 1){
                    $flow_model->save([
                        'fid' => $model['id'],
                        'content' => '创建退货申请流程'
                    ]);
                }elseif($model['status'] == 2){
                    $flow_model->save([
                        'fid' => $model['id'],
                        'content' => '开放发货申请'
                    ]);
                }elseif($model['status'] == 3){
                    $flow_model->save([
                        'fid' => $model['id'],
                        'content' => '您的申请被拒'
                    ]);
                }elseif($model['status'] == 4){
                    $flow_model->save([
                        'fid' => $model['id'],
                        'content' => '退货流程已完成'
                    ]);
                }
            }elseif (!empty($origin_data) && !empty($model['send_time'])) {
                //发货时间变化
                $flow_model = new UserBackFlow();
                if(!$origin_data['is_send']) {
                    $flow_model->save([
                        'fid' => $model['id'],
                        'content' => '添加物流信息'
                    ]);
                }elseif($model['is_send']==1){
                    $flow_model->save([
                        'fid' => $model['id'],
                        'content' => '更新物流信息'
                    ]);
                }elseif($model['is_send']==2){
                    $flow_model->save([
                        'fid' => $model['id'],
                        'content' => '商家确定收货'
                    ]);
                }
            }
        });
    }

    //设置订单编号--最短 22
    public function setNoAttr($value)
    {

        if($value) {
            return $value;
        }

        $cache_name = 'back_flow'.date('Y-m-d');
        $number = cache($cache_name);
        if(!$number) {
            $number = 0;
            cache($cache_name,$number,86400);
        }
        $number = $number+1;
        //再次缓存
        cache($cache_name,$number);
        $no = date('YmdHis').rand(100,999).sprintf('%05d',$number);
        return $no;
    }

    /*
     * 获取状态
     * */
    public function getFlowStatusAttr($value,$data)
    {
        $str = '';
        if($data['status']==0) {
            $str = '已取消';
        }elseif($data['status']==1) {
            $str = '待审核';
        }elseif($data['status']==2) {
            $str = '已审核';
            if($data['is_send']==1) {
                $str .=',已发送';
            }else {
                $str .= ',待发送';
            }
        }elseif($data['status']==3) {
            $str = '已审核,申请被拒';
        }elseif($data['status']==4) {
            $str = '已审核,已完成';
        }
        return $str;
    }

    /*
     * 查看退货状态
     * again - 再次申请
     * cancel-取消
     * send-允许发货
     * change_send-修改发货信息
     * complete-订单完成
     * */
    public function getBackStateAttr($value,$data)
    {
        $msg = [];
        if ($data['status']==0) {
            $msg = ['申请已取消',['again']];
        } elseif ($data['status']==1) {
            $msg = ['申请中',['cancel']];
        } elseif ($data['status']==2) {
            $msg = ['允许退货',['cancel']];
            if($data['is_send']==1) {
                array_push($msg[1],'change_send');
            }elseif($data['is_send']==2) {//商家已收货
                $msg = ['商家已收货',['complete']];
            }else {
                array_push($msg[1],'send');
            }
        } elseif ($data['status']==3) {
            $msg = ['申请被拒',['again']];
        } elseif ($data['status']==4) {
            $msg = ['流程已完成',[]];
        }
        return $msg;
    }




    /*
     * 退货流程入库
     * */
    public function handleFlow($user_id,$fid,$input_data)
    {
        $validate = new \app\common\validate\OrderGoodsBack();
        $validate->scene('default');
        if($validate && !$validate->check($input_data)){
            return [false,$validate->getError()];
        }



        try{
            $model = $this;
            $this->startTrans();
            if($fid) {
                $model = $this->find($fid);
                empty($model) && abort(200,'退货流程异常');
            }else{
                $this->save([
                    'uid'   => $user_id,
                    'og_id' => $input_data['og_id'],//订单关联商品表的主键
                ]);

            }

            $model->linkFlow()->save([
                'content'   => empty($input_data['content'])?'':$input_data['content'],
                'img'       => empty($input_data['img'])?'11232':$input_data['img']
            ]);
            $this->commit();
            return [true,''];
        }catch (\Exception $e) {
            $this->rollback();
            return [false, $e->getMessage()];
        }

    }

    /*
     * 操作流程
     * @param $status int  0-取消发货 2-发货 3申请被拒绝 4完成
     * */
    public function optFlow($id,$status=0)
    {

        $time_fields = ['cancel_time','create_time','auth_time','auth_time','complete_time'];

        if(!array_key_exists($status,$time_fields)) {
            return [false, '操作异常'];
        }

        $model = $this->find($id);

        $model->status = $status;
        $model->$time_fields[$status] = time();
        $bool = $model->save();
        return [$bool,''];
    }


    /*
     * 订单-退款流程
     * */
    public function linkFlow()
    {
        return $this->hasMany('UserBackFlow','fid');
    }

}