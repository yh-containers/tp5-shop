<?php
namespace app\common\validate;

use think\Validate;

class OrderGoodsBack extends Validate
{
    protected $rule = [
        'id'        =>  'require|gt:0',
        'logistics_name'        =>  'require|min:1',
        'logistics_no'        =>  'require|min:1',


        'fid'       => 'checkReply',
        'content'   =>  'require|length:10,200|token',
//        'img'       =>  'require'
    ];

    protected $message  =   [
        'content.require'   => '理由必须输入',
        'content.length'    => '理由字符长度必须在 :1-:2之间',
        'content.token'     => '请刷新页面重新尝试',
        'img.require'       => '请上传图片',

        'id.require'        => '操作流程异常',
        'id.gt'             => '数据异常 :rule',
        'logistics_name.require'             => '请输入物流名',
        'logistics_name.min'=> '物流名称字符长度必须超过 :rule 位',
        'logistics_no.require'=> '请输入物流单号',
        'logistics_no.min'  => '请输入物流单号字符长度必须超过 :rule 位',
    ];


    protected $scene = [
        'default' => ['fid','content'],
        'add_logistics' => ['id','logistics_name','logistics_no'],
        'rec_logistics' => ['id']
    ];

    public function checkReply($value)
    {
        if($value) {
            $model = model('OrderGoodsBack');//new \app\common\model\OrderGoodsBack();
            $model_info = $model->find($value);
            if(empty($model_info)){
                return '操作对象异常';

            }elseif (empty($model_info['status'])){
                return '流程已取消，无法进行此操作';

            }elseif ($model_info['status']==4){
                return '流程已完成，无法进行此操作';
            }
        }
        return true;
    }

    /*
     * 场景验证
     * */
    public function sceneAddLogistics()
    {
        $this->only(['id','logistics_name','logistics_no']);


    }
}
