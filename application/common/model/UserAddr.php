<?php
namespace app\common\model;

use think\Db;
use think\model\concern\SoftDelete;
use think\Validate;

class UserAddr extends BaseModel
{
    use SoftDelete;
    protected $name = 's_user_addr';
    public static $fields_status = ['','正常','关闭'];


    //默认地址数据
    public function defaultAddr($id,$user_id)
    {
//        $model = new \app\common\model\UserAddr();
//        $model->where(['uid'=>$user_id,'is_default'=>1])->setField('is_default',0);
//        $default_state = $model->where(['uid'=>$user_id,'id'=>$id])->setField('is_default',1);
        $bool = $this->update([
            'is_default'=> Db::raw('if(id='.$id.',1,0)')
        ],[
            'uid'=>$user_id
        ]);
        return $bool;
    }

    //获取地址--一条数据
    public function addrWeight($user_id,$addr_id=0)
    {
        $where[] = ['uid','=',$user_id];
        $addr_id && $where[] = ['id','=',$addr_id];
        $info = $this->where($where)->order('is_default','desc')->order('id','desc')->find();
        return $info;
    }
}