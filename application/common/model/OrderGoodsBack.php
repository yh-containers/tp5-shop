<?php
namespace app\common\model;

use think\model\concern\SoftDelete;
use think\Validate;

class OrderGoodsBack extends BaseModel
{
    use SoftDelete;
    protected $name = 's_order_goods_back';

    public function setImgAttr($value)
    {
        return implode(',',$value);
    }

    public function getImgAttr($value,$data)
    {
        return explode(',',$value);
    }

}