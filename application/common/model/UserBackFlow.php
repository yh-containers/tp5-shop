<?php
namespace app\common\model;

use think\model\concern\SoftDelete;
use think\Validate;

class UserBackFlow extends BaseModel
{
    use SoftDelete;
    protected $name = 's_user_back_flow';


    public function setImgAttr($value)
    {

        $value = is_array($value)?$value:'';
        return $value?implode(',',$value):'';
    }

    public function getImgAttr($value,$data)
    {
        return $value?explode(',',$value):[];
    }

}